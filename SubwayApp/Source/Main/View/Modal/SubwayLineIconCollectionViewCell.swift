//
//  SubwayLineIconCollectionViewCell.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/07/07.
//

import UIKit
import SnapKit
import Then

class SubwayLineIconCollectionViewCell: UICollectionViewCell {
    static let identifier = "SubwayLineIconCollectionViewCell"
    
    private let icon = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(icon)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        icon.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        icon.image = nil
    }
    func configure(with name: String) {
        icon.image = UIImage(named: name)
    }
}
