//
//  SearchViewController.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/06/05.
//

import UIKit
import SnapKit
import Then

class SearchViewController: UIViewController {
    private let searchBar = UISearchBar().then {
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(hex: 0xBDBDBD).cgColor
        $0.setImage(UIImage(), for: .search, state: .normal)
        $0.isTranslucent = true
        $0.barTintColor = .white
        $0.placeholder = ""
        $0.tintColor = UIColor(hex: 0x205EFF)
        $0.searchTextField.backgroundColor = .white
        $0.searchTextField.textColor = UIColor(hex: 0x212121)
        $0.searchTextField.font = .systemFont(ofSize: 14, weight: .regular)
    }
    private let lineLabel = UILabel().then {
        $0.text = "호선 검색"
        $0.textColor = UIColor(hex: 0x9E9E9E)
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.backgroundColor = .clear
        $0.sizeToFit()
    }
    private let chevronImage = UIImageView().then {
        $0.image = UIImage(named: "default.chevron.down")
        $0.backgroundColor = .clear
    }
    private var lineStateView = UIStackView().then {
        $0.spacing = 7
        $0.backgroundColor = UIColor(hex: 0xF4F4F4)
        $0.alignment = .center
        $0.axis = .horizontal
        $0.isLayoutMarginsRelativeArrangement = true
        $0.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 15)
        $0.layer.cornerRadius = 15.5
        $0.layer.masksToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private var searchResultCollectionView: UICollectionView! = nil
    
    var patialText: String = ""
    var filteredData: [String]!
    // 임시 데이터
    var model: [String] = ["역", "역리스트", "역리스트가", "역리스트가아직없다", "홍대입구", "합정", "신도림", "하계", "하남"]
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        searchBar.delegate = self
        dismissKeyboard()
        configureNavigationBar()
        configureLineStateView()
        configureSearchResultCollectionView()
        NotificationCenter.default.addObserver(self, selector: #selector(changeLineLabel), name: Notification.Name(rawValue: "subway_line"), object: nil)
        // Get data from data base
        filteredData = model
    }
}

extension SearchViewController {
    // MARK: Configuration
    func configureNavigationBar() {
        let backbuttonSize:CGFloat = self.navigationController?.navigationBar.backIndicatorImage?.size.width ?? 32
        searchBar.snp.makeConstraints { make in
            make.width.equalTo(view.width - backbuttonSize - 60)
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
    }
    func configureLineStateView() {
        view.addSubview(lineStateView)
        lineStateView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.height.equalTo(32)
        }
        lineStateView.addArrangedSubview(lineLabel)
        lineStateView.addArrangedSubview(chevronImage)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapSearchButton))
        lineStateView.addGestureRecognizer(gesture)
    }
    func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0)))
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(60)),
            subitem: item,
            count: 1)
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    func configureSearchResultCollectionView() {
        searchResultCollectionView = UICollectionView(frame: .zero,
                                                      collectionViewLayout: configureCollectionViewLayout())
        view.addSubview(searchResultCollectionView)
        searchResultCollectionView.backgroundColor = UIColor(hex: 0xffffff)
        searchResultCollectionView.dataSource = self
        searchResultCollectionView.delegate = self
        searchResultCollectionView.translatesAutoresizingMaskIntoConstraints = false
        searchResultCollectionView.snp.makeConstraints { make in
            make.top.equalTo(lineStateView.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalToSuperview()
        }
        searchResultCollectionView.register(SubwayLineCollectionViewCell.self,
                                            forCellWithReuseIdentifier: SubwayLineCollectionViewCell.identifier)
    }
    // MARK: Event method
    @objc func changeLineLabel(_ notification : Notification) {
        if let dic = notification.object as? [String: String] {
            guard let name = dic["name"], let color = dic["color"] else { return }
            self.lineLabel.text = name
            self.lineLabel.textColor = UIColor(hex: 0xffffff)
            self.chevronImage.image = UIImage(named: "chevron.down")
            self.lineStateView.backgroundColor = UIColor(hex: Int(color)!)
        }
    }
    @objc func didTapSearchButton() {
        self.searchBar.resignFirstResponder()
        let vc = LineSelectModalViewController()
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: false)
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    // Dismiss keyboard when tap outside view
    func dismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action:#selector(dismissKeyboardTouchOutside))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    // Clear search bar and dismiss keyboard
    @objc func dismissKeyboardTouchOutside() {
        self.searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? model : model.filter({ $0.hasPrefix(searchText) })
        patialText = searchText
        searchResultCollectionView.reloadData()
    }
    // Dismiss keyboard when click search button
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
}

// MARK: - CollectionView data source, delegate
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SubwayLineCollectionViewCell.identifier,
            for: indexPath) as? SubwayLineCollectionViewCell else {
                return UICollectionViewCell()
            }
        if patialText.isEmpty {
            cell.configure(number: "2", name: filteredData[indexPath.row], color: 0x009D3E)
        } else {
            cell.configure(number: "2", name: filteredData[indexPath.row], color: 0x009D3E, patial: patialText)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        // Send data to previous view controller
        navigationController?.popViewController(animated: true)
    }
}
