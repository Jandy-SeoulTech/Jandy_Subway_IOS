//
//  ContentViewCollectionViewCell.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/07/02.
//

import UIKit
import SnapKit
import Then

class ContentViewCollectionViewCell: UICollectionViewCell {
    static let identifier = "ContentViewCollectionViewCell"
    
    private let titleLabel = UILabel().then {
        $0.attributedText = .anza_b2(text: "소요시간", color: .anzaGray1)
    }
    private let timeLabel = UILabel().then {
        $0.attributedText = .anza_t1(text: "00분", color: .anzaBlack)
    }
    private lazy var departureView = PathView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("ContentViewCollectionViewCell init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        configureTitleLabel()
        configureTimeLabel()
        configureDepatureView()
    }
    override func prepareForReuse() {
        titleLabel.text = ""
        timeLabel.text = ""
    }
}
// MARK: - configuration
extension ContentViewCollectionViewCell {
    func configure(time: String, model: [String]) {
        timeLabel.text = time
        departureView.configure(with: model)
    }
    func configureDepatureView() {
        addSubview(departureView)
        departureView.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21.5)
            make.leading.equalToSuperview().offset(24)
        }
    }
    func configureTimeLabel() {
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.trailing.equalTo(titleLabel)
        }
    }
}
