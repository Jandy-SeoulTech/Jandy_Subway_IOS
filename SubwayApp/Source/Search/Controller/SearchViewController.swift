//
//  SearchViewController.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/06/05.
//

import UIKit
import SnapKit
import Then

protocol SearchViewControllerDelegate: AnyObject {
    func didTapStation(id: Int?, line: String, station: String)
}
class SearchViewController: UIViewController {
    weak var delegate: SearchViewControllerDelegate?
    
    private let searchBar = UISearchBar().then {
        $0.layer.masksToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 4
        $0.layer.borderColor = UIColor(hex: 0xBDBDBD).cgColor
        $0.setImage(UIImage(), for: .search, state: .normal)
        $0.isTranslucent = true
        $0.barTintColor = .white
        $0.placeholder = ""
        $0.searchTextField.backgroundColor = .white
        $0.searchTextField.textColor = .anzaBlack
        $0.searchTextField.font = .NotoSans(.regular, size: 14)
    }
    private let lineImage = UIImageView().then {
        $0.image = UIImage(named: "ic_select")
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private var searchResultCollectionView: UICollectionView! = nil
    
    var index: Int?
    var patialText: String = ""
    var filteredData = [Information]()
    var model = [Information]()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        fetchData(line: "전체")
        dismissKeyboard()
        
        configureNavigationBar()
        configureLineImage()
        configureSearchResultCollectionView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeLineLabel), name: Notification.Name(rawValue: "subway_line"), object: nil)
    }
}
extension SearchViewController {
    func fetchData(line: String) {
        SearchViewService.shared.getSubway(line: line) { response in
            switch response {
            case .success(let model):
                guard let model = model as? [Information] else { return }
                self.model = model
                self.filteredData = model
                DispatchQueue.main.async {
                    self.searchResultCollectionView.reloadData()
                }
            case .networkFail:
                print("network fail")
            case .requestErr(let error):
                print(error)
            case .pathErr:
                print("path error")
            default:
                print("error")
            }
        }
    }
}

// MARK: Configuration
extension SearchViewController {
    func configureNavigationBar() {
        guard let width = navigationController?.navigationBar.width else { return }
        searchBar.snp.makeConstraints { make in
            make.width.equalTo(width - 84)
        }
        searchBar.delegate = self
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = 24
        let rightBarButton = [spacer, UIBarButtonItem(customView: searchBar)]
        self.navigationItem.rightBarButtonItems = rightBarButton
    }
    func configureLineImage() {
        view.addSubview(lineImage)
        lineImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapSearchButton))
        lineImage.addGestureRecognizer(gesture)
        lineImage.isUserInteractionEnabled = true
    }
    func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0)))
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(56)),
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
        searchResultCollectionView.backgroundColor = .white
        searchResultCollectionView.dataSource = self
        searchResultCollectionView.delegate = self
        searchResultCollectionView.translatesAutoresizingMaskIntoConstraints = false
        searchResultCollectionView.showsVerticalScrollIndicator = false
        searchResultCollectionView.snp.makeConstraints { make in
            make.top.equalTo(lineImage.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalToSuperview()
        }
        searchResultCollectionView.register(SubwayLineCollectionViewCell.self,
                                            forCellWithReuseIdentifier: SubwayLineCollectionViewCell.identifier)
    }
}

// MARK: Action method
extension SearchViewController {
    @objc func changeLineLabel(_ notification : Notification) {
        if let dic = notification.object as? [String: String] {
            guard let name = dic["name"] else { return }
            let icname = "ic_" + LineInformation.shared.convertIcName(name: name)
            lineImage.image = UIImage(named: icname)
            fetchData(line: name)
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
        filteredData = searchText.isEmpty ? model : model.filter({ $0.전철역명.hasPrefix(searchText) })
        patialText = searchText
        self.searchResultCollectionView.reloadData()
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
        cell.layer.addBottomBorder(x: 60, color: .anzaGray4!, width: 1)
        cell.configure(with: filteredData[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        // Send data to previous view controller
        guard let id = index else { return }
        delegate?.didTapStation(id: id, line: filteredData[indexPath.row].호선, station: filteredData[indexPath.row].전철역명)
        navigationController?.popViewController(animated: true)
    }
}
