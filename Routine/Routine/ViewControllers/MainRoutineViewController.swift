//
//  MainRoutineBoardView.swift
//  Routine
//
//  Created by t2023-m0072 on 11/9/24.
//

import UIKit
import SnapKit
import Then

//MARK: - MainRoutineViewController

// 루틴 메인 화면 ViewController
class MainRoutineViewController: UIViewController {
  
  //private var routineData: [RoutineData] = MockData.routines

  private let routineCollectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: UICollectionViewFlowLayout())
    .then { collectionView in
      collectionView.backgroundColor = .clear
      collectionView.isEditing = false
      collectionView.showsVerticalScrollIndicator = false
    }
  
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
    
    switch collectionView {
    case self.routineCollectionView:
      return 0 //routineData.count

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
  
  //    func coll
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
      collectionView.leading.trailing.equalToSuperview().inset(collectionViewConstantAbs)
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
                                        forCellWithReuseIdentifier: "RoutineBoardCollectionViewCell")
  }
  
  
  //루틴보드 컬렉션 뷰 플로우 레이아웃 -> AI 작성 코드 사용 금지 절대 직접 재구현
  private func setRoutineBoardFlowLayout() {
    
    let width = (UIScreen.main.bounds.width - 2 * collectionViewConstantAbs)/3
    let height = (UIScreen.main.bounds.width - 2 * collectionViewConstantAbs)/3 * 1.1
    
    let snakeLayout = SnakeFlowLayout()
    snakeLayout.itemSize = CGSize(width: width, height: height)
    snakeLayout.minimumInteritemSpacing = 0
    snakeLayout.minimumLineSpacing = 20
    snakeLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    
    self.routineCollectionView.collectionViewLayout = snakeLayout
  }
}


//MARK: - 루틴보드 컬렉션 뷰

extension MainRoutineViewController {
  private func routineBoardCollectionViewCell(_ indexPath: IndexPath) -> RoutineBoardCollectionViewCell {
    
    guard let routineBoardCollectionViewCell = self.routineCollectionView.dequeueReusableCell(withReuseIdentifier: "RoutineBoardCollectionViewCell", for: indexPath) as? RoutineBoardCollectionViewCell else {
      return RoutineBoardCollectionViewCell()
    }
    
    // let index = indexPath.item
    
//    guard self.routineData.count-1 >= index else { return RoutineBoardCollectionViewCell() }
//    
//    let data = self.routineData[index]
//    
//    routineBoardCollectionViewCell.setData(data)
//    routineBoardCollectionViewCell.setIndex(dataCount: routineData.count, index: index)
    
    return routineBoardCollectionViewCell
  }
}


//MARK: -
#Preview("MainRoutineViewController") {
  let viewController = MainRoutineViewController()
  return viewController
}
