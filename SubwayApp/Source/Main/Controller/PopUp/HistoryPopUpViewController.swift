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
        $0.font = UIFont.NotoSans(.regular, size: 14)
        $0.textAlignment = .center
        $0.textColor = .anzaBlue
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let arrivalLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.text = "도착역"
        $0.font = UIFont.NotoSans(.regular, size: 14)
        $0.textAlignment = .center
        $0.textColor = .anzaBlue
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let closeBtn = UIButton().then {
        $0.backgroundColor = .white
        $0.setImage(UIImage(named: "ic_xmark"), for: .normal)
        $0.layer.cornerRadius = 28
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        $0.layer.shadowOpacity = 1.0
        $0.layer.shadowOffset = .zero
        $0.layer.shadowRadius = 12
        $0.layer.masksToBounds = false
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let completeBtn = UIButton().then {
        $0.backgroundColor = .anzaGray2
        $0.setTitle("완료", for: .normal)
        $0.titleLabel?.font = .NotoSans(.semiBold, size: 14)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 8
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    // 현재 선택된 셀 indexpath.row 값
    private var selectedPos = -1;
    // 최근 경로 데이터 모델
    private var model = [History]()
    private var collectionView: UICollectionView! = nil
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        fetchData()
        configureContainerView()
        configureCloseBtn()
        configureTitleLabel()
        configureTableLabel()
        configureCompleteBtn()
        configureCollectionView()
    }
}

// MARK: - Function
extension HistoryPopUpViewController {
    func tempData() {
        UserDefaults.standard.removeObject(forKey: "history")
        let a: History = History(depature: "공릉", arrival: "삼산체육관")
        let b: History = History(depature: "굴포천", arrival: "부평구청")
        let c: History = History(depature: "건대입구", arrival: "석남")
        let d: History = History(depature: "상봉", arrival: "먹골")
        let data: [History] = [a, b, c, d]
        UserDefaults.standard.set(try? PropertyListEncoder().encode(data), forKey: "history")
    }
    func fetchData() {
        if let data = UserDefaults.standard.value(forKey: "history") as? Data,
           let obj = try? PropertyListDecoder().decode([History].self, from: data)  {
            self.model = obj
        }
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
    // 닫기 버튼
    func configureCloseBtn() {
        view.addSubview(closeBtn)
        closeBtn.snp.makeConstraints { make in
            make.width.height.equalTo(56)
            make.bottom.equalToSuperview().offset(-24)
            make.trailing.equalToSuperview().offset(-24)
        }
        closeBtn.addTarget(self, action: #selector(didTapDismissBtn), for: .touchUpInside)
    }
    // 최근 갔던 경로 레이블 설정
    func configureTitleLabel() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.minimumLineHeight = 25
        let attrString = NSAttributedString(string:"최근 갔던 경로",
                                            attributes: [.font: UIFont.NotoSans(.semiBold, size: 18) as Any,
                                                         .paragraphStyle: paragraphStyle,
                                                         .foregroundColor: UIColor.anzaBlack as Any])
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
            make.leading.equalTo(containerView.snp.leading).offset(50)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        containerView.addSubview(arrivalLabel)
        arrivalLabel.snp.makeConstraints { make in
            make.trailing.equalTo(containerView.snp.trailing).offset(-50)
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
            make.top.equalTo(depatureLabel.snp.bottom).offset(9.5)
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
        return model.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryPopUpCollectionViewCell.identifier,
                                                            for: indexPath) as? HistoryPopUpCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        if selectedPos == indexPath.row {
            cell.backgroundColor = .anzaLightBlue2
            cell.configure(with: model[indexPath.row], color: .anzaBlue)
        } else {
            cell.backgroundColor = .white
            cell.configure(with: model[indexPath.row], color: .anzaBlack)
        }
        cell.setConstraints(departure: depatureLabel.snp.centerX, arrival: arrivalLabel.snp.centerX)
        cell.layer.addBorder([.top], color: .anzaLightGray!, width: 1)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        selectedPos = indexPath.row
        completeBtn.backgroundColor = .anzaBlue
        collectionView.reloadData()
    }
}
