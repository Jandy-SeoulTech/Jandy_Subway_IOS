//
//  ModalCenterView.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/07/08.
//

import UIKit
import SnapKit
import Then

class ModalCenterView: UIView {
    private lazy var centerbar = UIView().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .line1
    }
    private lazy var currentStationView = UIView().then {
        $0.layer.cornerRadius = 18.5
        $0.backgroundColor = .white
        $0.layer.borderWidth = 3
        $0.layer.borderColor = UIColor.line1?.cgColor
    }
    private lazy var currentStation = UILabel().then {
        $0.attributedText = .anza_b3(text: "현재역", color: .black)
    }
    private lazy var prevStation = UILabel().then {
        $0.attributedText = .anza_b5(text: "이전역", color: .white)
    }
    private lazy var nextStation = UILabel().then {
        $0.attributedText = .anza_b5(text: "다음역", color: .white)
    }
    private lazy var prevIcon = UIImageView().then {
        $0.image = UIImage(named: "ic_chevron_left_white")
    }
    private lazy var nextIcon = UIImageView().then {
        $0.image = UIImage(named: "ic_chevron_right_white")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [centerbar, currentStationView, currentStation].forEach { addSubview($0) }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        configureLayout()
    }
}

// MARK: - Configuration
extension ModalCenterView {
    func configure(prev: String, current: String, next: String) {
        currentStation.attributedText = .anza_b3(text: current, color: .black)
        prevStation.attributedText = .anza_b5(text: prev, color: .white)
        nextStation.attributedText = .anza_b5(text: next, color: .white)
    }
    func configureLayout() {
        currentStationView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        centerbar.snp.makeConstraints { make in
            make.centerY.equalTo(currentStationView)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(20)
        }
        currentStation.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(currentStationView)
        }
        [prevIcon, prevStation, nextStation, nextIcon].forEach { addSubview($0) }
        prevIcon.snp.makeConstraints { make in
            make.centerY.equalTo(centerbar)
            make.width.height.equalTo(12)
            make.leading.equalTo(centerbar).offset(2)
        }
        prevStation.snp.makeConstraints { make in
            make.centerY.equalTo(centerbar)
            make.leading.equalTo(prevIcon.snp.trailing)
        }
        nextIcon.snp.makeConstraints { make in
            make.centerY.equalTo(centerbar)
            make.width.height.equalTo(12)
            make.trailing.equalTo(centerbar).offset(-2)
        }
        nextStation.snp.makeConstraints { make in
            make.centerY.equalTo(centerbar)
            make.trailing.equalTo(nextIcon.snp.leading)
        }
    }
}
