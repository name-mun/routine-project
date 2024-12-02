//
//  DatePickerCollectionViewCell.swift
//  Routine
//
//  Created by t2023-m0072 on 11/1/24.
//

import UIKit
import SnapKit

//MARK: - RoutineBoardCollectionViewCell

class RoutineBoardCollectionViewCell: UICollectionViewCell {
    
    override var reuseIdentifier: String? { "RoutineBoardCollectionViewCell" }
    
    static let borderWidth: CGFloat = 1
    static let cornerRadius: CGFloat = 20
    
    private var routine: RoutineData?
    
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
        imageView.image = UIImage(systemName: "minus.circle")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .red
        imageView.isHidden = true
    }
    
    private let imageView = UIImageView().then { imageView in
        imageView.contentMode = .bottom
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
    }
    
    private var isViewSetUp: Bool = false
    //
    //
    func setData(_ routine: RoutineData) {
        self.routine = routine
        
        if !isViewSetUp {
            setUpUI()
        }
        
        updateData()
    }
    //
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
        self.stopMarkView.isHidden = true
    }
}


//MARK: - Update Data
extension RoutineBoardCollectionViewCell {
    
    //뷰에 루틴 데이터 적용
    private func updateData() {
        guard let routine = routine else { return }
        
        updateBackgroundColor(routine.color)
        updateTitleLabel(routine.title)
        updateStickerImageView(routine.sticker)
        updateStopMarkView(routine.stop2 != nil)
    }
    
    private func updateBackgroundColor(_ color: BoardColor) {
        self.backgroundColor = .orange
    }
    
    private func updateTitleLabel(_ title: String) {
        self.titleLabel.text = title
    }
    
    private func updateStickerImageView(_ assetName: AssetName) {
        guard let stickerImage = UIImage(named: assetName) else {
            return
        }
        
        self.imageView.image = stickerImage
    }
    
    private func updateStopMarkView(_ stop: Bool) {
        stopMarkView.isHidden = false
    }
    
}





//MARK: - Preview
#Preview("MainRoutineBoardViewController") {
    MainRoutineViewController()
}

