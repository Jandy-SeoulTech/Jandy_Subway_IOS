//
//  TabbarView.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/07/02.
//

import UIKit
import SnapKit
import Then

protocol TabbarViewDelegate: AnyObject {
    func tabbarView(_ tabbar: UICollectionView, index: Int)
}
class TabbarView: UIView {
    weak var delegate: TabbarViewDelegate?
    private lazy var tabbar = UICollectionView(
        frame: .zero,
        collectionViewLayout: layout()).then {
            $0.delegate = self
            $0.dataSource = self
            $0.register(TabbarViewCell.self,
                        forCellWithReuseIdentifier: TabbarViewCell.identifier)
        }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tabbar)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        tabbar.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}

// MARK: - CollectionView Delegate, DataSource
extension TabbarView: UICollectionViewDelegate,
                  UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TabbarViewCell.identifier,
            for: indexPath) as? TabbarViewCell else {
            return UICollectionViewCell()
        }
        if indexPath.row == 0 {
            cell.configure(name: "최단시간", color: .anzaBlack)
        } else {
            cell.configure(name: "최소환승", color: .anzaGray1)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let fisrtCellIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: fisrtCellIndexPath, animated: false, scrollPosition: [])
    }
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        delegate?.tabbarView(collectionView, index: indexPath.row)
    }
    func layout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(59),
                                               heightDimension: .fractionalHeight(1.0)))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0)),
            subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(27)
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
}
