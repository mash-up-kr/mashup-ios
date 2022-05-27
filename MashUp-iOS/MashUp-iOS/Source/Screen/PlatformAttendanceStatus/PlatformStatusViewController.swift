//
//  PlatformStatusViewController.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/05/27.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import ReactorKit

final class PlatformStatusViewController: BaseViewController, ReactorKit.View {
    private lazy var platformCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 16
        let width: CGFloat = UIScreen.main.bounds.width - 50
        let height: CGFloat = 104
        flowLayout.itemSize = CGSize(width: width, height: height)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        return collectionView
    }()
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func bind(reactor: PlatformAttendanceStatusReactor) {
        let mockObservable = Observable<[PlatformAttendance]>.just([.init(platform: .iOS, numberOfAttend: 1, numberOfLateness: 10, numberOfAbsence: 2),
                                               .init(platform: .android, numberOfAttend: 10, numberOfLateness: 10, numberOfAbsence: 2),
                                               .init(platform: .design, numberOfAttend: 10, numberOfLateness: 10, numberOfAbsence: 20),
                                              ])
//        reactor.state.map { $0.platformsAttendance }
        mockObservable
            .distinctUntilChanged()
            .bind(to: platformCollectionView.rx.items(cellIdentifier: PlatformAttendanceCell.reuseIdentifier,
                                                      cellType: PlatformAttendanceCell.self)) { item, model, cell in
                cell.configure(model: model)
            }
            .disposed(by: disposeBag)
    }
    
    private func setupUI() {
        setupLayout()
        setupAttribute()
    }
    
    private func setupLayout() {
        view.addSubview(platformCollectionView)
        platformCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupAttribute() {
        platformCollectionView.registerCell(PlatformAttendanceCell.self)
    }
}
