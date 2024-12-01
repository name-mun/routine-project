//
//  MainRoutineBoardView.swift
//  Routine
//
//  Created by t2023-m0072 on 11/9/24.
//

import UIKit
import SnapKit

//MARK: - MainRoutineViewController

// 루틴 메인 화면 ViewController
class MainRoutineViewController: UIViewController {
    
    private var routineData: [RoutineData] = []
    
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
    
    private let dateCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        
        
        return collectionView
    }()
    
    static private let collectionViewConstantAbs: CGFloat = 25
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .gray
        setRoutineBoardCollectionView()
    }
}


//MARK: - RoutineBoardCollectionViewController
extension MainRoutineViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case self.routineCollectionView:
            return routineData.count
            
        case self.dateCollectionView:
            return 7
            
        default:
            return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case self.routineCollectionView:
            return self.routineBoardCollectionViewCell(indexPath)
            
        case self.dateCollectionView:
            return self.dateCollectionViewCell(indexPath)
            
        default:
            return UICollectionViewCell()
        }
    }
}


//MARK: - 루틴보드 컬렉션 뷰 설정

extension MainRoutineViewController {
    
    //루틴보드 컬렉션 뷰 설정
    private func setRoutineBoardCollectionView() {
        setUpRoutineBoardCollectionView()
        setRoutineBoardCollectionViewController()
        registerRoutineBoardCell()
    }
    
    //루틴보드 컬렉션 뷰 UI 설정
    private func setUpRoutineBoardCollectionView() {
        
        self.view.addSubview(routineCollectionView)
        
        routineCollectionView.snp.makeConstraints { collectionView in
            collectionView.top.equalTo(300)
            collectionView.bottom.equalTo(-30)
            collectionView.leading.trailing.equalToSuperview().inset(Self.collectionViewConstantAbs)
        }
    }
    
    //루틴보드 컬렉션 뷰 데이터 소스 & 델리게이트 설정
    private func setRoutineBoardCollectionViewController() {
        routineCollectionView.delegate = self
        routineCollectionView.dataSource = self
    }
    
    //루틴보드 컬렉션 뷰 셀 등록
    private func registerRoutineBoardCell() {
        self.routineCollectionView
            .register(RoutineBoardCollectionViewCell.self,
                      forCellWithReuseIdentifier: "RoutineBoardCollectionViewCell")
    }
    
}


//MARK: - 루틴보드 컬렉션 뷰

extension MainRoutineViewController {
    
    private func routineBoardCollectionViewCell(_ indexPath: IndexPath) -> RoutineBoardCollectionViewCell {
        
        guard let routineBoardCollectionViewCell = self.routineCollectionView.dequeueReusableCell(withReuseIdentifier: "RoutineBoardCollectionViewCell", for: indexPath) as? RoutineBoardCollectionViewCell else {
            return RoutineBoardCollectionViewCell()
        }
        
        let index = indexPath.item
        let data = self.routineData[index]
        
        routineBoardCollectionViewCell.setData(data)
        routineBoardCollectionViewCell.setIndex(dataCount: routineData.count, index: index)
        
        return routineBoardCollectionViewCell
    }
}

//MARK: -
extension MainRoutineViewController {

    private func dateCollectionViewCell(_ indexPath: IndexPath) -> MainViewDateCollectionViewCell {
        guard let mainViewDateCollectionViewCell = self.dateCollectionView.dequeueReusableCell(withReuseIdentifier: "MainViewDateCollectionViewCell", for: indexPath) as? MainViewDateCollectionViewCell else { return MainViewDateCollectionViewCell() }
        
        
        return mainViewDateCollectionViewCell
    }
}


//MARK: -
#Preview("MainRoutineViewController") {
    let viewController = MainRoutineViewController()
    return viewController
}
