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
    private lazy var depatureTimeButton = UIButton().then {
        $0.configuration = setDepartureTimeButtonUI(title: "05:23")
        $0.backgroundColor = UIColor(hex: 0xf8f8f8)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.anzaLightGray?.cgColor
        $0.layer.cornerRadius = 11
    }
    /// 출발역 호선 아이콘
    private let departureIcon = UIImageView().then {
        $0.image = UIImage(named: "ic_six_circle")
    }
    /// 출발역 이름
    private let depatureStationLabel = UILabel().then {
        $0.attributedText = .anza_b3(text: "출발역", color: .anzaBlack)
    }
    /// 도착역 시간
    private let arrivalTimeLabel = UILabel().then {
        $0.attributedText = .anza_b7(text: "00:00", color: .anzaGray1)
    }
    /// 하차 아이콘
    private let arrivalIcon = UIImageView().then {
        $0.image = UIImage(named: "ic_six_circle")
    }
    /// 하차역 이름
    private let arrivalStationLabel = UILabel().then {
        $0.attributedText = .anza_b3(text: "도착역", color: .anzaBlack)
    }
    /// 첫번째 기차 도착까지 남은 시간
    private let firstSubwayTimeLabel = UILabel().then {
        $0.attributedText = .anza_b2(text: "0분 00초", color: .anzaRed)
    }
    /// 첫번째 기차 목적지 정보
    private let firstSubwayDestinationLabel = UILabel().then {
        $0.attributedText = .anza_b2(text: "출발행", color: .anzaBlack)
    }
    // 첫번째 기차 혼잡도
    private let firstSubwayCongestionIcon = UIImageView().then {
        $0.image = UIImage(named: "ic_normal_path")
    }
    /// 두번째 기차 도착까지 남은 시간
    private let secondSubwayTimeLabel = UILabel().then {
        $0.attributedText = .anza_b2(text: "0분 00초", color: .anzaRed)
    }
    /// 두번째 기차 목적지 정보
    private let secondSubwayDestinationLabel = UILabel().then {
        $0.attributedText = .anza_b2(text: "출발행", color: .anzaBlack)
    }
    // 두번째 기차 혼잡도
    private let secondSubwayCongestionIcon = UIImageView().then {
        $0.image = UIImage(named: "ic_normal_path")
    }
    // 0개역 이동 (0분)
    private lazy var dropdownButton = UIButton().then {
        $0.configuration = setDropdownUI(title: "0개역 이동 (0분)", image: UIImage(named: "ic_chevron_down_path"))
        $0.addTarget(self, action: #selector(didTapDropdownButton), for: .touchUpInside)
    }
    private let straightLine = UIView().then {
        $0.backgroundColor = .line6
    }
    private lazy var detailPathView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .fillEqually
        $0.spacing = 10
        $0.isHidden = true
    }
    private var isDroped = false
    private lazy var stations = [String]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("PathView init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        configureDepartureTimeButton()
        configureDepatureIcon()
        configureDepartureStationLabel()
        
        configureStraightLine()
        
        configureArrivalIcon()
        configureArrivalTimeLabel()
        configureArrivalStationLabel()
        
        configureFirstSubwayInformation()
        configureSecondSubwayInformation()
        
        configureDropdown()
        
        configureDetailPathView()
    }
}
// MARK: - configuration
extension PathView {
    func configure(with model: [String]) {
        stations = model
        
    }
    // MARK: 출발 역 관련 configure
    func configureDepartureTimeButton() {
        addSubview(depatureTimeButton)
        depatureTimeButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(51)
            make.height.equalTo(22)
        }
    }
    func configureDepatureIcon() {
        addSubview(departureIcon)
        departureIcon.snp.makeConstraints { make in
            make.leading.equalTo(depatureTimeButton.snp.trailing).offset(12)
            make.width.height.equalTo(28)
            make.top.equalTo(depatureTimeButton)
        }
    }
    func configureDepartureStationLabel() {
        addSubview(depatureStationLabel)
        depatureStationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(departureIcon)
            make.leading.equalTo(departureIcon.snp.trailing).offset(12)
            make.height.lessThanOrEqualTo(departureIcon)
        }
    }
    func configureStraightLine() {
        addSubview(straightLine)
        straightLine.snp.makeConstraints { make in
            make.centerX.equalTo(departureIcon)
            make.top.equalTo(departureIcon.snp.bottom)
            make.width.equalTo(2)
            make.height.equalTo(80).priority(250)
        }
    }
    // MARK: 도착역 관련 configure
    func configureArrivalIcon() {
        addSubview(arrivalIcon)
        arrivalIcon.snp.makeConstraints { make in
            make.centerX.equalTo(departureIcon)
            make.top.equalTo(straightLine.snp.bottom)
            make.width.height.equalTo(28)
        }
    }
    func configureArrivalStationLabel() {
        addSubview(arrivalStationLabel)
        arrivalStationLabel.snp.makeConstraints { make in
            make.leading.equalTo(depatureStationLabel)
            make.centerY.equalTo(arrivalIcon)
        }
    }
    func configureArrivalTimeLabel() {
        addSubview(arrivalTimeLabel)
        arrivalTimeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.centerY.equalTo(arrivalIcon)
        }
    }
    func configureFirstSubwayInformation() {
        addSubview(firstSubwayDestinationLabel)
        addSubview(firstSubwayTimeLabel)
        addSubview(firstSubwayCongestionIcon)
        firstSubwayDestinationLabel.snp.makeConstraints { make in
            make.leading.equalTo(depatureStationLabel)
            make.top.equalTo(depatureStationLabel.snp.bottom).offset(4)
        }
        firstSubwayTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(firstSubwayDestinationLabel.snp.trailing).offset(22)
            make.centerY.equalTo(firstSubwayDestinationLabel)
        }
        firstSubwayCongestionIcon.snp.makeConstraints { make in
            make.leading.equalTo(firstSubwayDestinationLabel.snp.trailing).offset(94)
            make.centerY.equalTo(firstSubwayDestinationLabel)
        }
    }
    func configureSecondSubwayInformation() {
        addSubview(secondSubwayDestinationLabel)
        addSubview(secondSubwayTimeLabel)
        addSubview(secondSubwayCongestionIcon)
        secondSubwayDestinationLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(firstSubwayDestinationLabel)
            make.top.equalTo(firstSubwayDestinationLabel.snp.bottom).offset(4)
        }
        secondSubwayTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(firstSubwayTimeLabel)
            make.centerY.equalTo(secondSubwayDestinationLabel)
        }
        secondSubwayCongestionIcon.snp.makeConstraints { make in
            make.leading.equalTo(firstSubwayCongestionIcon)
            make.centerY.equalTo(secondSubwayDestinationLabel)
        }
    }
    func configureDropdown() {
        if stations.isEmpty { return }
        addSubview(dropdownButton)
        dropdownButton.snp.makeConstraints { make in
            make.top.equalTo(secondSubwayDestinationLabel.snp.bottom).offset(8)
            make.leading.equalTo(depatureStationLabel)
            make.height.equalTo(19)
        }
    }
    func configureDetailPathView() {
        if stations.isEmpty { return }
        detailPathView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        detailPathView.removeFromSuperview()
        addSubview(detailPathView)
        for station in stations {
            let detail = DetailStationView()
            detail.configure(name: station, color: .line6)
            detailPathView.addArrangedSubview(detail)
            detail.snp.makeConstraints { make in
                make.height.equalTo(19)
            }
        }
        detailPathView.snp.makeConstraints { make in
            make.top.equalTo(dropdownButton.snp.bottom).offset(16)
            make.leading.equalTo(departureIcon.snp.centerX).offset(-6)
            make.trailing.equalToSuperview()
        }
    }
}
// MARK: - UI
extension PathView {
    func setDepartureTimeButtonUI(title: String) -> UIButton.Configuration {
        var config = UIButton.Configuration.plain()
        config.contentInsets = NSDirectionalEdgeInsets(top: 2,leading: 6, bottom: 4, trailing: 6)
        config.attributedTitle = AttributedString.init(.anza_b7(text: title, color: .anzaBlack))
        config.image = UIImage(named: "ic_chevron_down_small_path")
        config.imagePlacement = .trailing
        config.imagePadding = 3
        return config
    }
    func setDropdownUI(title: String, image: UIImage?) -> UIButton.Configuration {
        var config = UIButton.Configuration.plain()
        config.contentInsets = NSDirectionalEdgeInsets(top: 0,leading: 0, bottom: 0, trailing: 0)
        config.attributedTitle = AttributedString.init(.anza_b2(text: title, color: .anzaGray1))
        config.image = image
        config.imagePlacement = .trailing
        config.imagePadding = 4
        return config
    }
}
// MARK: - Action function
extension PathView {
    @objc func didTapDropdownButton() {
        isDroped.toggle()
        detailPathView.isHidden = isDroped ? false : true
        let imagePath = isDroped ? "ic_chevron_up_path" : "ic_chevron_down_path"
        dropdownButton.configuration?.image = UIImage(named: imagePath)
        straightLine.snp.remakeConstraints { make in
            make.centerX.equalTo(departureIcon)
            make.top.equalTo(departureIcon.snp.bottom)
            make.width.equalTo(2)
            make.height.equalTo(isDroped ? 118 + detailPathView.height : 80).priority(250)
        }
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
}
