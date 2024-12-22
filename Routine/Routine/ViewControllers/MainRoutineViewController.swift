//
//  MainRoutineBoardView.swift
//  Routine
//
//  Created by t2023-m0072 on 11/9/24.
//

import UIKit

import SnapKit

// MARK: - MainRoutineViewController

// 루틴 메인 화면 ViewController
class MainRoutineViewController: UIViewController {
    
    private let wholeDataManager = WholeDataManager.shared

    // 프로퍼티 옵저버를 통해 데이터가 변하기 전 자동으로 코어데이터에 값을 저장시킨다.
    // TODO: 마지막으로 누른 셀의 경우 데이터가 제대로 저장되지 않는 오류 발생
    // willSet / didSet 모두 적용시키면 정상 작동하지만 원인을 파악하지 못함
    private var wholeDatas: [WholeData] = [] {
        willSet {
            saveWholeDatas()
        } didSet {
            saveWholeDatas()
        }
    }
    
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
    }
    
}

// MARK: - 기본 설정 메서드

extension MainRoutineViewController {
    
    // 전체 레이아웃 설정
    private func configureUI() {
        
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
        saveWholeDatas()
        
        let datas = wholeDataManager.read(at: date)
        self.wholeDatas = datas
        self.routineCollectionView.reloadData()
    }
    
    private func saveWholeDatas() {
        wholeDatas.forEach { wholeData in
            wholeDataManager.update(wholeData)
        }
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
        routineCollectionView.delegate = self
        
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
        guard wholeDatas.count-1 >= index else {
            return RoutineCollectionViewCell()
        }
        
        let wholeData = wholeDatas[index]
        routineCollectionViewCell.configurePosition(index: indexPath.item, countOfData: wholeDatas.count)
        routineCollectionViewCell.configureData(wholeData)
        
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
            return wholeDatas.count
            
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

// MARK: - MainRoutineViewController - Delegate

extension MainRoutineViewController: UICollectionViewDelegate {
    
    // 셀이 선택되기 전 호출 메서드
    // 해당 셀의 결과값을 전환시킨다
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let cell = collectionView.cellForItem(at: indexPath) as? RoutineCollectionViewCell else { return false }
        let index = indexPath.item
        var result = wholeDatas[index].result
        result.toggle()
        self.wholeDatas[index].result = result
        cell.configureData(wholeDatas[index])
        return false
    }
    
}
