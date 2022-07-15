//
//  SelectModalCollectionViewCell.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/07/03.
//

import UIKit
import SnapKit
import Then

class SelectModalCollectionViewCell: UICollectionViewCell {
    static let identifier = "SelectModalCollectionViewCell"
    
    private let currentTimeLabel = UILabel().then {
        $0.attributedText = .anza_b3(text: "오후 00:00", color: .anzaBlack)
    }
    private let destinationLabel = UILabel().then {
        $0.attributedText = .anza_b4_2(text: "봉화산행", color: .anzaGray1)
    }
    private let remainTimeLabel = UILabel().then {
        $0.attributedText = .anza_b2(text: "0분 00초", color: .anzaRed)
    }
    private let lineIcon = UIImageView().then {
        $0.image = UIImage(named: "ic_one_circle")
    }
    private let congestionIcon = UIImageView().then {
        $0.image = UIImage(named: "ic_normal_path")
    }
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? UIColor(hex: 0xE7F1FF) : .white
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configuration
extension SelectModalCollectionViewCell {
    func configure(currentTime: String, desination: String,
                   remainTime: String, line: UIImage, congestion: UIImage) {
        currentTimeLabel.attributedText = .anza_b3(text: currentTime, color: .anzaBlack)
        destinationLabel.attributedText = .anza_b4_2(text: desination, color: .anzaGray1)
        remainTimeLabel.attributedText = .anza_b2(text: remainTime, color: .anzaRed)
        lineIcon.image = line
        congestionIcon.image = congestion
    }
    func setUI() {
        addSubview(currentTimeLabel)
        addSubview(destinationLabel)
        addSubview(remainTimeLabel)
        addSubview(congestionIcon)
        addSubview(lineIcon)
    }
    func setConstraints() {
        currentTimeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
        }
        destinationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(currentTimeLabel)
            make.leading.equalTo(currentTimeLabel.snp.trailing).offset(13)
        }
        remainTimeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(currentTimeLabel)
            make.leading.equalTo(destinationLabel.snp.trailing).offset(31)
        }
        congestionIcon.snp.makeConstraints { make in
            make.centerY.equalTo(currentTimeLabel)
            make.leading.equalTo(remainTimeLabel.snp.trailing).offset(9)
        }
        lineIcon.snp.makeConstraints { make in
            make.centerY.equalTo(currentTimeLabel)
            make.leading.equalTo(congestionIcon.snp.trailing).offset(31)
        }
    }
}
