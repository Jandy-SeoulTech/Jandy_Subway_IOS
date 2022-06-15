//
//  MainViewController.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/06/05.
//

import UIKit
import SnapKit
import Then

class MainViewController: UIViewController {
    private let historyBtn = UIButton().then {
        $0.backgroundColor = .anza_blue
        $0.setImage(UIImage(named: "ic_clock")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .white
        $0.layer.cornerRadius = 28
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.35).cgColor
        $0.layer.shadowOpacity = 1.0
        $0.layer.shadowOffset = .zero
        $0.layer.shadowRadius = 12
        $0.layer.masksToBounds = false
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let flipBtn = UIButton().then {
        $0.backgroundColor = .clear
        $0.setImage(UIImage(named: "ic_flip"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let busBtn = UIButton().then {
        $0.backgroundColor = .clear
        $0.setImage(UIImage(named: "ic_bus"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private var departureSearchbar = UIButton().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.anza_gray1?.cgColor
        $0.layer.cornerRadius = 4
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private var transferSearchbar: UIButton = UIButton().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.anza_gray1?.cgColor
        $0.layer.cornerRadius = 4
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private var arrivalSearchbar: UIButton = UIButton().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.anza_gray1?.cgColor
        $0.layer.cornerRadius = 4
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let searchbarSV = UIStackView().then {
        $0.backgroundColor = .clear
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 8
        $0.alignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = true;
    }
    private let searchView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.masksToBounds = false
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        $0.layer.shadowRadius = 3
        $0.layer.shadowOpacity = 1.0
        $0.layer.shadowOffset = CGSize(width: 0, height: 6)
        $0.translatesAutoresizingMaskIntoConstraints = true;
    }
    private var searchViewHeightConstraint = 107
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        configureHistoryBtn()
        configureSearchView()
        configureSearchbarSV()
        configureFlipBtn()
        configureBusBtn()
    }
}

// MARK: Configuration
extension MainViewController {
    func configureHistoryBtn() {
        view.addSubview(historyBtn)
        historyBtn.snp.makeConstraints { make in
            make.width.height.equalTo(56)
            make.bottom.equalToSuperview().offset(-24)
            make.trailing.equalToSuperview().offset(-24)
        }
        historyBtn.addTarget(self, action: #selector(didTapHistoryBtn), for: .touchUpInside)
    }
    func configureSearchView() {
        view.addSubview(searchView)
        searchView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(getStatusBarHeight())
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(searchViewHeightConstraint)
        }
    }
    func configureSearchbarSV() {
        searchView.addSubview(searchbarSV)
        searchbarSV.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(searchView.snp.top).offset(7)
            make.bottom.equalTo(searchView.snp.bottom).offset(-10)
        }
        
        searchbarSV.addArrangedSubview(departureSearchbar)
        departureSearchbar.configuration = btnConfig(text: "출발 역명을 검색해주세요.")
        departureSearchbar.snp.makeConstraints { make in
            make.width.equalTo(view.width - 95)
            make.height.equalTo(41)
        }
        
        searchbarSV.addArrangedSubview(arrivalSearchbar)
        arrivalSearchbar.configuration = btnConfig(text: "도착 역명을 검색해주세요.")
        arrivalSearchbar.snp.makeConstraints { make in
            make.width.equalTo(view.width - 95)
            make.height.equalTo(41)
        }
    }
    func configureFlipBtn() {
        searchView.addSubview(flipBtn)
        flipBtn.snp.makeConstraints { make in
            make.centerY.equalTo(searchbarSV.snp.centerY)
            make.leading.equalTo(searchView.snp.leading).offset(12)
        }
    }
    func configureBusBtn() {
        searchView.addSubview(busBtn)
        busBtn.snp.makeConstraints { make in
            make.centerY.equalTo(departureSearchbar.snp.centerY)
            make.trailing.equalTo(searchView.snp.trailing).offset(-19)
        }
    }
}

// MARK: - Action function
extension MainViewController {
    @objc func didTapHistoryBtn() {
        let popUpVC = HistoryPopUpViewController()
        popUpVC.modalTransitionStyle = .crossDissolve
        popUpVC.modalPresentationStyle = .overFullScreen
        present(popUpVC, animated: true)
    }
}

extension MainViewController {
    func btnConfig(text: String) -> UIButton.Configuration {
        var buttonConfig: UIButton.Configuration = UIButton.Configuration.plain()
        var title = AttributedString.init(text)
        title.font = UIFont.Roboto(.regular, size: 14)
        title.foregroundColor = .anza_gray2
        
        let titleWidth = NSAttributedString(title).size().width
        // 145 = left margin(44) - right margin(51) - left padding(16) - right padding(10) - ic_search width(24)
        let padding = view.width - 145 - ceil(titleWidth)
        
        buttonConfig.attributedTitle = title
        buttonConfig.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 10)
        buttonConfig.image = UIImage(named: "ic_search")
        buttonConfig.imagePlacement = .trailing
        buttonConfig.imagePadding = padding
        return buttonConfig
    }
    func getStatusBarHeight() -> CGFloat {
        var statusBarHeight: CGFloat = 0
        if #available(iOS 15.0, *) {
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            let window = windowScene?.windows.first
            statusBarHeight = window?.safeAreaInsets.top ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        return statusBarHeight
    }
}
