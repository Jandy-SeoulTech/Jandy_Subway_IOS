//
//  MainViewController.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/05/02.
//

import UIKit
import SnapKit
import Then

class MainViewController: UIViewController {
    private let tempBtn = UIButton().then {
        $0.backgroundColor = .brown
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    @objc func didTapBtn() {
        let vc = SearchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tempBtn)
        tempBtn.addTarget(self, action: #selector(didTapBtn), for: .touchUpInside)
        tempBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        configureNavigationBar()
    }
}

extension MainViewController {
    func configureNavigationBar() {
        let backImage = UIImage(named: "CaretLeft")?.withAlignmentRectInsets(UIEdgeInsets(top: 0,
                                                                                          left: -5,
                                                                                          bottom: 5,
                                                                                          right: 0))
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backButton.tintColor = .black
        self.navigationItem.backBarButtonItem = backButton
    }
    
}
