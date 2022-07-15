//
//  DetailStationView.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/07/02.
//

import UIKit
import SnapKit
import Then

class DetailPathView: UIView {
    private lazy var station = UILabel().then {
        $0.attributedText = .anza_b2(text: "station", color: .anzaGray1)
    }
    private lazy var circle = UIView().then {
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.line1?.cgColor
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 6
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(circle)
        addSubview(station)
        configureCircle()
        configureStation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

// MARK: - Configuration
extension DetailPathView {
    func configure(name: String, color: UIColor?) {
        station.attributedText = .anza_b2(text: name, color: .anzaGray1)
        circle.layer.borderColor = color?.cgColor
    }
    func configureCircle() {
        circle.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
            make.width.height.equalTo(12)
        }
    }
    func configureStation() {
        station.snp.makeConstraints { make in
            make.leading.equalTo(circle.snp.trailing).offset(20)
            make.centerY.equalTo(circle)
        }
    }
}
