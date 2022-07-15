//
//  RouteViewCell.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/07/02.
//

import UIKit
import SnapKit
import Then

class RouteViewCell: UICollectionViewCell {
    static let identifier = "RouteViewCell"
    
    private let titleLabel = UILabel().then {
        $0.attributedText = .anza_b2(text: "소요시간", color: .anzaGray1)
    }
    private let timeLabel = UILabel().then {
        $0.attributedText = .anza_t1(text: "00분", color: .anzaBlack)
    }
    private lazy var pathView = UICollectionView(frame: .zero,
                                                 collectionViewLayout: layout()).then {
        $0.register(PathViewCell.self, forCellWithReuseIdentifier: PathViewCell.identifier)
        $0.delegate = self
        $0.dataSource = self
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    var model = [String]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(timeLabel)
        addSubview(pathView)
    }
    required init?(coder: NSCoder) {
        fatalError("ContentViewCollectionViewCell init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        configureTitleLabel()
        configureTimeLabel()
        configurePathView()
    }
    override func prepareForReuse() {
        titleLabel.text = ""
        timeLabel.text = ""
    }
}

// MARK: - Configuration
extension RouteViewCell {
    func configure(time: String, model: [String]) {
        timeLabel.text = time
        self.model = model
    }
    func configureTitleLabel() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21.5)
            make.leading.equalToSuperview().offset(24)
        }
    }
    func configureTimeLabel() {
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.trailing.equalTo(titleLabel)
        }
    }
    func configurePathView() {
        pathView.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension RouteViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PathViewCell.identifier,
            for: indexPath) as? PathViewCell else { return PathViewCell() }
        cell.configure(with: model, index: indexPath.row)
        return cell
    }
    func layout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(200)))
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(200)),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 30
        return UICollectionViewCompositionalLayout(section: section)
    }
    
}
