//
//  TabbarViewCell.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/07/02.
//

import UIKit
import SnapKit
import Then

class TabbarViewCell: UICollectionViewCell {
    static let identifier = "TabbarViewCell"
    
    let title = UILabel().then {
        $0.attributedText = .anza_b4_2(text: "기본", color: .anzaBlack)
    }
    override var isSelected: Bool {
        didSet {
            title.textColor = isSelected ? .anzaBlack : .anzaGray1
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(title)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        title.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}

// MARK: - Configuration
extension TabbarViewCell {
    func configure(name: String, color: UIColor?) {
        title.attributedText = .anza_b4_2(text: name, color: color)
    }
}
