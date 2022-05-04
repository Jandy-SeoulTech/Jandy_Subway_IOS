//
//  SearchViewController.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/05/02.
//

import UIKit
import SnapKit
import Then

class SearchViewController: UIViewController {
    private var selectButton = UIBarButtonItem().then {
        $0.image = UIImage(named: "ComboBox")
        $0.tintColor = UIColor(hex: 0x212121)
        $0.style = .plain
        $0.action = #selector(didTapComboBox)
    }
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
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        
    }
}

extension SearchViewController {
    func configureNavigationBar() {
        let selectButtonSize:CGFloat = selectButton.image?.size.width ?? 45
        let backbuttonSize:CGFloat = self.navigationController?.navigationBar.backIndicatorImage?.size.width ?? 32
        searchBar.snp.makeConstraints { make in
            make.width.equalTo(view.width - backbuttonSize - selectButtonSize - 60)
        }
        selectButton.target = self
        self.navigationItem.rightBarButtonItems = [selectButton, UIBarButtonItem(customView: searchBar)]
    }
    @objc func didTapComboBox() {
        let vc = HalfModalPresentationController()
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: false)
    }
}
