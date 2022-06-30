//
//  PathView.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/06/26.
//

import UIKit
import SnapKit
import Then

class PathView: UIView {
    /// 출발역 시간 버튼
    private let depatureTimeButton = UIButton().then {
        $0.setTitle("00:00", for: .normal)
        $0.backgroundColor = .lightGray
    }
    /// 출발역 호선 아이콘
    private let depatureLineIcon = UIImageView().then {
        $0.image = UIImage(named: "ic_six_circle")
    }
    /// 출발역 이름
    private let depatureStationLabel = UILabel().then {
        $0.attributedText = .anza_b3(text: "돌곶이", color: .anzaBlack)
    }
    /// 도착역 시간
    private let arrivalTimeLabel = UILabel().then {
        $0.attributedText = .anza_b7(text: "05:29", color: .anzaGray1)
    }
    /// 하차 아이콘
    private let subwayGetOutIcon = UIImageView().then {
        $0.image = UIImage(named: "ic_six_circle")
    }
    /// 하차역 이름
    private let arrivalStationLabel = UILabel().then {
        $0.attributedText = .anza_b3(text: "태릉입구", color: .anzaBlack)
    }
    /// 첫번째 기차 도착까지 남은 시간
    private let firstSubwayTimeLabel = UILabel().then {
        $0.attributedText = .anza_b2(text: "3분 43초", color: .anzaRed)
    }
    /// 첫번째 기차 목적지 정보
    private let firstSubwayDestinationLabel = UILabel().then {
        $0.attributedText = .anza_b2(text: "봉화산행", color: .anzaBlack)
    }
    // 첫번째 기차 혼잡도
    private let firstSubwayCongestionImageView = UIImageView().then {
        $0.image = UIImage(named: "ic_normal")
    }
    /// 두번째 기차 도착까지 남은 시간
    private let secondSubwayTimeLabel = UILabel().then {
        $0.attributedText = .anza_b2(text: "3분 44초", color: .anzaRed)
    }
    /// 두번째 기차 목적지 정보
    private let secondSubwayDestinationLabel = UILabel().then {
        $0.attributedText = .anza_b2(text: "봉화산행", color: .anzaBlack)
    }
    // 두번째 기차 혼잡도
    private let secondSubwayCongestionImageView = UIImageView().then {
        $0.image = UIImage(named: "ic_normal")
    }
    // 0개역 이동 (0분)
    private let stationListToggleLabel = UILabel().then {
        $0.attributedText = .anza_b2(text: "2개역 이동 (6분)", color: .anzaGray1)
        $0.isUserInteractionEnabled = true
    }
    private let stationListToggleImageView = UIImageView().then {
        $0.image = UIImage(named: "ic_chevron_down")
        $0.isUserInteractionEnabled = true
    }
    private let straightLine = UIView().then {
        $0.backgroundColor = .line6
    }
    private var straightLineHeight = 80
    private var toggled = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("PathView init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        configureDepatureTimeButton()
        configureDepatureLineView()
        configureDepatureStationLabel()
        
        configureStraightLine()
        
        configureArrivalLineView()
        configureArrivalTimeLabel()
        configureArrivalStationLabel()
        
        configureFirstSubwayInformation()
        configureSecondSubwayInformation()
        configureStationListToggleButton()
    }
}
extension PathView {
    func configure(with model: [Path]) {
        
    }
    // MARK: 출발 역 관련 configure
    func configureDepatureTimeButton() {
        addSubview(depatureTimeButton)
        depatureTimeButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(51)
            make.height.equalTo(22)
        }
    }
    func configureDepatureLineView() {
        addSubview(depatureLineIcon)
        depatureLineIcon.snp.makeConstraints { make in
            make.leading.equalTo(depatureTimeButton.snp.trailing).offset(12)
            make.width.height.equalTo(28)
            make.top.equalTo(depatureTimeButton)
        }
    }
    func configureDepatureStationLabel() {
        addSubview(depatureStationLabel)
        depatureStationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(depatureLineIcon)
            make.leading.equalTo(depatureLineIcon.snp.trailing).offset(12)
            make.height.lessThanOrEqualTo(depatureLineIcon)
        }
    }
    func configureStraightLine() {
        addSubview(straightLine)
        straightLine.snp.makeConstraints { make in
            make.centerX.equalTo(depatureLineIcon)
            make.top.equalTo(depatureLineIcon.snp.bottom)
            make.width.equalTo(2)
            make.height.equalTo(straightLineHeight).priority(250)
        }
    }
    // MARK: 도착역 관련 configure
    func configureArrivalLineView() {
        addSubview(subwayGetOutIcon)
        subwayGetOutIcon.snp.makeConstraints { make in
            make.centerX.equalTo(depatureLineIcon)
            make.top.equalTo(straightLine.snp.bottom)
            make.width.height.equalTo(28)
        }
    }
    func configureArrivalStationLabel() {
        addSubview(arrivalStationLabel)
        arrivalStationLabel.snp.makeConstraints { make in
            make.leading.equalTo(depatureStationLabel)
            make.centerY.equalTo(subwayGetOutIcon)
        }
    }
    func configureArrivalTimeLabel() {
        addSubview(arrivalTimeLabel)
        arrivalTimeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(depatureTimeButton).offset(-6)
            make.centerY.equalTo(subwayGetOutIcon)
        }
    }
    func configureFirstSubwayInformation() {
        addSubview(firstSubwayDestinationLabel)
        addSubview(firstSubwayTimeLabel)
        addSubview(firstSubwayCongestionImageView)
        firstSubwayDestinationLabel.snp.makeConstraints { make in
            make.leading.equalTo(depatureStationLabel)
            make.top.equalTo(depatureStationLabel.snp.bottom).offset(4)
        }
        firstSubwayTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(firstSubwayDestinationLabel.snp.trailing).offset(22)
            make.centerY.equalTo(firstSubwayDestinationLabel)
        }
        firstSubwayCongestionImageView.snp.makeConstraints { make in
            make.leading.equalTo(firstSubwayDestinationLabel.snp.trailing).offset(94)
            make.centerY.equalTo(firstSubwayDestinationLabel)
        }
    }
    func configureSecondSubwayInformation() {
        addSubview(secondSubwayDestinationLabel)
        addSubview(secondSubwayTimeLabel)
        addSubview(secondSubwayCongestionImageView)
        secondSubwayDestinationLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(firstSubwayDestinationLabel)
            make.top.equalTo(firstSubwayDestinationLabel.snp.bottom).offset(4)
        }
        secondSubwayTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(firstSubwayTimeLabel)
            make.centerY.equalTo(secondSubwayDestinationLabel)
        }
        secondSubwayCongestionImageView.snp.makeConstraints { make in
            make.leading.equalTo(firstSubwayCongestionImageView)
            make.centerY.equalTo(secondSubwayDestinationLabel)
        }
    }
    func configureStationListToggleButton() {
        addSubview(stationListToggleImageView)
        addSubview(stationListToggleLabel)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSubwayListToggleButton))
        stationListToggleLabel.addGestureRecognizer(tapGesture)
        stationListToggleImageView.addGestureRecognizer(tapGesture)
        stationListToggleLabel.snp.makeConstraints { make in
            make.leading.equalTo(depatureStationLabel)
            make.height.equalTo(19)
            make.top.equalTo(secondSubwayDestinationLabel.snp.bottom).offset(8)
        }
        stationListToggleImageView.snp.makeConstraints { make in
            make.leading.equalTo(stationListToggleLabel.snp.trailing).offset(4)
            make.centerY.equalTo(stationListToggleLabel)
            make.width.equalTo(11)
            make.height.equalTo(5)
        }
    }
}

extension PathView {
    @objc func didTapSubwayListToggleButton() {
        toggled.toggle()
        straightLineHeight = toggled ? 120 : 80
        straightLine.snp.remakeConstraints { make in
            make.centerX.equalTo(depatureLineIcon)
            make.top.equalTo(depatureLineIcon.snp.bottom)
            make.width.equalTo(2)
            make.height.equalTo(straightLineHeight).priority(250)
        }
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
}
