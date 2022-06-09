//
//  SubwayLineCollectionViewCell.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/06/05.
//

import UIKit

class SubwayLineCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "SubwayLineCollectionViewCell"
    
    private let numberLabel = PaddingLabel(padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)).then {
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = UIColor(hex: 0xffffff)
        $0.textAlignment = .center
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 14
        $0.layer.masksToBounds = true
        $0.sizeToFit()
    }
    private let nameLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = UIColor(hex: 0x000000)
        $0.backgroundColor = .clear
    }
    let subwayInformation: LineInformation = LineInformation()
    
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
        numberLabel.backgroundColor = .clear
        nameLabel.text = nil
        nameLabel.textColor = UIColor(hex: 0x000000)
    }
}

// MARK: Configure Cell
extension SubwayLineCollectionViewCell {
    func configure(with model: Information) {
        numberLabel.text = model.호선
        numberLabel.backgroundColor = UIColor(hex: subwayInformation.getColor(name: model.호선))
        nameLabel.text = model.전철역명
    }
    func configure(number: String, name: String, color: Int) {
        numberLabel.text = number
        numberLabel.backgroundColor = UIColor(hex: color)
        nameLabel.text = name
    }
    // Label 부분 색상 적용 함수
    func configure(with model: Information, patial: String) {
        numberLabel.text = model.호선
        numberLabel.backgroundColor = UIColor(hex: subwayInformation.getColor(name: model.호선))
        nameLabel.text = model.전철역명
        if let text = nameLabel.text {
            let attributedString = NSMutableAttributedString(string: text)
            attributedString.addAttribute(.foregroundColor,
                                          value: UIColor(hex: 0x3162BC),
                                          range: (text as NSString).range(of: patial))
            nameLabel.attributedText = attributedString
        }
    }
    
    func configureCell() {
        numberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.width.greaterThanOrEqualTo(28)
            make.height.greaterThanOrEqualTo(28)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(numberLabel.snp.centerY)
            make.leading.equalTo(numberLabel.snp.trailing).offset(15)
        }
    }
}
