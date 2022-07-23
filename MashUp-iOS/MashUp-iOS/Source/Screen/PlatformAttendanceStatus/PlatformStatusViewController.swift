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
import MashUp_UIKit

final class PlatformStatusViewController: BaseViewController, ReactorKit.View {
    private let navigationBar: MUNavigationBar = MUNavigationBar(frame: .zero)
    private lazy var platformCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 12
        let screenWidth = UIApplication.shared.delegate?.window??.windowScene?.screen.bounds.width ?? 0
        let spacing: CGFloat = 12
        let width: CGFloat = (screenWidth - spacing - 40) / 2
        let height: CGFloat = width * 200 / 156
        flowLayout.itemSize = CGSize(width: width, height: height)
        flowLayout.headerReferenceSize =  CGSize(width: width, height: 36)
        flowLayout.minimumInteritemSpacing = spacing
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        return collectionView
    }()
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func bind(reactor: PlatformAttendanceStatusReactor) {
        reactor.action.onNext(.didSetup)
        
        navigationBar.leftButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupUI() {
        setupLayout()
        setupAttribute()
    }
    
    private func setupLayout() {
        view.addSubview(navigationBar)
        view.addSubview(platformCollectionView)
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(52)
        }
        
        platformCollectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setupAttribute() {
        view.backgroundColor = .gray50
        platformCollectionView.do {
            $0.dataSource = self
            $0.registerCell(PlatformAttendanceCell.self)
            $0.registerSupplementaryView(PlatformAttendanceHeaderView.self)
            $0.backgroundColor = .clear
            $0.contentInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        }
        navigationBar.do {
            $0.leftBarItem = .back
            $0.title = "플랫폼별 출석현황"
        }
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
