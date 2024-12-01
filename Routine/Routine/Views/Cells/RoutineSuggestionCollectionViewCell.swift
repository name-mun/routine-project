//
//  RoutineSuggestionCollectionViewCell.swift
//  Routine
//
//  Created by mun on 11/15/24.
//

import UIKit
import SnapKit


class RoutineSuggestionCollectionViewCell: UICollectionViewCell {
  static let id = "routineSuggestionCollectionViewCell"
  let view = UIView()
  let itemLabel = UILabel()
  let imageView = UIImageView()
  let addButton = UIButton()

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  func configure(indexA: Int, indexB: Int) {
    //let thisCategory = RoutineSuggestionData.routineSuggestionData[indexA][indexB]

    view.layer.borderWidth = 1.0
    view.layer.borderColor = UIColor.black.cgColor

    //itemLabel.text = thisCategory.title
    itemLabel.font = .systemFont(ofSize: 15)
    itemLabel.textColor = .black

    imageView.image = UIImage(named: "test")
    imageView.contentMode = .scaleAspectFit


    addButton.setImage(UIImage(named: "button"), for: .normal)

    [itemLabel, imageView, addButton].forEach {
      view.addSubview($0)
    }

    self.contentView.addSubview(view)

    view.snp.makeConstraints {
      $0.width.equalTo(120)
      $0.height.equalTo(160)
      $0.bottom.equalToSuperview()
    }

    itemLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(50)
      $0.centerX.equalToSuperview()
    }

    imageView.snp.makeConstraints {
      $0.width.height.equalTo(60)
      $0.centerX.bottom.equalToSuperview()
    }

    addButton.snp.makeConstraints {
      $0.width.height.equalTo(30)
      $0.top.trailing.equalToSuperview().inset(5)
    }

  }



  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
