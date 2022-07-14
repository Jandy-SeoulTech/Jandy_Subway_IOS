//
//  SearchbarView.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/06/29.
//

import UIKit
import SnapKit
import Then

protocol SearchbarViewDelegate: AnyObject {
    func searchbarView(_ searchbarView: SearchbarView, didTapSearchbarAt index: Int)
}
class SearchbarView: UIView {
    weak var delegate: SearchbarViewDelegate?
    
    private lazy var flipButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.setImage(UIImage(named: "ic_flip"), for: .normal)
        $0.addTarget(self, action: #selector(didTapFlipButton), for: .touchUpInside)
    }
    private let busButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.setImage(UIImage(named: "ic_bus"), for: .normal)
    }
    /// Chips: 지금 탑승 중인 열차가 있어요.
    private let chips = UIButton().then {
        $0.backgroundColor = .anzaBlack?.withAlphaComponent(0.85)
        $0.layer.cornerRadius = 20
    }
    private lazy var departureSearchbar = UIButton().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.anzaGray1?.cgColor
        $0.layer.cornerRadius = 4
        $0.configuration = searchbarConfig(text: "출발 역명을 검색해주세요.", color: .anzaGray2)
        $0.addTarget(self, action: #selector(didTapDepartureButton), for: .touchUpInside)
    }
    private lazy var transferSearchbar = UIButton().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.anzaGray1?.cgColor
        $0.layer.cornerRadius = 4
        $0.isHidden = true
        $0.configuration = searchbarConfig(text: "환승 역명을 검색해주세요.", color: .anzaGray2)
        $0.addTarget(self, action: #selector(didTapTransferButton), for: .touchUpInside)
    }
    private lazy var arrivalSearchbar = UIButton().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.anzaGray1?.cgColor
        $0.layer.cornerRadius = 4
        $0.configuration = searchbarConfig(text: "도착 역명을 검색해주세요.", color: .anzaGray2)
        $0.addTarget(self, action: #selector(didTapArrivalButton), for: .touchUpInside)
    }
    private let searchbarSV = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.distribution = .fillEqually
        $0.alignment = .center
        $0.isUserInteractionEnabled = true
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(flipButton)
        addSubview(busButton)
        addSubview(searchbarSV)
    }
    required init?(coder: NSCoder) {
        fatalError("SearchbarView init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        configureSearchbarSV()
        configureFlipButton()
        configureBusButton()
        //configureChips()
    }
}

//MARK: - Configuration
extension SearchbarView {
    func configureFlipButton() {
        flipButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchbarSV)
            make.leading.equalToSuperview().offset(12)
        }
    }
    func configureBusButton() {
        busButton.snp.makeConstraints { make in
            make.centerY.equalTo(departureSearchbar)
            make.leading.equalTo(departureSearchbar.snp.trailing).offset(8)
        }
    }
    func configureSearchbarSV() {
        searchbarSV.addArrangedSubview(departureSearchbar)
        searchbarSV.addArrangedSubview(transferSearchbar)
        searchbarSV.addArrangedSubview(arrivalSearchbar)
        searchbarSV.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(44)
            make.trailing.equalToSuperview().offset(-51)
            make.top.equalToSuperview().offset(7)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        departureSearchbar.snp.makeConstraints { make in
            make.width.equalTo(width - 95)
        }
        transferSearchbar.snp.makeConstraints { make in
            make.width.equalTo(width - 95)
        }
        arrivalSearchbar.snp.makeConstraints { make in
            make.width.equalTo(width - 95)
        }
    }
    func configureChips() {
        var buttonConfig: UIButton.Configuration = UIButton.Configuration.plain()
        var title = AttributedString.init("지금 탑승 중인 열차가 있어요!")
        title.font = UIFont.NotoSans(.regular, size: 14)
        title.foregroundColor = .white
        buttonConfig.attributedTitle = title
        buttonConfig.titleAlignment = .center
        buttonConfig.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
        chips.configuration = buttonConfig
        addSubview(chips)
        chips.snp.makeConstraints { make in
            make.top.equalTo(busButton.snp.bottom).offset(2)
            make.trailing.equalToSuperview().offset(-21)
        }
    }
    func changeDepartureStation(text: String, color: UIColor?) {
        departureSearchbar.configuration = searchbarConfig(text: text, color: color)
    }
    func changeTransferStation(text: String, color: UIColor?) {
        transferSearchbar.configuration = searchbarConfig(text: text, color: color)
    }
    func changeArrivalStation(text: String, color: UIColor?) {
        arrivalSearchbar.configuration = searchbarConfig(text: text, color: color)
    }
    func searchbarConfig(text: String, color: UIColor?) -> UIButton.Configuration {
        var buttonConfig: UIButton.Configuration = UIButton.Configuration.plain()
        var title = AttributedString.init(text)
        title.font = UIFont.NotoSans(.regular, size: 14)
        title.foregroundColor = color
        
        let titleWidth = NSAttributedString(title).size().width
        // 145 = left margin(44) - right margin(51) - left padding(16) - right padding(10) - ic_search width(24)
        let padding = width - 145 - ceil(titleWidth)
        buttonConfig.attributedTitle = title
        buttonConfig.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 10)
        buttonConfig.image = UIImage(named: "ic_search")
        buttonConfig.imagePlacement = .trailing
        buttonConfig.imagePadding = padding
        return buttonConfig
    }
}

//MARK: - Action function
extension SearchbarView {
    @objc func didTapFlipButton() {
        guard let depatureText = departureSearchbar.titleLabel?.text,
              let arrivalText = arrivalSearchbar.titleLabel?.text else {
            return
        }
        if depatureText == "출발 역명을 검색해주세요." || arrivalText == "도착 역명을 검색해주세요." {
            return
        }
        departureSearchbar.configuration = searchbarConfig(text: arrivalText, color: .anzaBlack)
        arrivalSearchbar.configuration = searchbarConfig(text: depatureText, color: .anzaBlack)
    }
    @objc func didTapDepartureButton() {
        delegate?.searchbarView(self, didTapSearchbarAt: 0)
    }
    @objc func didTapTransferButton() {
        delegate?.searchbarView(self, didTapSearchbarAt: 1)
    }
    @objc func didTapArrivalButton() {
        delegate?.searchbarView(self, didTapSearchbarAt: 2)
    }
}
