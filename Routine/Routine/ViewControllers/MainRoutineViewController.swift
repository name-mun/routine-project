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

//MARK: - MainRoutineViewController

// 루틴 메인 화면 ViewController
class MainRoutineViewController: UIViewController {
    
    let goModal = UIButton()
    
    private var routineManager = RoutineManager.shared
    
    private var routineDatas: [RoutineData] = []
    
    private var date: Date = Date.now
    
    private let datePickerModalButton: UIButton = {
        let button = UIButton()
        
        let image = UIImage(systemName: "calendar")
        button.setImage(image, for: .normal)
        button.tintColor = .red
        button.addTarget(nil,
                         action: #selector(buttonTapped),
                         for: .touchUpInside)
        
        return button
    }()
    
    private let routineCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: .init())
        
        let width = ( UIScreen.main.bounds.width - 2 * collectionViewConstantAbs ) / 3
        let height = width * 1.1
        
        let snakeLayout = SnakeFlowLayout()
        snakeLayout.itemSize = CGSize(width: width, height: height)
        snakeLayout.minimumInteritemSpacing = 0
        snakeLayout.minimumLineSpacing = 20
        collectionView.collectionViewLayout = snakeLayout
        
        collectionView.backgroundColor = .clear
        collectionView.isEditing = false
        collectionView.showsVerticalScrollIndicator = false
        
        return collectionView
    }()

    static private let collectionViewConstantAbs: CGFloat = 25
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setRoutineBoardCollectionView()
        setUpButton()
        configureModalButton()
        
        routineManager.reset()
        
        configureDatas()

    }
    
}

//MARK: - Button

extension MainRoutineViewController {
    
    func setUpButton() {
        view.addSubview(self.datePickerModalButton)
        
        datePickerModalButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            $0.width.height.equalTo(100)
        }
    }
    
    @objc
    private func buttonTapped() {
        let calendarViewController = CalendarViewController()
        
        calendarViewController.modalPresentationStyle = .pageSheet
        
        
        calendarViewController.onDatePick = { [weak self] date in
            self?.dateChange(date)
        }
        
        sheetPresentationController?.detents = [.medium(), .large()]
        
        present(calendarViewController, animated: false)
    }
    
    private func dateChange(_ date: Date) {
        self.date = date
        configureDatas()
    }
    
    private func configureDatas() {
        let datas = routineManager.read(date: date)
        
        self.routineDatas = datas
        print(datas)
        self.routineCollectionView.reloadData()
    }
    
    private func configureModalButton() {
        goModal.backgroundColor = .black
        
        view.addSubview(goModal)
        
        goModal.addTarget(self, action: #selector(goNext), for: .touchDown)
        goModal.snp.makeConstraints() {
            $0.centerX.equalToSuperview()
            $0.bottom.trailing.equalToSuperview().inset(30)
        }
    }
    
    @objc
    private func goNext() {
        
        let modalVC = RoutineSuggestionViewController()
        modalVC.onDismiss = { [weak self] in
            self?.configureDatas()
        }
        
        modalVC.modalPresentationStyle = .automatic
        present(modalVC,animated: true, completion: nil)
        
    }
}

//MARK: - RoutineBoardCollectionViewController
extension MainRoutineViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case self.routineCollectionView:
            return routineDatas.count
            
        default:
            return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case self.routineCollectionView:
            return self.routineBoardCollectionViewCell(indexPath)
            
        default:
            let cell = UICollectionViewCell()
            cell.backgroundColor = .red
            return cell
        }
    }
    
}


//MARK: - 루틴보드 컬렉션 뷰 설정

extension MainRoutineViewController {
    
    //루틴보드 컬렉션 뷰 설정
    private func setRoutineBoardCollectionView() {
        setUpRoutineBoardCollectionView()
        setRoutineBoardCollectionViewController()
        setRoutineBoardFlowLayout()
        registerRoutineBoardCell()
    }
    
    //루틴보드 컬렉션 뷰 UI 설정
    private func setUpRoutineBoardCollectionView() {
        
        self.view.addSubview(routineCollectionView)
        
        routineCollectionView.snp.makeConstraints { collectionView in
            collectionView.top.equalTo(300)
            collectionView.bottom.equalTo(-30)
            collectionView.leading.trailing.equalToSuperview()
                .inset(Self.collectionViewConstantAbs)
        }
    }
    
    //루틴보드 컬렉션 뷰 데이터 소스 & 델리게이트 설정
    private func setRoutineBoardCollectionViewController() {
        routineCollectionView.delegate = self
        routineCollectionView.dataSource = self
    }
    
    //루틴보드 컬렉션 뷰 셀 등록
    private func registerRoutineBoardCell() {
        self.routineCollectionView.register(RoutineBoardCollectionViewCell.self,
                                            forCellWithReuseIdentifier: RoutineBoardCollectionViewCell.cellID)
    }
    
    
    //루틴보드 컬렉션 뷰 플로우 레이아웃
    private func setRoutineBoardFlowLayout() {}
    
}


//MARK: - 루틴보드 컬렉션 뷰

extension MainRoutineViewController {
    
    private func routineBoardCollectionViewCell(_ indexPath: IndexPath) -> RoutineBoardCollectionViewCell {
        
        guard let routineBoardCollectionViewCell = self.routineCollectionView.dequeueReusableCell(withReuseIdentifier: RoutineBoardCollectionViewCell.cellID,
                                                                                                  for: indexPath) as? RoutineBoardCollectionViewCell else {
            return RoutineBoardCollectionViewCell()
        }
        
        let index = indexPath.item
        guard self.routineDatas.count-1 >= index else {
            return RoutineBoardCollectionViewCell()
        }
        
        let routine = self.routineDatas[index]
        routineBoardCollectionViewCell.configureData(routine)
        routineBoardCollectionViewCell.configurePosition(indexPath: indexPath,
                                                         dataCount: routineDatas.count)
        
        return routineBoardCollectionViewCell
    }
}
