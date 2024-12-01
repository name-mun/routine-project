//
//  MainVIewDateCollectionView.swift
//  Routine
//
//  Created by t2023-m0072 on 11/17/24.
//

import UIKit
import SnapKit
import Then

//Data 저장형식 선정
/*
 MARK: - Data 저장형식 선정
 
 MARK: - 1.User Defaults
 
 MARK: - 2.Core Data
 
 MARK: - 3.Key Chains
 
 */

//MARK: - MainDateCollectionViewCell

class MainViewDateCollectionViewCell: UICollectionViewCell {
  
  //루틴 실행 결과 반영 필요.
  private var date: Date?
  
  private let dateButton = UIButton().then { button in
//    button.alig = .center
    button.backgroundColor = .white
    button.contentMode = .scaleAspectFit
  }
  
  private let dateLabel = UILabel().then { label in
    label.text = "0"
    label.textColor = .black
    label.backgroundColor = .white
    label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    setUpUI()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUpUI()
  }
  
  func setDate(_ date: Date) {
    self.date = date
  }
  
}

//MARK: - Set Up UI

extension MainViewDateCollectionViewCell {
  
  private func setUpUI() {
    
  }
  
  private func setUpButton() {
    self.addSubview(dateButton)
    
    dateButton.snp.makeConstraints { button in
      button.centerX.centerY.equalToSuperview()
      
    }
  }
  
  private func buttonCornerRound() {
    let width = dateButton.frame.size.width
    
    dateButton.clipsToBounds = true
    dateButton.layer.cornerRadius = width / 2
  }
}
//
//struct SuggesionData {
//  var sectionTitle: String
//  var subTitle: String
//  
//  var data: [RoutineData]
//}
//
//let morningRoutine = SuggesionData(sectionTitle: <#T##String#>, subTitle: <#T##String#>, data: <#T##[RoutineData]#>)
