//
//  ContentView.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/07/02.
//

import UIKit

class ContentView: UIView {
    lazy var content = UICollectionView(frame: .zero,
                                       collectionViewLayout: layout()).then {
        $0.delegate = self
        $0.dataSource = self
        $0.register(ContentViewCollectionViewCell.self,
                    forCellWithReuseIdentifier: ContentViewCollectionViewCell.identifier)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        addSubview(content)
        content.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}

extension ContentView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ContentViewCollectionViewCell.identifier,
            for: indexPath) as? ContentViewCollectionViewCell else {
            return UICollectionViewCell()
        }
        let temp = ["인천", "광역시", "공릉"]
        cell.configure(time: "57분", model: temp)
        return cell
    }
    func layout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0)))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0)),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
}
