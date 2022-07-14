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
    private lazy var depatureLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .NotoSans(.regular, size: 14)
        $0.textColor = .anzaBlack
        $0.textAlignment = .center
    }
    private lazy var arrow = UIImageView(image: UIImage(named: "ic_arrow_right")?.withRenderingMode(.alwaysTemplate)).then {
        $0.tintColor = .anzaDarkGray
    }
    private var arrivalConstraint: SnapKit.ConstraintItem?
    private lazy var arrivalLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .NotoSans(.regular, size: 14)
        $0.textColor = .anzaBlack
        $0.textAlignment = .center
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(depatureLabel)
        addSubview(arrow)
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
        depatureLabel.textColor = .anzaBlack
        arrow.tintColor = .anzaDarkGray
        arrivalLabel.text = nil
        arrivalLabel.textColor = .anzaBlack
    }
}

// MARK: - Configuration
extension HistoryPopUpCollectionViewCell {
    // 출발역, 환승역, 도착역과 중심 맞추기위해 오토레이아웃 값을 가져온다.
    func setConstraints(departure: SnapKit.ConstraintItem, arrival: SnapKit.ConstraintItem) {
        depatureConstraint = departure
        arrivalConstraint = arrival
    }
    // 셀 내용 설정
    func configure(with model: History, color: UIColor?) {
        depatureLabel.text = model.depature
        depatureLabel.textColor = color
        arrow.tintColor = color
        arrivalLabel.text = model.arrival
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
        arrow.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
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

