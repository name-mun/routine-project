//
//  MainRoutineBoardView.swift
//  Routine
//
//  Created by t2023-m0072 on 11/9/24.
//

import UIKit

import SnapKit

#Preview {
    MainRoutineViewController()
    
}

// MARK: - MainRoutineViewController

// 루틴 메인 화면 ViewController
class MainRoutineViewController: UIViewController {
        
    // 루틴 데이터 매니저 객체
    private let routineManager = RoutineManager.shared
    
    // 루틴 데이터
    private var routineDatas: [RoutineData] = []
    
    // 뷰에 로드되는 루틴 날짜
    private var date: Date = Date.now
    
    // 캘린더 모달 버튼
    private let calendarModalButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "calendar"), for: .normal)
        button.tintColor = .black
        
        button.addTarget(nil,
                         action: #selector(calendarModalButtonTapped),
                         for: .touchUpInside)
        
        return button
    }()
    
    // 루틴 추천 모달 버튼
    private let suggestionModalButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "button"), for: .normal)
        
        button.addTarget(nil,
                         action: #selector(suggestionModalButtonTapped),
                         for: .touchDown)
        
        return button
    }()
    
    // 루틴 컬렉션 뷰
    private let routineCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: .init())
        
        collectionView.backgroundColor = .clear
        collectionView.isEditing = false
        collectionView.showsVerticalScrollIndicator = false
        
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        configureUI()
        setUpRoutineCollectionView()
                
        updateRoutineDatas()

        RoutineResultManagerTester().wholeTest()
    }
    
}

// MARK: - 기본 설정 메서드

extension MainRoutineViewController {
    
    // 전체 레이아웃 설정
    private func configureUI() {
        
        //addSubView
        [
            calendarModalButton,
            routineCollectionView,
            suggestionModalButton
        ].forEach { view.addSubview($0) }
        
        // 캘린더 모달 버튼 레이아웃
        calendarModalButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            $0.width.height.equalTo(100)
        }
        
        // 루틴 컬렉션 뷰 레이아웃
        routineCollectionView.snp.makeConstraints {
            $0.top.equalTo(300)
            $0.bottom.equalToSuperview().inset(30)
            $0.leading.trailing.equalToSuperview().inset(25)
        }
        
        // 루틴 추천 모달 버튼 레이아웃
        suggestionModalButton.snp.makeConstraints() {
            $0.bottom.trailing.equalToSuperview().inset(30)
            $0.width.height.equalTo(60)
        }
        
    }
    
    // 루틴 데이터 업데이트 및 컬렉션 뷰 새로고침
    private func updateRoutineDatas() {
        let datas = routineManager.read(date)
        
        self.routineDatas = datas
        self.routineCollectionView.reloadData()
    }
    
}


// MARK: - 버튼 액션
extension MainRoutineViewController {
        
    // 캘린더 모달 버튼 액션
    @objc
    private func calendarModalButtonTapped() {
        let calendarViewController = CalendarViewController()
        
        calendarViewController.setDate(date)
        calendarViewController.onDismiss = { [weak self] date in
            self?.updateDate(date)
        }
        
        calendarViewController.modalPresentationStyle = .pageSheet
        present(calendarViewController, animated: false)
    }
    
    // 날짜 업데이트 메서드 ( 클로저를 통해 캘린더 뷰에 바인딩 )
    private func updateDate(_ date: Date) {
        self.date = date
        updateRoutineDatas()
    }
        
    // 루틴 추천 모달 버튼 액션
    @objc
    private func suggestionModalButtonTapped() {
        let routineSuggestionView = RoutineSuggestionViewController()
        
        routineSuggestionView.onDismiss = { [weak self] in
            self?.updateRoutineDatas()
        }
        
        routineSuggestionView.modalPresentationStyle = .automatic
        present(routineSuggestionView, animated: true, completion: nil)
    }
    
}


// MARK: - 루틴 컬렉션 뷰 메서드

extension MainRoutineViewController {
    
    // 루틴 컬렉션 뷰 설정
    private func setUpRoutineCollectionView() {
        routineCollectionView.dataSource = self
        
        routineCollectionView.register(RoutineCollectionViewCell.self,
                                       forCellWithReuseIdentifier: RoutineCollectionViewCell.id)
        
        configureRoutineCollectionViewFlowLayout()
    }
    
    // 루틴 컬렉션 뷰 셀 dequeue 및 데이터 설정
    private func routineCollectionViewCell(_ indexPath: IndexPath) -> RoutineCollectionViewCell {
        guard let routineCollectionViewCell = routineCollectionView
            .dequeueReusableCell(withReuseIdentifier: RoutineCollectionViewCell.id,
                                 for: indexPath) as? RoutineCollectionViewCell else {
            return RoutineCollectionViewCell()
        }
        
        let index = indexPath.item
        guard routineDatas.count-1 >= index else {
            return RoutineCollectionViewCell()
        }
        
        let routine = routineDatas[index]
        routineCollectionViewCell.configureData(routine)
        routineCollectionViewCell.configurePosition(index: index,
                                                    countOfData: routineDatas.count)
        
        return routineCollectionViewCell
    }
    
    // 루틴 컬렉션 뷰 플로우 레이아웃 설정
    private func configureRoutineCollectionViewFlowLayout() {
        let width = ( UIScreen.main.bounds.width - 2 * 25 ) / 3
        let height = width * 1.1
        
        let snakeLayout = SnakeFlowLayout()
        snakeLayout.itemSize = CGSize(width: width, height: height)
        snakeLayout.minimumInteritemSpacing = 0
        snakeLayout.minimumLineSpacing = 20
        
        routineCollectionView.collectionViewLayout = snakeLayout
    }
    
}


// MARK: - MainRoutineViewController - DataSource

extension MainRoutineViewController: UICollectionViewDataSource {
    
    // 컬렉션 뷰 셀 수 반환 메서드 (UICollectionViewDataSource)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case self.routineCollectionView:
            return routineDatas.count
            
        default:
            return 0
        }
    }
    
    // 컬렉션 뷰 셀 반환 메서드 (UICollectionViewDataSource)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case self.routineCollectionView:
            return self.routineCollectionViewCell(indexPath)
            
        default:
            let cell = UICollectionViewCell()
            return cell
        }
    }
    
}

