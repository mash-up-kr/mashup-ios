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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
        .subscribe(onNext: self.applySections)
        .disposed(by: self.disposeBag)
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
        self.view.backgroundColor = .systemBlue
        self.collectionView.do {
            $0.backgroundColor = .systemTeal
            $0.registerCell(SeminarCardCell.self)
            $0.registerSupplementaryView(SeminarHeaderView.self)
            $0.collectionViewLayout = self.collectionViewLayout()
        }
    }
    
    private func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] index, _ in
            guard let self = self else { return nil }
            guard let sectionType = SeminarSectionMeta(rawValue: index) else { return nil }
            
            switch sectionType {
            case .upcoming: return self.createHorizontalLayout()
            case .total: return self.createVerticalLayout()
            }
        })
    }
    
    private func createHorizontalLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(312.0/375.0),
            heightDimension: .absolute(162.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(((312.0 * 3) + (13.0 * 2) + (24.0 * 2)) / 375.0),
            heightDimension: .absolute(162.0)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        group.interItemSpacing = .fixed(13)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 24, bottom: 10, trailing: 24)
        section.orthogonalScrollingBehavior = .paging
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(52.0)
        )
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    private func createVerticalLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
            heightDimension: NSCollectionLayoutDimension.estimated(162)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 24, bottom: 10, trailing: 24)
        section.interGroupSpacing = 14
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(52)
        )
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [sectionHeader]
        return section
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
                case .upcoming(let model), .total(let model):
                    let cell = collectionView.dequeueCell(SeminarCardCell.self, for: indexPath)
                    cell?.configure(with: model)
                    return cell
                }
            },
            supplementaryViewProvider: { collectionView, elementKind, indexPath in
                guard let header = collectionView.dequeueSupplementaryView(SeminarHeaderView.self, for: indexPath),
                      let meta = SeminarSectionMeta(rawValue: indexPath.section)
                else { return SeminarHeaderView() }
                
                header.configure(sectionMeta: meta)
                return header
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
