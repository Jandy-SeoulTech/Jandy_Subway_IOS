//
//  SubwayLineCollectionViewCell.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/06/05.
//

import UIKit
import SnapKit
import Then

class SubwayLineCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "SubwayLineCollectionViewCell"
    
    private let numberImage = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let nameLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .anzaBlack
        $0.backgroundColor = .clear
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.addSubview(numberImage)
        contentView.addSubview(nameLabel)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        configureCell()
    }
    override func prepareForReuse() {
        numberImage.image = nil
        nameLabel.text = nil
    }
}

// MARK: Configure Cell
extension SubwayLineCollectionViewCell {
    func configure(with model: StationName) {
        let icname = "ic_" + LineInformation.shared.convertIcName(name: model.호선) + "_circle"
        numberImage.image = UIImage(named: icname)
        nameLabel.text = model.전철역명
    }
    func configure(name: String) {
        let lineName = LineInformation.shared.convertIcName(name: name)
        var icname = "ic_" + lineName
        let arr = ["airport_railroad", "gyeongchun", "gyeongui_jungang",
                   "shinbundang", "suin_bundang", "ui_sinseol"]
        if arr.contains(lineName) {
            icname += "_oval"
        } else {
            icname += "_circle"
        }
        numberImage.image = UIImage(named: icname)
        nameLabel.text = name
    }
    func configureCell() {
        numberImage.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalToSuperview().offset(24)
            make.width.greaterThanOrEqualTo(28)
            make.height.equalTo(28)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(numberImage.snp.centerY)
            make.leading.equalTo(numberImage.snp.trailing).offset(12)
        }
    }
}
