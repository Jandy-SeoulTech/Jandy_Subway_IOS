//
//  StationModalViewController.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/07/07.
//

import UIKit
import SnapKit
import Then

class StationModalViewController: UIViewController {
    private lazy var dimmedView = UIView().then {
        $0.backgroundColor = UIColor.white.withAlphaComponent(0)
        $0.addGestureRecognizer(
            UITapGestureRecognizer(target: self,
                                   action: #selector(didTapCloseButton)))
    }
    private let containerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.masksToBounds = false
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.35).cgColor
        $0.layer.shadowRadius = 6
        $0.layer.shadowOpacity = 1.0
        $0.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    private lazy var closeButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_xmark_thin"), for: .normal)
        $0.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
    }
    private lazy var refreshButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_refresh"), for: .normal)
        $0.addTarget(self, action: #selector(didTapRefreshButton), for: .touchUpInside)
    }
    private let borderLine = UIView().then {
        $0.backgroundColor = .anzaGray4
    }
    private let centerBorderLine = UIView().then {
        $0.backgroundColor = .anzaGray4
    }
    private lazy var centerView = ModalCenterView()
    private lazy var leftView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    private lazy var rightView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: collectionViewLayout()).then {
        $0.isPagingEnabled = false
        $0.showsHorizontalScrollIndicator = false
        $0.delegate = self
        $0.dataSource = self
        $0.register(SubwayLineIconCollectionViewCell.self,
                    forCellWithReuseIdentifier: SubwayLineIconCollectionViewCell.identifier)
    }
    var stationInfo = ["상월곡", "들곶이", "석계"]
    var model = ["ic_six_circle", "ic_one_circle"]
    private let modalHeight = 197
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDimmedView()
        configureContainerView()
        configureColelctionView()
        configureCloseButton()
        configureRefreshButton()
        configureBorderLine()
        configureCenterView()
        configureLeftView()
        configureCenterBorderLine()
        configureRightView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animatePresentContainer()
    }
}

// MARK: - Configuration
extension StationModalViewController {
    func configureDimmedView() {
        view.addSubview(dimmedView)
        dimmedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    func configureContainerView() {
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(modalHeight)
            make.height.equalTo(modalHeight)
        }
    }
    func configureColelctionView() {
        containerView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(12)
            make.leading.equalTo(containerView).offset(16)
            make.height.equalTo(24)
            make.width.equalTo(30 * model.count)
        }
    }
    func configureCloseButton() {
        containerView.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.top.equalTo(containerView).offset(12)
            make.trailing.equalTo(containerView).offset(-16)
        }
    }
    func configureRefreshButton() {
        containerView.addSubview(refreshButton)
        refreshButton.snp.makeConstraints { make in
            make.centerY.equalTo(closeButton)
            make.trailing.equalTo(closeButton.snp.leading).offset(-6)
        }
    }
    func configureBorderLine() {
        containerView.addSubview(borderLine)
        borderLine.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(11.5)
            make.width.equalTo(containerView)
            make.height.equalTo(1)
        }
    }
    func configureCenterView() {
        centerView.configure(prev: stationInfo[0], current: stationInfo[1], next: stationInfo[2])
        containerView.addSubview(centerView)
        centerView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(containerView)
            make.top.equalTo(borderLine.snp.bottom).offset(11.5)
            make.height.equalTo(37)
        }
    }
    func configureCenterBorderLine() {
        containerView.addSubview(centerBorderLine)
        centerBorderLine.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.height.equalTo(43)
            make.centerX.equalTo(containerView)
            make.top.equalTo(leftView)
        }
    }
    func configureLeftView() {
        containerView.addSubview(leftView)
        leftView.snp.makeConstraints { make in
            make.leading.equalTo(containerView).offset(16)
            make.trailing.equalTo(containerView.snp.centerX).offset(-18.5)
            make.top.equalTo(containerView).offset(112)
            make.height.equalTo(50)
        }
        // 데이터 left view에 넣으면 됨.
    }
    func configureRightView() {
        containerView.addSubview(rightView)
        rightView.snp.makeConstraints { make in
            make.leading.equalTo(containerView.snp.centerX).offset(13.5)
            make.trailing.equalTo(containerView).offset(-20)
            make.top.equalTo(leftView)
            make.height.equalTo(50)
        }
        // 데이터 right view에 넣으면 됨.
    }
}

// MAKR: - Collection View Delegate, DataSource
extension StationModalViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(24),
                                               heightDimension: .absolute(24)))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(24)),
            subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(6)
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SubwayLineIconCollectionViewCell.identifier,
            for: indexPath) as? SubwayLineIconCollectionViewCell else {
            return SubwayLineIconCollectionViewCell()
        }
        cell.configure(with: model[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 데이터 가져와서 뷰 바꿔주면 됨
        //containerView.layoutIfNeeded()
    }
}

// MARK: - Action Function
extension StationModalViewController {
    @objc func didTapCloseButton() {
        animateDismissContainer()
    }
    @objc func didTapRefreshButton() {
        print("refresh")
    }
}

// MARK: - Animation Function
extension StationModalViewController {
    func animatePresentContainer() {
        containerView.snp.updateConstraints { make in
            make.bottom.equalToSuperview()
        }
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    func animateDismissContainer() {
        containerView.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(375)
        }
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.view.layoutIfNeeded()
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
}
