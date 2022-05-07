//
//  HalfModalPresentationController.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/05/04.
//

import UIKit
import SnapKit
import Then

class SubwayLinesModalViewController: UIViewController {
    // MARK: Constatns
    private let dimmedAlpha: CGFloat = 0.3
    private let defaultHeight: CGFloat = UIScreen.main.bounds.size.height * 0.8
    private let dismissibleHeight: CGFloat = 200
    private let maximumContainerHeight: CGFloat = UIScreen.main.bounds.size.height * 0.8
    private var currentContainerHeight: CGFloat = UIScreen.main.bounds.size.height * 0.8
    
    // Dynamic container constraint
    weak var containerViewHeightConstraint: NSLayoutConstraint?
    weak var containerViewBottomConstraint: NSLayoutConstraint?
    
    let model: SubwayLines = SubwayLines()
    
    private var subwayLinesCollectionView: UICollectionView! = nil
    private var titleLabel = UILabel().then {
        $0.text = "호선"
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.numberOfLines = 0
        $0.textColor = UIColor(hex: 0x212121)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.sizeToFit()
    }
    private var dimmedView = UIView().then {
        $0.backgroundColor = UIColor(hex: 0x000000)
        $0.alpha = 0.3
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private var containerView = UIView().then {
        $0.backgroundColor = UIColor(hex: 0xFFFFFF)
        $0.layer.cornerRadius = 16
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private var closeButton = UIButton().then {
        $0.setImage(UIImage(named: "xbtn-large"), for: .normal)
        $0.tintColor = UIColor(hex: 0x212121)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setConstraints()
        setupTapGesture()
        setupPanGesture()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateShowDimmedView()
        animatePresentContainer()
    }
}

// MARK: - Configuration
extension SubwayLinesModalViewController {
    func setConstraints() {
        view.addSubview(dimmedView)
        // Dimmed view constraint
        dimmedView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        view.addSubview(containerView)
        // Container view constraint
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        // Set dynamic constraints
        // First, set container to default height
        // after panning, the height can expand
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        
        // By setting the height to default height, the container will be hide below the bottom anchor view
        // Later, will bring it up by set it to 0
        // set the constant to default height to bring it down again
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                                              constant: defaultHeight)
        // Activate constraints
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
        
        // Title constraint
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(24)
        }
        // Close button constraint
        containerView.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.width.equalTo(25)
        }
        closeButton.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
        configureCollectionView()
    }
}

// MARK: - Collection view
extension SubwayLinesModalViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    // MARK: configure collection view
    func configureLayout() -> UICollectionViewCompositionalLayout{
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
    func configureCollectionView() {
        subwayLinesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureLayout())
        containerView.addSubview(subwayLinesCollectionView)
        subwayLinesCollectionView.backgroundColor = UIColor(hex: 0xffffff)
        subwayLinesCollectionView.dataSource = self
        subwayLinesCollectionView.delegate = self
        containerView.translatesAutoresizingMaskIntoConstraints = false
        subwayLinesCollectionView.snp.makeConstraints { make in
            make.leading.equalTo(24)
            make.trailing.equalTo(containerView.snp.trailing)
            make.top.equalTo(titleLabel.snp.bottom).offset(11)
            make.height.equalTo(containerView.snp.height)
        }
        subwayLinesCollectionView.register(SubwayLinesCollectionViewCell.self,
                                forCellWithReuseIdentifier: SubwayLinesCollectionViewCell.identifier)
    }
    // MARK: collection view data source, delegate
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SubwayLinesCollectionViewCell.identifier,
            for: indexPath) as? SubwayLinesCollectionViewCell else {
                return UICollectionViewCell()
            }
        let number: String = model.line[indexPath.row]
        let name: String = model.name[indexPath.row]
        let color: Int = model.color[indexPath.row]
        cell.configure(number: number, name: name, color: color)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.line.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let dic: [String: String] = ["name": model.name[indexPath.row],"color": "\(model.color[indexPath.row])"]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "subway_line"), object: dic)
        animateDismissView()
    }
}

// MARK: - Animation
extension SubwayLinesModalViewController {
    func animatePresentContainer() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.containerViewBottomConstraint?.constant = 0
            self?.view.layoutIfNeeded()
        }
    }
    func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) { [weak self] in
            // Update container height
            self?.containerViewHeightConstraint?.constant = height
            // Call this to trigger refresh constraint
            self?.view.layoutIfNeeded()
        }
        // Save current height
        currentContainerHeight = height
    }
    func animateShowDimmedView() {
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = self.dimmedAlpha
        }
    }
    func animateDismissView() {
        // hide blur view
        dimmedView.alpha = dimmedAlpha
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.dimmedView.alpha = 0
        } completion: { _ in
            // once done, dismiss without animation
            self.dismiss(animated: false)
        }
        // hide main view by updating bottom constraint in animation block
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            // call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - Gesture handler
extension SubwayLinesModalViewController {
    // Tap gesture
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissModal))
        dimmedView.addGestureRecognizer(tapGesture)
    }
    @objc func dismissModal() {
        animateDismissView()
    }
    // Pan gesture
    func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self,
                                                action: #selector(self.handlePanGesture(gesture:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        
        // New height is based on value of dragging plus current container height
        let newHeight = currentContainerHeight - translation.y
        
        // Handle based on gesture state
        switch gesture.state {
        case .changed:
            // This state will occur when user is dragging
            if newHeight < maximumContainerHeight {
                // Keep updating the height constraint
                containerViewHeightConstraint?.constant = newHeight
                // refresh layout
                view.layoutIfNeeded()
            }
        case .ended:
            // This happens when user stop drag,
            // so we will get the last height of container
            if newHeight < dismissibleHeight {
                self.animateDismissView()
            }
            else if newHeight < maximumContainerHeight {
                animateContainerHeight(defaultHeight)
            }
        default:
            break
        }
    }
}
