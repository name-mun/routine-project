//
//  SelectColorViewController.swift
//  Routine
//
//  Created by mun on 12/22/24.
//

import UIKit

import SnapKit

let colorData = [
    [255.0, 255.0, 255.0],
    [244.0, 244.0, 245.0],
    [254.0, 243.0, 245.0],
    [253.0, 247.0, 243.0],
    [251.0, 251.0, 241.0],
    [251.0, 247.0, 236.0],
    [251.0, 252.0, 241.0],
    [244.0, 250.0, 236.0],
    [241.0, 251.0, 247.0],
    [241.0, 252.0, 251.0],
    [240.0, 252.0, 251.0],
    [244.0, 243.0, 255.0]
]

class SelectColorViewController: UIViewController {

    // 타이틀 Label
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "컬러 선택"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    // 색상 선택 CollectionView
    lazy var colorCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: 50, height: 50)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ColorCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    // MARK: - 레이아웃 설정

    private func configureUI() {
        view.backgroundColor = .white

        [titleLabel, colorCollectionView].forEach {
            view.addSubview($0)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
        }

        colorCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(120)
        }
    }

}

// MARK: - CollectionView Delegate 설정

extension SelectColorViewController: UICollectionViewDelegate {

}

// MARK: - CollectionView DataSource 설정

extension SelectColorViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ColorCollectionViewCell else {
            return UICollectionViewCell() }
        cell.setupColor(colorData[indexPath.item])
        return cell
    }

}
