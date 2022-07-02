//
//  PathViewController.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/06/25.
//

import UIKit
import SnapKit
import Then

class PathViewController: UIViewController {
    private let tabbar = TabbarView()
    private let content = ContentView()
    private let closeButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_xmark"), for: .normal)
    }
    private let underline = UIView().then {
        $0.backgroundColor = .anzaGray4
    }
    private let selectedLine = UIView().then {
        $0.backgroundColor = .anzaBlack
    }
    private var depatureViewHeight:CGFloat = 136
    private var toggled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureTabbar()
        configureCloseButton()
        configureUnderLine()
        configureContent()
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
extension PathViewController: TabbarViewDelegate {
    func tabbarView(_ tabbar: UICollectionView, indexPath: IndexPath) {
        
    }
}
// MARK: - Configuration
extension PathViewController {
    func configureTabbar() {
        view.addSubview(tabbar)
        tabbar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(view.getStatusBarHeight() + 22.2)
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(145)
            make.height.equalTo(24)
        }
    }
    func configureCloseButton() {
        view.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(view.getStatusBarHeight() + 18.2)
            make.trailing.equalToSuperview().offset(-24)
            make.width.height.equalTo(24)
        }
    }
    func configureUnderLine() {
        view.addSubview(underline)
        underline.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(tabbar.snp.bottom).offset(10.5)
            make.height.equalTo(1)
        }
    }
    func configureContent() {
        view.addSubview(content)
        content.snp.makeConstraints { make in
            make.top.equalTo(underline.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: Action Function
extension PathViewController {
    @objc func didTapCloseButton() {
        dismiss(animated: true)
    }
}
