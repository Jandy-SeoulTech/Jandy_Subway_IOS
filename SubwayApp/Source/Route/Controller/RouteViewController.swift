//
//  SubwayRouteViewController.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/06/25.
//

import UIKit
import SnapKit
import Then

class RouteViewController: UIViewController {
    private lazy var tabbar = TabbarView().then {
        $0.delegate = self
    }
    private lazy var routeView = UICollectionView(
        frame: .zero,
        collectionViewLayout: layout()).then {
            $0.delegate = self
            $0.dataSource = self
            $0.showsVerticalScrollIndicator = false
            $0.showsHorizontalScrollIndicator = false
            $0.register(RouteViewCell.self,
                        forCellWithReuseIdentifier:
                            RouteViewCell.identifier)
        }
    private lazy var closeButton = UIButton().then {
        $0.setImage(UIImage(named: "ic_xmark"), for: .normal)
        $0.addTarget(self,
                     action: #selector(didTapCloseButton),
                     for: .touchUpInside)
    }
    private let underline = UIView().then {
        $0.backgroundColor = .anzaGray4
    }
    private let selectedLine = UIView().then {
        $0.backgroundColor = .anzaBlack
    }
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
extension RouteViewController: TabbarViewDelegate {
    func tabbarView(_ tabbar: UICollectionView, index: Int) {
        routeView.scrollToItem(at: IndexPath(row: index, section: 0),
                             at: .centeredHorizontally,
                             animated: true)
        routeView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}

// MARK: - Configuration
extension RouteViewController {
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
        view.addSubview(routeView)
        routeView.snp.makeConstraints { make in
            make.top.equalTo(underline.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: Action Function
extension RouteViewController {
    @objc func didTapCloseButton() {
        dismiss(animated: true)
    }
}

// MARK: - CollectionView Delegate, DataSource
extension RouteViewController: UICollectionViewDelegate,
                              UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RouteViewCell.identifier,
            for: indexPath) as? RouteViewCell else {
            return UICollectionViewCell()
        }
        let temp = ["인천", "광역시", "공릉","인천", "광역시", "공릉","인천", "광역시", "공릉",
                    "인천", "광역시", "공릉","인천", "광역시", "공릉","인천", "광역시", "공릉"]
        if indexPath.row  == 0 {
            cell.configure(time: "51분", model: temp)
        } else {
            cell.configure(time: "57분", model: temp)
        }
        return cell
    }
    func layout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0)))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0)),
            subitem: item,
            count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        return UICollectionViewCompositionalLayout(section: section)
    }
}
