//
//  PlatformStatusViewController.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/05/27.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import MashUp_Core
import ReactorKit
import MashUp_PlatformTeam

final class PlatformStatusViewController: BaseViewController, ReactorKit.View {
    private lazy var platformCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 12
        let width: CGFloat = UIScreen.main.bounds.width - 40
        flowLayout.estimatedItemSize = CGSize(width: width, height: 138)
        flowLayout.headerReferenceSize =  CGSize(width: width, height: 48)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        return collectionView
    }()
    var disposeBag: DisposeBag = DisposeBag()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .lightGray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func bind(reactor: PlatformAttendanceStatusReactor) {
        reactor.action.onNext(.didSetup)
    }
    
    private func setupUI() {
        setupLayout()
        setupAttribute()
    }
    
    private func setupLayout() {
        view.addSubview(platformCollectionView)
        platformCollectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setupAttribute() {
        platformCollectionView.dataSource = self
        platformCollectionView.registerCell(PlatformAttendanceCell.self)
        platformCollectionView.registerSupplementaryView(PlatformAttendanceHeaderView.self)
        platformCollectionView.backgroundColor = .clear
    }
}

extension PlatformStatusViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reactor?.currentState.platformsAttendance.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueCell(PlatformAttendanceCell.self, for: indexPath),
              let reactor = reactor,
              let model = reactor.currentState.platformsAttendance[safe: indexPath.item] else {
            return .init(frame: .zero)
        }
        
        cell.configure(model: model, isAttending: reactor.currentState.isAttending)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueSupplementaryView(PlatformAttendanceHeaderView.self, for: indexPath) else {
            return .init()
        }
        // TODO: - 네트워크구현후 변경
        headerView.setTitle("출 석 체 크 !")
        headerView.setImage(UIImage(systemName: "heart"))
        return headerView
    }
}
