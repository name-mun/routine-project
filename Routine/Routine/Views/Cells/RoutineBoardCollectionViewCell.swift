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
    
    static let cellID: String = "RoutineBoardCollectionViewCell"
    
    static let borderWidth: CGFloat = 1
    static let cornerRadius: CGFloat = 20
    
    //루틴 데이터
    private var routine: RoutineData?
    
    //전체 스택 뷰
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.alignment = .center
        stackView.axis = .vertical
        return stackView
    }()
    
    //루틴 제목 라벨 뷰
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 3
        return titleLabel
    }()
    
    //스티커 이미지 뷰
    private let stickerView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .bottom
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //중단 마크 이미지 뷰
    private let stopMarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.image = UIImage(systemName: "minus.circle")
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    
    ///
    func configureData(_ routine: RoutineData) {
        self.routine = routine
        updateData()
    }
    
    func configurePosition(indexPath: IndexPath, dataCount: Int) {
        let position = Position(dataCount: dataCount, index: indexPath.item)
        self.layer.maskedCorners = position.maskedCorner()
        return
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - Set Up UI
extension RoutineBoardCollectionViewCell {
    
    private func setUpUI() {
        
        [stackView, stopMarkImageView].forEach {
            addSubview($0)
        }
        
        [titleLabel, stickerView].forEach {
            stackView.addArrangedSubview($0)
        }
        
        stackView.snp.makeConstraints { stackView in
            stackView.top.bottom.leading.trailing.equalToSuperview()
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
            imageView.size.height.width.equalTo(15)
        }
    
        self.clipsToBounds = true
        self.layer.cornerRadius = Self.cornerRadius
        
        self.layer.borderWidth = Self.borderWidth
        self.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
    }
}

//MARK: - prepare for reuse

extension RoutineBoardCollectionViewCell {
    private func resetData() {
        self.stickerView.image = nil
        self.titleLabel.text = nil
        self.stopMarkImageView.isHidden = true
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
        updateStopMarkView(routine.stopDate == nil)
    }
    
    private func updateBackgroundColor(_ color: BoardColor) {
        self.backgroundColor = color.get()
    }
    
    private func updateTitleLabel(_ title: String) {
        self.titleLabel.text = title
    }
    
    private func updateStickerImageView(_ assetName: AssetName) {
        guard let stickerImage = UIImage(systemName: assetName)?.withRenderingMode(.alwaysOriginal) else {
            return
        }
        self.stickerView.image = stickerImage
    }
    
    private func updateStopMarkView(_ stop: Bool) {
        stopMarkImageView.isHidden = stop
    }
    
}


//MARK: - Preview
#Preview("MainRoutineBoardViewController") {
    MainRoutineViewController()
}

