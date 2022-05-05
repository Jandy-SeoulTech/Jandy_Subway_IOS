//
//  HalfModalCollectionViewCell.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/05/05.
//

import UIKit
import SnapKit
import Then

class HalfModalCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "HalfModalCollectionViewCell"
    
    private let numberLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = UIColor(hex: 0xffffff)
        $0.textAlignment = .center
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 14
        $0.layer.masksToBounds = true
    }
    private let nameLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = UIColor(hex: 0x000000)
        $0.backgroundColor = .clear
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(hex: 0xffffff)
        contentView.addSubview(numberLabel)
        contentView.addSubview(nameLabel)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        configureCell()
    }
    override func prepareForReuse() {
        numberLabel.text = nil
        nameLabel.text = nil
    }
}

// MARK: Configure Cell
extension HalfModalCollectionViewCell {
    // configure(with model: Model) 로 바꿔야함
    func configure(number: String, name: String) {
        numberLabel.text = number
        nameLabel.text = name
    }
    func configureCell() {
        numberLabel.backgroundColor = UIColor(hex: 0x1F409B)
        numberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(28)
            make.height.greaterThanOrEqualTo(28)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(numberLabel.snp.centerY)
            make.leading.equalTo(numberLabel.snp.trailing).offset(15)
        }
    }
}
