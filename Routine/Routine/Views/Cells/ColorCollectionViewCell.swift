//
//  ColorCollectionViewCell.swift
//  Routine
//
//  Created by mun on 12/22/24.
//

import UIKit

import SnapKit

class ColorCollectionViewCell: UICollectionViewCell {

    // 색상 imageView
    var colorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .yellow
        imageView.contentMode = .center
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 17
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()

    // MARK: - 초기 설정
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - 레이아웃 설정

    private func configureUI() {
        addSubview(colorImageView)

        colorImageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
    }

}

// MARK: - 데이터 설정

extension ColorCollectionViewCell {
    // 색상 설정
    func setupColor(_ color: [Double]) {
        let rColor = color[0] / 256.0
        let gColor = color[1] / 256.0
        let bColor = color[2] / 256.0
        let colors = UIColor(red: rColor, green: gColor, blue: bColor, alpha: 1)
        colorImageView.backgroundColor = colors
    }

    // 선택된 색상 체크 표시
    func setupCheck(_ isSelected: Bool) {
        if isSelected {
            let systemImage = UIImage(systemName: "checkmark")
            let newSize = CGSize(width: 15, height: 15)
            let renderer = UIGraphicsImageRenderer(size: newSize)
            let resizedImage = renderer.image { _ in
                systemImage?.draw(in: CGRect(origin: .zero, size: newSize)) // 이미지 사이즈 조정
            }
            colorImageView.image = resizedImage
        } else {
            colorImageView.image = .none
        }
    }

}
