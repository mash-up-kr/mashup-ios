//
//  SeminarScheduleViewController.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/25.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxDataSources
import RxSwift
import SnapKit
import UIKit

final class SeminarScheduleViewController: BaseViewController, ReactorKit.View {
    typealias Reactor = SeminarScheduleReactor
    typealias Section = SeminarSection
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Section.Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Section.Item>
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    func bind(reactor: Reactor) {
        self.dispatch(to: reactor)
        self.render(reactor)
        self.consume(reactor)
    }
    
    private func dispatch(to reactor: Reactor) {
    }
    
    private func render(_ reactor: Reactor) {
        
    }
    
    private func consume(_ reactor: Reactor) {
        reactor.pulse(\.$step).compactMap { $0 }
        .subscribe(onNext: { [weak self] step in
            switch step {
            case .seminarDetail(let seminarID):
                self?.pushSeminarDetailViewController(seminarID: seminarID)
            }
        })
        .disposed(by: self.disposeBag)
    }
    
    private lazy var dataSource = self.dataSourceOf(self.collectionView)
    
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
}
// MARK: - Setup
extension SeminarScheduleViewController {
    
    private func setupUI() {
        self.setupAttribute()
        self.setupLayout()
    }
    
    private func setupAttribute() {
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .systemBlue
        self.collectionView.do {
            $0.registerCell(SeminarCardCell.self)
            $0.backgroundColor = .systemTeal
        }
    }
    
    private func setupLayout() {
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(56)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}
// MARK: - Data source
extension SeminarScheduleViewController {
    
    private func dataSourceOf(_ collectionView: UICollectionView) -> DataSource {
        return DataSource(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                switch item {
                case .seminar(let model):
                    let cell = collectionView.dequeueCell(SeminarCardCell.self, for: indexPath)
                    cell?.configure(with: model)
                    return cell
                }
            },
            supplementaryViewProvider: { collectionView, elementKind, indexPath in
                return SeminarHeaderView()
            }
        )
    }
    
}
// MARK: - Navigation
extension SeminarScheduleViewController {
    
    private func pushSeminarDetailViewController(seminarID: String) {
        let seminarDetailViewController = self.createSeminarDetailViewController(seminarID: seminarID)
        self.navigationController?.pushViewController(seminarDetailViewController, animated: true)
    }
    
}
// MARK: - Factory
extension SeminarScheduleViewController {
    
    private func createSeminarDetailViewController(seminarID: String) -> SeminarDetailViewController {
        let seminarDetailViewController = SeminarDetailViewController()
        return seminarDetailViewController
    }
    
}
