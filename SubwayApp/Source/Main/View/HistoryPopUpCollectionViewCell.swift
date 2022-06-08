//
//  HistoryPopUpCollectionViewCell.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/06/08.
//

import UIKit
import SnapKit
import Then

class HistoryPopUpCollectionViewCell: UICollectionViewCell {
    static let identifier = "HistoryPopUpCollectionViewCell"
    
    private var depatureConstraint: SnapKit.ConstraintItem?
    private let depatureLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .Roboto(.regular, size: 14)
        $0.textColor = .anza_black
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private var transferConstraint: SnapKit.ConstraintItem?
    private let transferLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .Roboto(.regular, size: 14)
        $0.textColor = .anza_black
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private var arrivalConstraint: SnapKit.ConstraintItem?
    private let arrivalLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .Roboto(.regular, size: 14)
        $0.textColor = .anza_black
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(depatureLabel)
        addSubview(transferLabel)
        addSubview(arrivalLabel)
    }
    required init?(coder: NSCoder) {
        fatalError("HistoryPopUpCollectionViewCell init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        configureLayout()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        depatureLabel.text = nil
        depatureLabel.textColor = .anza_black
        transferLabel.text = nil
        transferLabel.textColor = .anza_black
        arrivalLabel.text = nil
        arrivalLabel.textColor = .anza_black
    }
}

// MARK: - Configuration
extension HistoryPopUpCollectionViewCell {
    // 출발역, 환승역, 도착역과 중심 맞추기위해 오토레이아웃 값을 가져온다.
    func setConstraints(departure: SnapKit.ConstraintItem, transfer: SnapKit.ConstraintItem, arrival: SnapKit.ConstraintItem) {
        depatureConstraint = departure
        transferConstraint = transfer
        arrivalConstraint = arrival
    }
    // 셀 내용 설정
    func configure(depature: String, transfer: String, arrival: String, color: UIColor?) {
        depatureLabel.text = depature
        depatureLabel.textColor = color
        transferLabel.text = transfer
        transferLabel.textColor = color
        arrivalLabel.text = arrival
        arrivalLabel.textColor = color
    }
    // 오토레이아웃 설정
    func configureLayout() {
        if let depatureCenterX = depatureConstraint {
            depatureLabel.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.centerX.equalTo(depatureCenterX)
                make.width.equalToSuperview().multipliedBy(0.3)
            }
        }
        if let transferCenterX = transferConstraint {
            transferLabel.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.centerX.equalTo(transferCenterX)
                make.width.equalToSuperview().multipliedBy(0.3)
            }
        }
        if let arrivalCenterX = arrivalConstraint {
            arrivalLabel.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.centerX.equalTo(arrivalCenterX)
                make.width.equalToSuperview().multipliedBy(0.3)
            }
        }
    }
}

