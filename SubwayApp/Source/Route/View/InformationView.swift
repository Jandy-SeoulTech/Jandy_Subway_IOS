//
//  InformationView.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/07/07.
//

import UIKit
import SnapKit
import Then

class InformationView: UIView {
    private let destination = UILabel().then {
        $0.attributedText = .anza_b2(text: "무슨행", color: .anzaBlack)
    }
    private let time = UILabel().then {
        $0.attributedText = .anza_b2(text: "몇분 몇초", color: .anzaRed)
    }
    private let congestion = UIImageView().then {
        $0.image = UIImage(named: "ic_enough_path")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        [destination, time, congestion].forEach { addSubview($0) }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setUI()
    }
}

extension InformationView {
    func configure(with model: Information) {
        destination.attributedText = .anza_b2(text: model.destination, color: .anzaBlack)
        time.attributedText = .anza_b2(text: model.time, color: .anzaBlack)
        congestion.image = UIImage(named: model.congestion)
    }
    func setUI() {
        congestion.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        time.snp.makeConstraints { make in
            make.centerY.equalTo(congestion)
            make.trailing.equalTo(congestion.snp.leading).offset(-9)
        }
        destination.snp.makeConstraints { make in
            make.centerY.equalTo(congestion)
            make.leading.equalToSuperview()
        }
    }
}
