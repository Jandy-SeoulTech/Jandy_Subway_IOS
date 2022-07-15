//
//  PathViewCell.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/07/15.
//

import UIKit
import SnapKit
import Then

class PathViewCell: UICollectionViewCell {
    static let identifier = "PathViewCell"
    
    private lazy var depatureTimeButton = UIButton().then {
        $0.configuration = setDepartureTimeButtonUI(title: "05:23")
        $0.backgroundColor = UIColor(hex: 0xf8f8f8)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.anzaLightGray?.cgColor
        $0.layer.cornerRadius = 11
        //$0.addTarget(self, action: #selector(didTapTimebutton), for: .touchUpInside)
    }
    // 출발역 호선 아이콘
    private let departureIcon = UIImageView().then {
        $0.image = UIImage(named: "ic_six_circle")
    }
    // 출발역 이름
    private let depatureStationLabel = UILabel().then {
        $0.attributedText = .anza_b3(text: "출발역", color: .anzaBlack)
    }
    // 도착역 시간
    private let arrivalTimeLabel = UILabel().then {
        $0.attributedText = .anza_b7(text: "00:00", color: .anzaGray1)
    }
    // 하차 아이콘
    private let arrivalIcon = UIImageView().then {
        $0.image = UIImage(named: "ic_six_circle")
    }
    // 하차역 이름
    private let arrivalStationLabel = UILabel().then {
        $0.attributedText = .anza_b3(text: "도착역", color: .anzaBlack)
    }
    private let straightLine = UIView().then {
        $0.backgroundColor = .line6
    }
    private lazy var firstSubwayInfomation = InformationView()
    private lazy var secondSubwayInfomation = InformationView()
    // 0개역 이동 (0분)
    private lazy var dropdownButton = UIButton().then {
        $0.configuration = setDropdownUI(title: "0개역 이동 (0분)", image: UIImage(named: "ic_chevron_down_path"))
        $0.addTarget(self, action: #selector(didTapDropdownButton), for: .touchUpInside)
    }
    private let detailPathView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .fillEqually
        $0.spacing = 10
        $0.isHidden = true
    }
    private var index: Int?
    private var isDroped = false
    private lazy var stations = [String]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
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
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        depatureTimeButton.configuration = setDepartureTimeButtonUI(title: "")
    }
}
extension PathViewCell {
    func configure(with model: [String], index: Int) {
        self.index = index
        stations = model
        dropdownButton.configuration?.attributedTitle = AttributedString.init(
            .anza_b2(text: "\(model.count)개역 이동 (0)분",
                     color: .anzaGray1))
        addDetailStation()
    }
    func setUI() {
        addSubview(depatureTimeButton)
        addSubview(departureIcon)
        addSubview(depatureStationLabel)
        addSubview(straightLine)
        addSubview(arrivalIcon)
        addSubview(arrivalStationLabel)
        addSubview(arrivalTimeLabel)
        addSubview(firstSubwayInfomation)
        addSubview(secondSubwayInfomation)
        addSubview(dropdownButton)
        addSubview(detailPathView)
    }
    // MARK: 출발 역 관련 configure
    func configureDepartureTimeButton() {
        depatureTimeButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(51)
            make.height.equalTo(22)
        }
    }
    func configureDepatureIcon() {
        departureIcon.snp.makeConstraints { make in
            make.leading.equalTo(depatureTimeButton.snp.trailing).offset(12)
            make.width.height.equalTo(28)
            make.top.equalTo(depatureTimeButton)
        }
    }
    func configureDepartureStationLabel() {
        depatureStationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(departureIcon)
            make.leading.equalTo(departureIcon.snp.trailing).offset(12)
            make.height.lessThanOrEqualTo(departureIcon)
        }
    }
    func configureStraightLine() {
        straightLine.snp.makeConstraints { make in
            make.centerX.equalTo(departureIcon)
            make.top.equalTo(departureIcon.snp.bottom)
            make.width.equalTo(2)
            make.height.equalTo(80).priority(250)
        }
    }
    // MARK: 도착역 관련 configure
    func configureArrivalIcon() {
        arrivalIcon.snp.makeConstraints { make in
            make.centerX.equalTo(departureIcon)
            make.top.equalTo(straightLine.snp.bottom)
            make.width.height.equalTo(28)
        }
    }
    func configureArrivalStationLabel() {
        arrivalStationLabel.snp.makeConstraints { make in
            make.leading.equalTo(depatureStationLabel)
            make.centerY.equalTo(arrivalIcon)
        }
    }
    func configureArrivalTimeLabel() {
        arrivalTimeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.centerY.equalTo(arrivalIcon)
        }
    }
    func configureFirstSubwayInformation() {
        firstSubwayInfomation.snp.makeConstraints { make in
            make.leading.equalTo(depatureStationLabel)
            make.top.equalTo(depatureStationLabel.snp.bottom).offset(4)
            make.height.equalTo(20)
            make.trailing.equalToSuperview().offset(-95)
        }
    }
    func configureSecondSubwayInformation() {
        secondSubwayInfomation.snp.makeConstraints { make in
            make.leading.equalTo(depatureStationLabel)
            make.top.equalTo(firstSubwayInfomation.snp.bottom).offset(4)
            make.height.equalTo(20)
            make.trailing.equalTo(firstSubwayInfomation)
        }
    }
    func configureDropdown() {
        dropdownButton.snp.makeConstraints { make in
            make.top.equalTo(secondSubwayInfomation.snp.bottom).offset(8)
            make.leading.equalTo(depatureStationLabel)
            make.height.equalTo(19)
        }
    }
    func configureDetailPathView() {
        detailPathView.snp.makeConstraints { make in
            make.top.equalTo(arrivalIcon.snp.bottom).offset(16)
            make.leading.equalTo(departureIcon.snp.centerX).offset(-6)
            make.trailing.equalToSuperview()
        }
    }
    func addDetailStation() {
        detailPathView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        stations.forEach { station in
            let detail = DetailPathView()
            detail.configure(name: station, color: .line6)
            detail.snp.makeConstraints { make in
                make.height.equalTo(19)
            }
            detailPathView.addArrangedSubview(detail)
        }
    }
}

extension PathViewCell {
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

// MARK: - Action Function
extension PathViewCell {
    @objc func didTapDropdownButton() {
        
    }
}
