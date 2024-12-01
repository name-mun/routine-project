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
    
    private var isViewSetUp: Bool = false
    private var data: RoutineData?
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.backgroundColor = .clear
        stackView.alignment = .center
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 3
        
        return titleLabel
    }()
    
    private let stickerImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .bottom
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let stopMarkView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        
        return UIImageView()
    }()
    
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
    
    //코너 둥글기 설정
    private func cornerRound() {
        self.clipsToBounds = true
        self.layer.cornerRadius = Self.cornerRadius
    }
    
    //테두리 선 설정
    private func setBorder() {
        self.layer.borderWidth = Self.borderWidth
        self.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
    }

}
//MARK: - Set Up UI
//FIXME: View를 확인하고, 반영하는 형태로 수정 필요
extension RoutineBoardCollectionViewCell {
    
    private func setUpUI() {
        setUpStackView()
        setUpTitleLabel()
        setUpStickerImageView()
        setUpStopMarkImageView()
        
        cornerRound()
        setBorder()
        
        stopMarkView.isHidden = true
        
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
        stackView.addArrangedSubview(stickerImageView)
        
        stickerImageView.snp.makeConstraints { imageView in
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
        self.stickerImageView.image = nil
        self.titleLabel.text = nil
        self.stopMarkView.image = nil
    }
    
}


//MARK: - Update Data

extension RoutineBoardCollectionViewCell {
    
    //뷰에 루틴 데이터 적용
    private func updateData() {
        guard let routineData = data else { return }
        updateBackgroundColor(routineData.color)
        updateTitleLabel(routineData.title)
        updateStickerImageView(routineData.sticker)
        updateStopMarkView(false)
    }
    
    private func updateBackgroundColor(_ boardColor: BoardColor) {
        
        let boardColor = UIColor(red: boardColor.red,
                                 green: boardColor.green,
                                 blue: boardColor.green,
                                 alpha: 1)
        
        self.backgroundColor = boardColor
    }
    
    private func updateTitleLabel(_ title: String) {
        self.titleLabel.text = title
    }
    
    private func updateStickerImageView(_ assetName: String) {
        guard let stickerImage = UIImage(systemName: assetName) else { return }
        
        stickerImageView.image = stickerImage
    }
    
    private func updateStopMarkView(_ stop: Bool) {
        self.stopMarkView.isHidden = stop
    }
    
}


//MARK: - Preview
#Preview("MainRoutineBoardViewController") {
    MainRoutineViewController()
}

