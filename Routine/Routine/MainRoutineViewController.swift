//
//  MainRoutineBoardView.swift
//  Routine
//
//  Created by t2023-m0072 on 11/9/24.
//
import SwiftUI
import UIKit

class MainRoutineViewController: UIViewController {
    
    private var routineData: [RoutineData] = MockData.routines
    
    private weak var routineCollectionView : UICollectionView?
    
    private let collectionViewConstantAbs: CGFloat = 25
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        setRoutineBoardCollectionView()
    }
}

//MARK: - RoutineBoardCollectionViewController
extension MainRoutineViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return routineData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainRoutineBoardCollectionViewCell", for: indexPath) as? MainRoutineBoardCollectionViewCell else {
            let cell = UICollectionViewCell()
            cell.backgroundColor = .red
            
            return cell }
        
        let routine = self.routineData[indexPath.row]
        cell.setData(routine)
//        cell.cornerRound(indexPath: indexPath)
        
        return cell
    }
}


//MARK: - 루틴 보드 컬렉션 뷰 설정
extension MainRoutineViewController {
    
    //루틴 보드 컬렉션 뷰 설정
    private func setRoutineBoardCollectionView() {
        setUpRoutineBoardCollectionView()
        setRoutineBoardCollectionViewController()
        setRoutineBoardFlowLayout()
        registerRoutineBoardCell()
    }
    
    private func setUpRoutineBoardCollectionView() {
        let routineCollectionView = UICollectionView(frame: .zero,
                                                     collectionViewLayout: UICollectionViewFlowLayout())
        self.routineCollectionView = routineCollectionView
        
        self.view.addSubview(routineCollectionView)
        
        routineCollectionView.backgroundColor = .clear
        routineCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = routineCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10)
        let bottomConstraint = routineCollectionView.bottomAnchor.constraint(equalTo:self.view.bottomAnchor, constant: -10)
        let leadingConstraint = routineCollectionView.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant: collectionViewConstantAbs)
        let trailingConstraint = routineCollectionView.trailingAnchor
            .constraint(equalTo: self.view.trailingAnchor, constant: -collectionViewConstantAbs)
        
        NSLayoutConstraint.activate([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
    }

    //루틴 보드 컬렉션 뷰 데이터 소스 & 델리게이트 설정
    private func setRoutineBoardCollectionViewController() {
        guard let routineCollectionView = self.routineCollectionView else { return }
        routineCollectionView.delegate = self
        routineCollectionView.dataSource = self
    }
    
    //루틴 보드 컬렉션 뷰 셀 등록
    private func registerRoutineBoardCell() {
        self.routineCollectionView?.register(MainRoutineBoardCollectionViewCell.self,
                                             forCellWithReuseIdentifier: "MainRoutineBoardCollectionViewCell")
    }
    
    //루틴 보드 컬렉션 뷰 플로우 레이아웃
    private func setRoutineBoardFlowLayout() {
        guard let flowLayout = self.routineCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 0

        let width = (UIScreen.main.bounds.width - 2 * (collectionViewConstantAbs))/3
        
        flowLayout.itemSize.width = width
        flowLayout.itemSize.height = width * 1.1
    }
    
    
}


extension MainRoutineViewController {
    
}


#Preview("MainRoutineBoardViewController") {
    let viewController = MainRoutineViewController()
    return viewController
}
