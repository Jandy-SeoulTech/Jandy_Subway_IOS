//
//  SelectModalViewController.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/07/03.
//

import UIKit
import SnapKit
import Then

class SelectModalViewController: UIViewController {
    private let dimmedAlpha: CGFloat = 0.3
    private lazy var dimmedView = UIView().then {
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                       action: #selector(dismissModal)))
    }
    private let containerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.clipsToBounds = true
    }
    private let titleLabel = UILabel().then {
        $0.attributedText = .anza_b3(text: "다음 열차", color: .anzaGray1)
    }
    private lazy var closeButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_xmark_thin"), for: .normal)
        $0.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
    }
    private lazy var selectView = UICollectionView(
        frame: .zero,
        collectionViewLayout: layout()).then {
            $0.delegate = self
            $0.dataSource = self
            $0.showsVerticalScrollIndicator = false
            $0.isScrollEnabled = false
            $0.register(SelectModalCollectionViewCell.self,
                        forCellWithReuseIdentifier: SelectModalCollectionViewCell.identifier)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDimmedView()
        configureContainerView()
        configureTitleLabel()
        configureCloseButton()
        configureSelectView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateShowDimmedView()
        animatePresentContainer()
    }
}

// MARK: - Configuration
extension SelectModalViewController {
    func configureDimmedView() {
        view.addSubview(dimmedView)
        dimmedView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    func configureContainerView() {
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
            make.bottom.equalToSuperview().offset(200)
        }
    }
    func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(17)
            make.centerX.equalTo(containerView)
        }
    }
    func configureCloseButton() {
        containerView.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.trailing.equalTo(containerView).offset(-16)
            make.centerY.equalTo(titleLabel)
        }
    }
    func configureSelectView() {
        containerView.addSubview(selectView)
        selectView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(17)
            make.leading.trailing.bottom.equalTo(containerView)
        }
    }
    func layout() -> UICollectionViewCompositionalLayout{
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .absolute(view.width),
                                               heightDimension: .absolute(56)))
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0)),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

// MARK: - CollectionView Delegate, DataSource
extension SelectModalViewController: UICollectionViewDelegate,
                                           UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        animateDismissView()
    }
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SelectModalCollectionViewCell.identifier,
            for: indexPath) as? SelectModalCollectionViewCell
        else { return UICollectionViewCell() }
        cell.configure(currentTime: "오후 05:23",
                       desination: "봉화산행",
                       remainTime: "3분 43초",
                       line: UIImage(named: "ic_one_circle")!,
                       congestion: UIImage(named: "ic_normal_path")!)
        return cell
    }
}

// MARK: - Action Function
extension SelectModalViewController {
    @objc func dismissModal() {
        animateDismissView()
    }
}

// MARK: - Animation Function
extension SelectModalViewController {
    func animateShowDimmedView() {
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = self.dimmedAlpha
            self.view.layoutIfNeeded()
        }
    }
    func animatePresentContainer() {
        containerView.snp.updateConstraints { make in
            make.bottom.equalToSuperview()
        }
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
    }
    func animateDismissView() {
        dimmedView.alpha = dimmedAlpha
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            self.dismiss(animated: false)
        }
        containerView.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(200)
        }
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
    }
}
