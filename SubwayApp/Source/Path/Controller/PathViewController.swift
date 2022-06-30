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
    private let shortestTimeButton = UIButton().then {
        $0.setAttributedTitle(.anza_b4_2(text: "최단시간", color: .anzaBlack), for: .normal)
    }
    private let shortestTransferButton = UIButton().then {
        $0.setAttributedTitle(.anza_b4_2(text: "최단환승", color: .anzaBlack), for: .normal)
    }
    private let underline = UIView().then {
        $0.backgroundColor = .anzaGray4
    }
    private let dottedLine = UIView().then {
        $0.backgroundColor = .gray3
    }
    private let selectedLine = UIView().then {
        $0.backgroundColor = .anzaBlack
    }
    private let closeButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_xmark"), for: .normal)
    }
    private let titleLabel = UILabel().then {
        $0.attributedText = .anza_b2(text: "소요시간", color: .anzaGray1)
    }
    private let timeLabel = UILabel().then {
        $0.attributedText = .anza_t1(text: "00분", color: .anzaBlack)
    }
    private let depatureView = PathView()
    private var depatureViewHeight:CGFloat = 136
    private var toggled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureControlButton()
        configureCloseButton()
        configureUnderLine()
        configureSelectUnderLine()
        configureTitleLabel()
        configureTimeLabel()
        configureDepatureview()
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

// MARK: - Configuration
extension PathViewController {
    func configureControlButton() {
        view.addSubview(shortestTimeButton)
        shortestTimeButton.addTarget(self, action: #selector(changeUnderLinePosition), for: .touchUpInside)
        shortestTimeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(view.getStatusBarHeight() + 22.2)
            make.leading.equalToSuperview().offset(24)
        }
        view.addSubview(shortestTransferButton)
        shortestTransferButton.addTarget(self, action: #selector(changeUnderLinePosition), for: .touchUpInside)
        shortestTransferButton.snp.makeConstraints { make in
            make.centerY.equalTo(shortestTimeButton)
            make.leading.equalTo(shortestTimeButton.snp.trailing).offset(27)
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
            make.top.equalTo(shortestTimeButton.snp.bottom).offset(10.5)
            make.height.equalTo(1)
        }
    }
    func configureSelectUnderLine() {
        view.addSubview(selectedLine)
        selectedLine.snp.makeConstraints { make in
            make.top.equalTo(shortestTimeButton.snp.bottom).offset(9.5)
            make.width.equalTo(shortestTimeButton)
            make.height.equalTo(1)
            make.centerX.equalTo(shortestTimeButton)
        }
    }
    func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(shortestTimeButton.snp.bottom).offset(33)
            make.leading.equalToSuperview().offset(24)
        }
    }
    func configureTimeLabel() {
        view.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.trailing.equalTo(titleLabel)
        }
    }
    func configureDepatureview() {
        view.addSubview(depatureView)
        depatureView.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(22)
            make.leading.trailing.equalToSuperview()
            make.height.greaterThanOrEqualTo(depatureViewHeight)
        }
    }
}

// MARK: Action Function
extension PathViewController {
    @objc func changeUnderLinePosition() {
        toggled.toggle()
        selectedLine.snp.remakeConstraints { make in
            make.top.equalTo(toggled ? shortestTransferButton.snp.bottom : shortestTimeButton.snp.bottom).offset(9.5)
            make.width.equalTo(shortestTimeButton)
            make.height.equalTo(1)
            make.centerX.equalTo(toggled ? shortestTransferButton : shortestTimeButton)
        }
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    @objc func didTapCloseButton() {
        dismiss(animated: true)
    }
}
