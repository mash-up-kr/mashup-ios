//
//  SeminarDetailViewController.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/26.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import MashUp_Core
import ReactorKit
import RxCocoa

final class PlatformAttendanceDetailViewController: BaseViewController, ReactorKit.View {
    private lazy var memeberCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 40
        flowLayout.itemSize = CGSize(width: width, height: 82)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        return collectionView
    }()
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func bind(reactor: PlatformAttendanceDetailReactor) {
        reactor.state.map { $0.members }
            .bind(to: memeberCollectionView.rx.items(cellIdentifier: AttendanceDetailCell.reuseIdentifier,
                                                     cellType: AttendanceDetailCell.self)) { item, model, cell in
                cell.configure(model: model)
            }
            .disposed(by: disposeBag)
     
        reactor.action.onNext(.didSetup)
    }
}

// MARK: - Setup
extension PlatformAttendanceDetailViewController {
    
    private func setupUI() {
        self.view.backgroundColor = .systemOrange
        setupLayout()
        setupAttribute()
    }
    
    private func setupLayout() {
        view.addSubview(memeberCollectionView)
        memeberCollectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setupAttribute() {
        memeberCollectionView.do {
            $0.registerCell(AttendanceDetailCell.self)
            $0.backgroundColor = .clear
        }
    }
}
