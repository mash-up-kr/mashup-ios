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
import MashUp_UIKit

final class PlatformAttendanceDetailViewController: BaseViewController, ReactorKit.View {
    private let navigationBar: MUNavigationBar = MUNavigationBar(frame: .zero)
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
            .distinctUntilChanged()
            .bind(to: memeberCollectionView.rx.items(cellIdentifier: AttendanceDetailCell.reuseIdentifier,
                                                     cellType: AttendanceDetailCell.self)) { item, model, cell in
                cell.configure(model: model)
            }
            .disposed(by: disposeBag)
     
        reactor.state.map { $0.navigationTitle }
            .distinctUntilChanged()
            .bind(to: navigationBar.rx.title)
            .disposed(by: disposeBag)
        
        reactor.action.onNext(.didSetup)
        
        navigationBar.leftButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Setup
extension PlatformAttendanceDetailViewController {
    
    private func setupUI() {
        view.backgroundColor = .white
        setupLayout()
        setupAttribute()
    }
    
    private func setupLayout() {
        view.addSubview(navigationBar)
        view.addSubview(memeberCollectionView)
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(52)
        }
        memeberCollectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setupAttribute() {
        memeberCollectionView.do {
            $0.registerCell(AttendanceDetailCell.self)
            $0.backgroundColor = .clear
        }
        navigationBar.do {
            $0.leftBarItem = .back
        }
    }
}
