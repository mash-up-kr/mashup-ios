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
import MashUp_Core

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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupTabBarTheme(.light)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func bind(reactor: Reactor) {
        self.dispatch(to: reactor)
        self.render(reactor)
        self.consume(reactor)
    }
    
    private func dispatch(to reactor: Reactor) {
        self.rx.viewDidLayoutSubviews.take(1).map { .didSetup }
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
        
        self.collectionView.rx.itemSelected.map { .didSelectSeminar(at: $0.item) }
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
    }
    
    private func render(_ reactor: Reactor) {
        reactor.state.map { $0.sections }
        .distinctUntilChanged()
        .withUnretained(self)
        .onMain()
        .subscribe(onNext: { $0.applySections($1) })
        .disposed(by: self.disposeBag)
    }
    
    private func consume(_ reactor: Reactor) {
        reactor.pulse(\.$step).compactMap { $0 }
        .withUnretained(self)
        .onMain()
        .subscribe(onNext: { $0.move(to: $1) })
        .disposed(by: self.disposeBag)
    }
    
    private func applySections(_ sections: [Section]) {
        var snapshot = Snapshot()
        snapshot.appendSections(sections)
        sections.forEach { snapshot.appendItems($0.items, toSection: $0) }
        self.dataSource.apply(snapshot, animatingDifferences: true)
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
        self.view.backgroundColor = .gray50
        self.collectionView.do {
            $0.backgroundColor = .clear
            $0.registerCell(SeminarCardCell.self)
            $0.registerSupplementaryView(SeminarHeaderView.self)
            $0.collectionViewLayout = self.collectionViewLayout()
        }
    }
    
    private func setupLayout() {
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout(sectionProvider: { index, _ in
            guard let sectionType = SeminarSectionType(rawValue: index) else { return nil }
            switch sectionType {
//            case .upcoming: return .horizontalCardLayoutSection
            case .total: return .horizontalCardLayoutSection
            }
        })
    }
    
}
// MARK: - Data source
extension SeminarScheduleViewController {
    
    private func dataSourceOf(_ collectionView: UICollectionView) -> DataSource {
        return DataSource(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                switch item {
                case .total(let model):
                    let cell = collectionView.dequeueCell(SeminarCardCell.self, for: indexPath)
                    cell?.configure(with: model)
                    return cell
                }
            },
            supplementaryViewProvider: { collectionView, elementKind, indexPath in
                guard let sectionType = SeminarSectionType(rawValue: indexPath.section) else { return nil }
                let header = collectionView.dequeueSupplementaryView(SeminarHeaderView.self, for: indexPath)
                header?.configure(sectionType: sectionType)
                return header
            }
        )
    }
    
}
// MARK: - Navigation
extension SeminarScheduleViewController {
    
    private func move(to step: SeminarSchduleStep) {
        switch step {
        case .seminarDetail(let seminarID):
            self.pushSeminarDetailViewController(seminarID: seminarID)
        }
    }
    
    private func pushSeminarDetailViewController(seminarID: String) {
        let seminarDetailViewController = self.createSeminarDetailViewController(seminarID: seminarID)
        self.navigationController?.pushViewController(seminarDetailViewController, animated: true)
    }
    
}
// MARK: - Factory
extension SeminarScheduleViewController {
    
    private func createSeminarDetailViewController(seminarID: String) -> PlatformAttendanceDetailViewController {
        let seminarDetailViewController = PlatformAttendanceDetailViewController()
        return seminarDetailViewController
    }
    
}
