//
//  HistoryPopUpViewViewController.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/06/07.
//

import UIKit
import SnapKit
import Then

class HistoryPopUpViewController: UIViewController {
    private let containerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let titleLabel = UILabel()
    private let depatureLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.text = "출발역"
        $0.font = UIFont.Roboto(.regular, size: 14)
        $0.textAlignment = .center
        $0.textColor = .anza_blue
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let transferLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.text = "환승역"
        $0.font = UIFont.Roboto(.regular, size: 14)
        $0.textAlignment = .center
        $0.textColor = .anza_blue
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let arrivalLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.text = "도착역"
        $0.font = UIFont.Roboto(.regular, size: 14)
        $0.textAlignment = .center
        $0.textColor = .anza_blue
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let dismissBtn = UIButton().then {
        $0.backgroundColor = .clear
        $0.setImage(UIImage(named: "ic_xmark"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let completeBtn = UIButton().then {
        $0.backgroundColor = .anza_gray2
        $0.setTitle("완료", for: .normal)
        $0.titleLabel?.font = .Roboto(.bold, size: 14)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 8
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // 현재 선택된 셀 indexpath.row 값
    private var selectedPos = -1;
    private var collectionView: UICollectionView! = nil
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        configureContainerView()
        configureTitleLabel()
        configureDismissBtn()
        configureTableLabel()
        configureCompleteBtn()
        configureCollectionView()
    }
}

// MARK: - Configuration
extension HistoryPopUpViewController {
    // 모달 배경 설정
    func configureContainerView() {
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(390)
            make.width.equalTo(311)
        }
    }
    // 최근 갔던 경로 레이블 설정
    func configureTitleLabel() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.minimumLineHeight = 25
        let attrString = NSAttributedString(string:"최근 갔던 경로",
                                            attributes: [.font: UIFont.Roboto(.bold, size: 18) as Any,
                                                         .paragraphStyle: paragraphStyle,
                                                         .foregroundColor: UIColor.anza_black as Any])
        titleLabel.attributedText = attrString
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(24)
            make.leading.equalTo(containerView.snp.leading).offset(24)
        }
    }
    // 출발역, 환승역, 도착역 레이블 설정
    func configureTableLabel() {
        containerView.addSubview(depatureLabel)
        depatureLabel.snp.makeConstraints { make in
            make.leading.equalTo(containerView.snp.leading).offset(40)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        containerView.addSubview(transferLabel)
        transferLabel.snp.makeConstraints { make in
            make.centerX.equalTo(containerView.snp.centerX)
            make.centerY.equalTo(depatureLabel.snp.centerY)
        }
        containerView.addSubview(arrivalLabel)
        arrivalLabel.snp.makeConstraints { make in
            make.trailing.equalTo(containerView.snp.trailing).offset(-40)
            make.centerY.equalTo(depatureLabel.snp.centerY)
        }
    }
    // 완료 버튼 설정
    func configureCompleteBtn() {
        containerView.addSubview(completeBtn)
        completeBtn.addTarget(self, action: #selector(didTapCompleteBtn), for: .touchUpInside)
        completeBtn.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(containerView)
            make.height.equalTo(55)
        }
    }
    // 닫기 버튼 설정
    func configureDismissBtn() {
        containerView.addSubview(dismissBtn)
        dismissBtn.addTarget(self, action: #selector(didTapDismissBtn), for: .touchUpInside)
        dismissBtn.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.trailing.equalTo(containerView.snp.trailing).offset(-24)
        }
    }
    // 컬렉션 뷰 설정
    func createLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(layoutSize:
                                            NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                   heightDimension: .fractionalHeight(1.0)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize:
                                                        NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                               heightDimension: .absolute(48)),
                                                     subitem: item,
                                                     count: 1)
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout()).then {
            $0.backgroundColor = .white
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.dataSource = self
            $0.delegate = self
            $0.register(HistoryPopUpCollectionViewCell.self,
                        forCellWithReuseIdentifier: HistoryPopUpCollectionViewCell.identifier)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        containerView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(transferLabel.snp.bottom).offset(9.5)
            make.bottom.equalTo(completeBtn.snp.top)
            make.leading.equalTo(containerView.snp.leading)
            make.trailing.equalTo(containerView.snp.trailing)
        }
    }
}

// MARK: - Action function
extension HistoryPopUpViewController {
    @objc func didTapDismissBtn() {
        dismiss(animated: true, completion: nil)
    }
    @objc func didTapCompleteBtn() {
        if selectedPos != -1 {
            print(selectedPos)
            dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - UICollectionView Delegate, DataSource
extension HistoryPopUpViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryPopUpCollectionViewCell.identifier,
                                                            for: indexPath) as? HistoryPopUpCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        if selectedPos == indexPath.row {
            cell.backgroundColor = .anza_light_blue2
            cell.configure(depature: "동대문역사문화공원", transfer: "동대문역사공원", arrival: "서울대입구", color: .anza_blue)
        } else {
            cell.backgroundColor = .white
            cell.configure(depature: "동대문역사문화공원", transfer: "동대문역사공원", arrival: "서울대입구", color: .anza_black)
        }
        cell.setConstraints(departure: depatureLabel.snp.centerX, transfer: transferLabel.snp.centerX, arrival: arrivalLabel.snp.centerX)
        cell.layer.addBorder([.top], color: .anza_light_gray!, width: 1)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        selectedPos = indexPath.row
        completeBtn.backgroundColor = .anza_blue
        collectionView.reloadData()
    }
}
