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
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    /// 출발역 호선 아이콘
    private let depatureLineIcon = UIImageView().then {
        $0.image = UIImage(named: "ic_six_circle")
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    /// 출발역 이름
    private let depatureStationLabel = UILabel().then {
        $0.text = "공릉"
        $0.textColor = .anzaBlack
        $0.font = UIFont.NotoSans(.semiBold, size: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    /// 도착역 시간
    private let arrivalTimeLabel = UILabel().then {
        $0.text = "00:00"
        $0.textColor = .anzaGray1
        $0.font = UIFont.NotoSans(.regular, size: 12)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    /// 하차 아이콘
    private let subwayGetOutIcon = UIImageView().then {
        $0.image = UIImage(named: "ic_six_circle")
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    /// 하차역 이름
    private let arrivalStationLabel = UILabel().then {
        $0.text = "공릉"
        $0.textColor = .anzaBlack
        $0.font = UIFont.NotoSans(.semiBold, size: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    /// 첫번째 기차 시간 정보
    private let firstSubwayTimeLabel = UILabel().then {
        $0.text = "13분 43초"
        $0.textColor = .anzaRed
        $0.font = UIFont.NotoSans(.regular, size: 14)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    /// 첫번째 기차 도착 정보
    private let firstSubwayDestinationLabel = UILabel().then {
        $0.text = "봉화산행"
        $0.textColor = .anzaBlack
        $0.font = UIFont.NotoSans(.regular, size: 14)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    // 첫번째 기차 혼잡도
    private let firstSubwayCongestionImageView = UIImageView().then {
        $0.image = UIImage(named: "ic_normal")
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let secondSubwayTimeLabel = UILabel().then {
        $0.text = "12분"
        $0.textColor = .anzaRed
        $0.font = UIFont.NotoSans(.regular, size: 14)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let secondSubwayDestinationLabel = UILabel().then {
        $0.text = "봉화산행"
        $0.textColor = .anzaBlack
        $0.font = UIFont.NotoSans(.regular, size: 14)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let secondSubwayCongestionImageView = UIImageView().then {
        $0.image = UIImage(named: "ic_normal")
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let stationListToggleLabel = UILabel().then {
        $0.text = "2개역 이동 (6분)"
        $0.textColor = .anzaGray1
        $0.font = UIFont.NotoSans(.regular, size: 14)
        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let stationListToggleImageView = UIImageView().then {
        $0.image = UIImage(named: "ic_chevron_down")
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    var straightLineHeightConstraint: Constraint!
    private let straightLine = UIView().then {
        $0.backgroundColor = .line6
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("PathView init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        configureDepatureTimeButton()
        depatureTimeButton.addTarget(self, action: #selector(didTapSubwayListToggleButton), for: .touchUpInside)
        configureDepatureLineView()
        configureDepatureStationLabel()
        
        configureStraightLine()
        
        configureArrivalLineView()
        configureArrivalStationLabel()
        
        configureFirstSubwayInformation()
        configureSecondSubwayInformation()
        configureStationListToggleButton()
    }
}
extension PathView {
    func configure() {
        
    }
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
    func configureArrivalTimeLabel() {
        addSubview(arrivalTimeLabel)
        arrivalTimeLabel.snp.makeConstraints { make in
            
        }
    }
    func configureArrivalLineView() {
        addSubview(subwayGetOutIcon)
        subwayGetOutIcon.snp.makeConstraints { make in
            make.centerX.equalTo(depatureLineIcon)
            make.top.equalTo(straightLine.snp.bottom)
            make.width.height.equalTo(28)
        }
    }
    func configureStraightLine() {
        addSubview(straightLine)
        straightLine.snp.makeConstraints { make in
            make.centerX.equalTo(depatureLineIcon)
            make.top.equalTo(depatureLineIcon.snp.bottom)
            make.width.equalTo(2)
            straightLineHeightConstraint = make.height.equalTo(150).constraint
        }
    }
    func configureArrivalStationLabel() {
        addSubview(arrivalStationLabel)
        arrivalStationLabel.snp.makeConstraints { make in
            make.leading.equalTo(depatureStationLabel)
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
        addSubview(stationListToggleLabel)
        addSubview(stationListToggleImageView)
        stationListToggleLabel.snp.makeConstraints { make in
            make.leading.equalTo(depatureStationLabel)
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
        UIView.animate(withDuration: 0.1) {
            self.layoutIfNeeded()
        }
    }
}
