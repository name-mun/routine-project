//
//  DatePickerCollectionViewCell.swift
//  Routine
//
//  Created by t2023-m0072 on 11/1/24.
//

import UIKit
import SnapKit
import Then

//MARK: - RoutineBoardCollectionViewCell

class RoutineBoardCollectionViewCell: UICollectionViewCell {
  
  override var reuseIdentifier: String? { "RoutineBoardCollectionViewCell" }
  
  static let borderWidth: CGFloat = 1
  static let cornerRadius: CGFloat = 20
  
  private var data: RoutineData?
  
  private var stackView = UIStackView().then { stackView in
    stackView.backgroundColor = .clear
    stackView.alignment = .center
    stackView.axis = .vertical
  }
  
  private let titleLabel = UILabel().then { titleLabel in
    titleLabel.backgroundColor = .clear
    titleLabel.textColor = .black
    titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
    titleLabel.textAlignment = .center
    titleLabel.numberOfLines = 3
  }
  
  private let stopMarkView = UIImageView().then { imageView in
    imageView.backgroundColor = .clear
    imageView.image = nil
    imageView.contentMode = .scaleAspectFit
    imageView.tintColor = .red
  }
  
  private let imageView = UIImageView().then { imageView in
    imageView.contentMode = .bottom
    imageView.backgroundColor = .clear
    imageView.contentMode = .scaleAspectFit
  }
  
  private var isViewSetUp: Bool = false
  
  
  func setData(_ data: RoutineData) {
    self.data = data
    
    if !isViewSetUp {
      setUpUI()
    }
    
    updateData()
  }
  
  func setIndex(dataCount: Int, index: Int) {
    let position = Position(dataCount: dataCount, index: index)
    self.layer.maskedCorners = position.maskedCorner()
  }
  
  override func prepareForReuse() {
    resetData()
    updateData()
  }
}



//MARK: - round
extension RoutineBoardCollectionViewCell {
  
  //
  private func cornerRound() {
    self.clipsToBounds = true
    self.layer.cornerRadius = Self.cornerRadius
  }
  
  private func setBorder() {
    self.layer.borderWidth = Self.borderWidth
    self.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
  }
  
  //TODO: FlowLayOut 구현 이후 리팩토링 필수 (FlowLayOut 미구현시 사용) (+마지막 셀 라운드 케이스 미구현)
  //    func maskedCorner(indexPath: IndexPath, dataCount: Int) {
  //
  //        if dataCount == 1 {
  //            return
  //        }
  //
  //        if indexPath.item == 0 {
  //            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
  //            return
  //        }
  //
  //        let row = indexPath.item / 3 % 2
  //        let position = indexPath.item % 3
  //
  //        switch (row, position) {
  //        case (0,0):
  //            self.layer.maskedCorners = [.layerMinXMaxYCorner]
  //        case (0,1), (1,1):
  //            self.layer.maskedCorners = []
  //        case (0,2):
  //            self.layer.maskedCorners = [.layerMaxXMinYCorner]
  //        case (1,0):
  //            self.layer.maskedCorners = [.layerMinXMinYCorner]
  //        case (1,2):
  //            self.layer.maskedCorners = [.layerMaxXMaxYCorner]
  //        default:
  //            return
  //        }
  //    }
  
  //TODO: FlowLayOut 구현 이후 리팩토링 필수(FlowLayOut 구현 이후 사용) (+마지막 셀 라운드 케이스 미구현)
  func maskedCorner(indexPath: IndexPath, dataCount: Int) {
    let position = Position(dataCount: dataCount, index: indexPath.item)
    self.layer.maskedCorners = position.maskedCorner()
    return
    
  }
}
//MARK: - Set Up UI
//FIXME: View를 확인하고, 반영하는 형태로 수정 필요
extension RoutineBoardCollectionViewCell {
  
  private func setUpUI() {
    guard !isViewSetUp else { return }
    
    setUpStackView()
    setUpTitleLabel()
    setUpStickerImageView()
    setUpStopMarkImageView()
    
    cornerRound()
    setBorder()
    
    isViewSetUp = true
  }
  
  //스택 뷰 UI 설정
  private func setUpStackView() {
    
    self.addSubview(stackView)
    
    stackView.snp.makeConstraints { stackView in
      stackView.top.bottom.leading.trailing.equalToSuperview()
    }
    //        print(CACornerMask.ArrayLiteralElement.self)
  }
  
  //타이틀 라벨 뷰 UI 설정
  private func setUpTitleLabel() {
    
    stackView.addArrangedSubview(titleLabel)
    
    titleLabel.snp.makeConstraints { titleLabel in
      titleLabel.leading.trailing.equalToSuperview().inset(20)
      titleLabel.height.equalToSuperview().multipliedBy(0.7)
      titleLabel.centerX.equalToSuperview()
    }
  }
  
  //스티커 이미지 뷰 UI 설정
  private func setUpStickerImageView() {
    stackView.addArrangedSubview(imageView)
    
    imageView.snp.makeConstraints { imageView in
      imageView.height.equalToSuperview().multipliedBy(0.3)
      imageView.centerX.equalToSuperview()
    }
  }
  
  private func setUpStopMarkImageView() {
    self.addSubview(stopMarkView)
    
    stopMarkView.snp.makeConstraints { imageView in
      imageView.trailing.top.equalToSuperview().inset(8)
      imageView.size.height.width.equalTo(15)
    }
  }
  
}

//MARK: - prepare for reuse

extension RoutineBoardCollectionViewCell {
  private func resetData() {
    self.imageView.image = nil
    self.titleLabel.text = nil
    self.stopMarkView.image = nil
  }
}


//MARK: - Update Data
extension RoutineBoardCollectionViewCell {
  
  //뷰에 루틴 데이터 적용
  private func updateData() {
    updateBackgroundColor()
    updateTitleLabel()
    updateStickerImageView()
    updateStopMarkView()
  }
  
  private func updateBackgroundColor() {
    self.backgroundColor = .orange
  }
  
  //타이틀 적용
  private func updateTitleLabel() {
    
    guard let title = self.data?.title else {
      print("[타이틀] 루틴 데이터가 저장되지 않았습니다.")
      return
    }
    
    guard let titleView = self.stackView.arrangedSubviews[0] as? UILabel else {
      print("[타이틀] 스택 뷰에 라벨 뷰가 존재하지 않습니다.")
      return
    }
    
    titleView.text = title
  }
  
  //스티커 이미지 적용
  private func updateStickerImageView() {
    
    guard let _ = self.data?.sticker else {
      print("[스티커] 루틴 데이터가 세팅되지 않았습니다.")
      return
    }
    
    guard let stickerImageView = self.stackView.arrangedSubviews[1] as? UIImageView else {
      print("[스티커] 스택 뷰에 이미지 뷰가 존재하지 않습니다.")
      return
    }
    
    //임의의 에셋으로 대체
    stickerImageView.image = UIImage(named: "Peatlee_ZEP")
  }
  
  //중단여부에 따라 stopMark 반영
  private func updateStopMarkView() {
    guard let data = data, data.willStop else {
      self.stopMarkView.image = nil
      return }
    
    let stopMarkImage = UIImage(systemName: "minus.circle")
    self.stopMarkView.image = stopMarkImage
    self.stopMarkView.tintColor = .black
  }
}





//MARK: - Preview
#Preview("MainRoutineBoardViewController") {
  MainRoutineViewController()
}

