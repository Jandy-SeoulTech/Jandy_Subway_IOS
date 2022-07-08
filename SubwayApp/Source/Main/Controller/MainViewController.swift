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
    }
    private lazy var searchbarView = SearchbarView().then {
        $0.backgroundColor = .white
        $0.layer.masksToBounds = false
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        $0.layer.shadowRadius = 3
        $0.layer.shadowOpacity = 1.0
        $0.layer.shadowOffset = CGSize(width: 0, height: 6)
    }
    private lazy var subwayMapView = SubwayMapView()
    private var searchViewHeightConstraint = 107
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureSearchView()
        configureSubwayView()
        configureHistoryBtn()
        configureNavigationBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        view.addSubview(searchbarView)
        searchbarView.delegate = self
        searchbarView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(view.getStatusBarHeight())
            //make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(searchViewHeightConstraint)
        }
    }
    func configureSubwayView() {
        view.addSubview(subwayMapView)
        subwayMapView.delegate = self
        subwayMapView.snp.makeConstraints { make in
            make.top.equalTo(searchbarView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
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

// MARK: - ScrollView Delegate
extension MainViewController: UIScrollViewDelegate {
    
}

// MARK: - SearchbarView Delegate
extension MainViewController: SearchbarViewDelegate {
    func searchbarView(_ searchbarView: SearchbarView, didTapSearchbarAt index: Int) {
        let searchViewController = SearchViewController()
        searchViewController.delegate = self
        searchViewController.index = index
        self.navigationController?.pushViewController(searchViewController, animated: true)
    }
}

// MARK: - SearchViewController Delegate
extension MainViewController: SearchViewControllerDelegate {
    func didTapStation(id: Int?, line: String, station: String) {
        guard let id = id else {
            return
        }
        switch id {
        case 0:
            searchbarView.changeDepartureStation(text: station, color: .anzaBlack)
            break
        case 1:
            searchbarView.changeTransferStation(text: station, color: .anzaBlack)
            break
        case 2:
            searchbarView.changeArrivalStation(text: station, color: .anzaBlack)
            break
        default:
            break
        }
    }
}
