//
//  RoutineSuggestionTableViewCell.swift
//  Routine
//
//  Created by mun on 11/15/24.
//

import UIKit
import SnapKit

class RoutineSuggestionTableViewCell: UITableViewCell {
    static let id = "routineSuggestionTableViewCell"
    var thisIndex = 0
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    func configure(_ index: Int) {
        thisIndex = index
        setUpCollectionView()
        collectionView.reloadData()
    }
    func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 15
        layout.itemSize = .init(width: 120, height: 160)
        
        self.collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(RoutineSuggestionCollectionViewCell.self, forCellWithReuseIdentifier: RoutineSuggestionCollectionViewCell.id)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.height.equalTo(160)
            $0.top.equalToSuperview().offset(40)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}


extension RoutineSuggestionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0 //RoutineSuggestionData.itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoutineSuggestionCollectionViewCell.id, for: indexPath) as! RoutineSuggestionCollectionViewCell
        cell.configure(indexA: thisIndex, indexB: indexPath[1])
        
        return cell
    }
}
