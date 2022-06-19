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
        $0.backgroundColor = .anzaBlue
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
    /// Chips: 지금 탑승 중인 열차가 있어요.
    private let chips = UIButton().then {
        $0.backgroundColor = .anzaBlack?.withAlphaComponent(0.85)
        $0.layer.cornerRadius = 20
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private var departureSearchbar = UIButton().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.anzaGray1?.cgColor
        $0.layer.cornerRadius = 4
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private var transferSearchbar: UIButton = UIButton().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.anzaGray1?.cgColor
        $0.layer.cornerRadius = 4
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private var arrivalSearchbar: UIButton = UIButton().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.anzaGray1?.cgColor
        $0.layer.cornerRadius = 4
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let searchbarSV = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.distribution = .fillProportionally
        $0.alignment = .center
        $0.isUserInteractionEnabled = true
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
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureHistoryBtn()
        configureSearchView()
        configureSearchbarSV()
        configureFlipBtn()
        configureBusBtn()
        configureNavigationBar()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
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
            //make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(searchViewHeightConstraint)
        }
    }
    func configureSearchbarSV() {
        searchView.addSubview(searchbarSV)
        searchbarSV.snp.makeConstraints { make in
            make.leading.equalTo(searchView.snp.leading).offset(44)
            make.trailing.equalTo(searchView.snp.trailing).offset(-51)
            make.top.equalTo(searchView.snp.top).offset(7)
            make.bottom.equalTo(searchView.snp.bottom).offset(-10)
        }
        
        searchbarSV.addArrangedSubview(departureSearchbar)
        departureSearchbar.addTarget(self, action: #selector(didTapDepatureBtn), for: .touchUpInside)
        departureSearchbar.configuration = searchbarConfig(text: "출발 역명을 검색해주세요.", color: .anzaGray2)
        departureSearchbar.snp.makeConstraints { make in
            make.width.equalTo(view.width - 95)
            make.height.equalTo(41)
        }
        
        searchbarSV.addArrangedSubview(arrivalSearchbar)
        arrivalSearchbar.addTarget(self, action: #selector(didTapArrivalBtn), for: .touchUpInside)
        arrivalSearchbar.configuration = searchbarConfig(text: "도착 역명을 검색해주세요.", color: .anzaGray2)
        arrivalSearchbar.snp.makeConstraints { make in
            make.width.equalTo(view.width - 95)
            make.height.equalTo(41)
        }
    }
    func configureFlipBtn() {
        searchView.addSubview(flipBtn)
        flipBtn.addTarget(self, action: #selector(didTapFlipBtn), for: .touchUpInside)
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
    func configureNavigationBar() {
        let backImage = UIImage(named: "ic_chevron_left")?.withAlignmentRectInsets(
            UIEdgeInsets(top: 0,
                         left: -9,
                         bottom: 0,
                         right: 0))
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backButton.tintColor = .anzaBlack;
        self.navigationItem.backBarButtonItem = backButton
    }
    func configureChipBtn() {
        var buttonConfig: UIButton.Configuration = UIButton.Configuration.plain()
        var title = AttributedString.init("지금 탑승 중인 열차가 있어요!")
        title.font = UIFont.NotoSans(.regular, size: 14)
        title.foregroundColor = .white
        buttonConfig.attributedTitle = title
        buttonConfig.titleAlignment = .center
        buttonConfig.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
        chips.configuration = buttonConfig
        searchView.addSubview(chips)
        chips.snp.makeConstraints { make in
            make.top.equalTo(busBtn.snp.bottom).offset(2)
            make.trailing.equalTo(searchView.snp.trailing).offset(-21)
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
    @objc func didTapDepatureBtn() {
        let searchVC = SearchViewController()
        searchVC.delegate = self
        searchVC.index = 0
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    @objc func didTapArrivalBtn() {
        let searchVC = SearchViewController()
        searchVC.delegate = self
        searchVC.index = 2
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    @objc func didTapFlipBtn() {
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
}

// MARK: - SearchViewControllerDelegate
extension MainViewController: SearchViewControllerDelegate {
    func didTapStation(id: Int?, line: String, station: String) {
        guard let id = id else {
            return
        }
        switch id {
        case 0:
            departureSearchbar.configuration = searchbarConfig(text: station, color: .anzaBlack)
            break
        case 1:
            transferSearchbar.configuration = searchbarConfig(text: station, color: .anzaBlack)
            break
        case 2:
            arrivalSearchbar.configuration = searchbarConfig(text: station, color: .anzaBlack)
            break
        default:
            departureSearchbar.configuration = searchbarConfig(text: station, color: .anzaBlack)
            break
        }
    }
}
extension MainViewController {
    func searchbarConfig(text: String, color: UIColor?) -> UIButton.Configuration {
        var buttonConfig: UIButton.Configuration = UIButton.Configuration.plain()
        var title = AttributedString.init(text)
        title.font = UIFont.NotoSans(.regular, size: 14)
        title.foregroundColor = color
        
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
    /// 현재 뷰의 상태 바 높이를 가져오는 메서드
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
