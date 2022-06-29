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
    private let segmentControl = UISegmentedControl().then {
        $0.selectedSegmentTintColor = .clear
        
        // 배경 색 제거
        //$0.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        // Segment 구분 라인 제거
        $0.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        $0.insertSegment(withTitle: "최단시간", at: 0, animated: true)
        $0.insertSegment(withTitle: "최소환승", at: 1, animated: true)
        
        $0.selectedSegmentIndex = 0
        
        // 선택 되어 있지 않을때 폰트 및 폰트컬러
        $0.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.anzaBlack!,
            NSAttributedString.Key.font: UIFont.NotoSans(.regular, size: 16)
        ], for: .normal)
        
        // 선택 되었을때 폰트 및 폰트컬러
        $0.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.anzaBlack!,
            NSAttributedString.Key.font: UIFont.NotoSans(.regular, size: 16)
        ], for: .selected)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let underLineView = UIView().then {
        $0.backgroundColor = .anzaBlack
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "소요시간"
        $0.textColor = .anzaGray1
        $0.font = .NotoSans(.regular, size: 14)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let timeLabel = UILabel().then {
        $0.textColor = .anzaBlack
        $0.attributedText = .anza_t1(with: "00분")
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let depatureView = PathView()
    private let depatureView2 = PathView()
    private var depatureViewHeight:CGFloat = 136
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureSegmentControl()
        configureUnderLineView()
        configureTitleLabel()
        configureTimeLabel()
        configureDepatureview()
        configureDepatureview2()
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
    func configureSegmentControl() {
        view.addSubview(segmentControl)
        segmentControl.addTarget(self, action: #selector(changeUnderLinePosition), for: .valueChanged)
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(18.2)
            make.leading.equalToSuperview().offset(24)
            make.width.equalTo(200)
        }
    }
    func configureUnderLineView() {
        view.addSubview(underLineView)
        underLineView.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(9.5)
            make.width.equalTo(segmentControl).multipliedBy(0.5)
            make.height.equalTo(1)
            make.leading.equalTo(segmentControl)
        }
    }
    func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(segmentControl.snp.bottom).offset(33)
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
    func configureDepatureview2() {
        view.addSubview(depatureView2)
        depatureView2.snp.makeConstraints { make in
            make.top.equalTo(depatureView.snp.bottom).offset(85)
            make.leading.trailing.equalToSuperview()
            make.height.greaterThanOrEqualTo(depatureViewHeight)
        }
    }
}

// MARK: Action Function
extension PathViewController {
    @objc private func changeUnderLinePosition() {
        let index = CGFloat(segmentControl.selectedSegmentIndex)
        let width = segmentControl.frame.width / CGFloat(segmentControl.numberOfSegments)
        let leading = width * index
        print(leading)
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
//            self?.underLineView.snp.updateConstraints({ make in
//                make.leading.equalTo(100)
//            })
            self?.view.layoutIfNeeded()
        })
    }
}
