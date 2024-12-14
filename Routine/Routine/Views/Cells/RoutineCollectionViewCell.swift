//
//  DatePickerCollectionViewCell.swift
//  Routine
//
//  Created by t2023-m0072 on 11/1/24.
//

import UIKit

import SnapKit

//MARK: - RoutineCollectionViewCell

class RoutineCollectionViewCell: UICollectionViewCell {
    
    static let id: String = "RoutineBoardCollectionViewCell"
    static let borderWidth: CGFloat = 1
    static let cornerRadius: CGFloat = 10
    
    // 루틴 데이터
    private var routine: RoutineData?
    
    // 전체 스택 뷰
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.alignment = .center
        stackView.axis = .vertical
        return stackView
    }()
    
    // 루틴 제목 라벨 뷰
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 3
        return titleLabel
    }()
    
    // 스티커 이미지 뷰
    private let stickerView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .bottom
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    // 중단 마크 이미지 뷰
    private let stopMarkImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = .clear
        imageView.image = UIImage(systemName: "minus.circle")
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        
        return imageView
    }()
    
    /// 셀 데이터 적용
    func configureData(_ routine: RoutineData) {
        self.routine = routine
        updateData()
    }
    
    /// 셀 포지션 적용
    func configurePosition(index: Int, countOfData: Int) {
        let position = Position(index: index, countOfData: countOfData)
        layer.maskedCorners = position.maskedCorner()
    }
    
    override func prepareForReuse() {
        resetData()
        updateData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


//MARK: - 레이아웃 설정

extension RoutineCollectionViewCell {

    // UI 설정
    private func configureUI() {

        [
            stackView,
            stopMarkImageView
        ].forEach { addSubview($0) }

        [
            titleLabel,
            stickerView
        ].forEach { stackView.addArrangedSubview($0) }
        
        stackView.snp.makeConstraints { stackView in
            stackView.center.size.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { titleLabel in
            titleLabel.leading.trailing.equalToSuperview().inset(20)
            titleLabel.height.equalToSuperview().multipliedBy(0.7)
            titleLabel.centerX.equalToSuperview()
        }

        stickerView.snp.makeConstraints { imageView in
            imageView.height.equalToSuperview().multipliedBy(0.3)
            imageView.centerX.equalToSuperview()
        }

        stopMarkImageView.snp.makeConstraints { imageView in
            imageView.trailing.top.equalToSuperview().inset(8)
            imageView.size.equalTo(15)
        }

        self.clipsToBounds = true
        self.layer.cornerRadius = Self.cornerRadius

        self.layer.borderWidth = Self.borderWidth
        self.layer.borderColor = UIColor.black.cgColor
    }
    
}

//MARK: - prepare for reuse

extension RoutineCollectionViewCell {

    // 셀 데이터 초기화
    private func resetData() {
        routine = nil
        backgroundColor = .clear
        stickerView.image = nil
        titleLabel.text = nil
        stopMarkImageView.isHidden = true
    }

}


//MARK: - Update Data

extension RoutineCollectionViewCell {

    // 뷰에 루틴 데이터 적용
    private func updateData() {
        guard let routine = routine else { return }

        updateBackgroundColor(routine.color)
        updateTitleLabel(routine.title)
        updateStickerImageView(routine.sticker)
        updateStopMarkView(routine.stopDate == nil)
    }

    // 보드 컬러 업데이트
    private func updateBackgroundColor(_ color: BoardColor) {
        self.backgroundColor = color.uiColor()
    }

    // 루틴 제목 업데이트
    private func updateTitleLabel(_ title: String) {
        self.titleLabel.text = title
    }

    // 루틴 스티커 이미지 업데이트
    private func updateStickerImageView(_ assetName: AssetName) {
        guard let stickerImage = UIImage(systemName: assetName)?
            .withRenderingMode(.alwaysOriginal) else { return }
        self.stickerView.image = stickerImage
    }

    // 루틴 중단마크 업데이트
    private func updateStopMarkView(_ stop: Bool) {
        stopMarkImageView.isHidden = stop
    }

}
