//
//  SubwayMapView.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/06/29.
//

import UIKit
import SnapKit
import Then

class SubwayMapView: UIScrollView {
    private let subwayMap = UIImageView().then {
        $0.image = UIImage(named: "subway_map")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(subwayMap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("SubwayMapView init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        configureView()
        configureSubwayMap()
    }
}

// MARK: - Configuration
extension SubwayMapView {
    func configureView() {
        contentSize = CGSize(width: 1800, height: 1300)
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
    func configureSubwayMap() {
        subwayMap.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
