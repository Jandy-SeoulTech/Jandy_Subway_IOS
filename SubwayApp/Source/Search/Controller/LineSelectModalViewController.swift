//
//  LineSelectModalViewController.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/06/05.
//

import UIKit
import SnapKit
import Then

class LineSelectModalViewController: UIViewController {
    // Constatns
    private let dimmedAlpha: CGFloat = 0.3
    private let defaultHeight: CGFloat = UIScreen.main.bounds.size.height * 0.8
    private let dismissibleHeight: CGFloat = 200
    private let maximumContainerHeight: CGFloat = UIScreen.main.bounds.size.height * 0.8
    private var currentContainerHeight: CGFloat = UIScreen.main.bounds.size.height * 0.8
    
    // Dynamic container constraint
    weak var containerViewHeightConstraint: NSLayoutConstraint?
    weak var containerViewBottomConstraint: NSLayoutConstraint?
    
    private var subwayLinesCollectionView: UICollectionView! = nil
    private var dimmedView = UIView().then {
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private var containerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let gradientHeader = UIView().then {
        $0.backgroundColor = .white
        $0.addGradient()
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let closeButton = UIButton().then {
        $0.setImage(UIImage(named: "xbtn-large"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDimmedView()
        configureContainerView()
        configureCollectionView()
        configureHeaderView()
        configureCloseBtn()
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
extension LineSelectModalViewController {
    func configureDimmedView() {
        view.addSubview(dimmedView)
        dimmedView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    func configureContainerView() {
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
    }
    func configureHeaderView() {
        containerView.addSubview(gradientHeader)
        gradientHeader.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(containerView)
            make.height.equalTo(55)
        }
    }
    func configureCloseBtn() {
        gradientHeader.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(gradientHeader.snp.top).offset(24)
            make.trailing.equalTo(gradientHeader.snp.trailing).offset(-24)
            make.height.width.equalTo(24)
        }
        closeButton.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
    }
    // configure collection view
    func configureLayout() -> UICollectionViewCompositionalLayout{
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
    func configureCollectionView() {
        subwayLinesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureLayout())
        containerView.addSubview(subwayLinesCollectionView)
        subwayLinesCollectionView.backgroundColor = .white
        subwayLinesCollectionView.dataSource = self
        subwayLinesCollectionView.delegate = self
        subwayLinesCollectionView.showsVerticalScrollIndicator = false
        subwayLinesCollectionView.snp.makeConstraints { make in
            make.leading.equalTo(containerView.snp.leading)
            make.trailing.equalTo(containerView.snp.trailing)
            make.top.equalTo(containerView.snp.top).offset(41)
            make.bottom.equalTo(containerView.snp.bottom)
        }
        subwayLinesCollectionView.register(SubwayLineCollectionViewCell.self,
                                           forCellWithReuseIdentifier: SubwayLineCollectionViewCell.identifier)
    }
}

// MARK: Collection view Data source, Delegate
extension LineSelectModalViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SubwayLineCollectionViewCell.identifier,
            for: indexPath) as? SubwayLineCollectionViewCell else {
                return UICollectionViewCell()
            }
        let name: String = LineInformation.shared.name[indexPath.row]
        cell.configure(name: name)
        cell.layer.addBorder([.bottom], color: .anzaGray4!, width: 1)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LineInformation.shared.name.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let dic: [String: String] = ["name": LineInformation.shared.name[indexPath.row]]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "subway_line"), object: dic)
        animateDismissView()
    }
}

// MARK: - Animation
extension LineSelectModalViewController {
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
        UIView.animate(withDuration: 0.4) { [weak self] in
            guard let dimmedAlpha = self?.dimmedAlpha else { return }
            self?.dimmedView.alpha = dimmedAlpha
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
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let defaultHeight = self?.defaultHeight else { return }
            self?.containerViewBottomConstraint?.constant = defaultHeight
            // call this to trigger refresh constraint
            self?.view.layoutIfNeeded()
        }
    }
}

// MARK: - Gesture handler
extension LineSelectModalViewController {
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
