//
//  SeminarDetailViewController.swift
//  MashUp-iOS
//
//  Created by 이문정 on 2022/07/02.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxDataSources
import RxSwift
import SnapKit
import UIKit
import MashUp_Core

final class SeminarDetailViewController: BaseViewController, ReactorKit.View {
    typealias Reactor = SeminarScheduleReactor
    typealias Section = SeminarDetailSection
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Section.Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Section.Item>
    
    var disposeBag = DisposeBag()
    var firstDummy = SeminarDetailSection.init(type: .first, items: [SeminarDetailCellModel.init(title: "안드j로이드팀 세미나", platform: "안드q로이드 팀", time: "93~14"),SeminarDetailCellModel.init(title: "안드로이드팀 세미나", platform: "안드로l이드 팀", time: "13~16"),SeminarDetailCellModel.init(title: "안드로qw이드팀 세미나", platform: "안드로이드 팀", time: "13~74")])
    
    var secondDummy = SeminarDetailSection.init(type: .second,
                                                items: [SeminarDetailCellModel.init(title: "안드로5이드 세미나",
                                                                                    platform: "안h로이드 팀",
                                                                                    time: "12~15"),
                                                        SeminarDetailCellModel.init(title: "안드로m이드 세미나",
                                                                                    platform: "안s로이드 팀",
                                                                                    time: "13~35"),
                                                        SeminarDetailCellModel.init(title: "안드z로이드 세미나",
                                                                                    platform: "안로이드 팀",
                                                                                    time: "14~75")])
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.applySections([firstDummy,secondDummy])
        self.collectionView.bounces = true
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
        //        reactor.state.map { $0.sections }
        //        .distinctUntilChanged()
        //        .withUnretained(self)
        //        .onMain()
        //        .subscribe(onNext: { $0.applySections($1) })
        //        .disposed(by: self.disposeBag)
    }
    
    private func consume(_ reactor: Reactor) {
        //        reactor.pulse(\.$step).compactMap { $0 }
        //        .withUnretained(self)
        //        .onMain()
        //        .subscribe(onNext: { $0.move(to: $1) })
        //        .disposed(by: self.disposeBag)
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
extension SeminarDetailViewController {
    
    private func setupUI() {
        self.setupAttribute()
        self.setupLayout()
    }
    
    private func setupAttribute() {
        self.view.backgroundColor = .white
        self.collectionView.do {
            $0.backgroundColor = .clear
            $0.registerCell(SeminarDetailCell.self)
            $0.registerSupplementaryView(SeminarDetailHeaderView.self)
            $0.registerSupplementaryFooterView(SeminarDetailFooterView.self)
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
            return .verticalCardLayoutSection
        })
    }
}
// MARK: - Data source
extension SeminarDetailViewController {
    
    private func dataSourceOf(_ collectionView: UICollectionView) -> DataSource {
        return DataSource(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                let cell = collectionView.dequeueCell(SeminarDetailCell.self, for: indexPath)
                cell?.configure(with: item, index: indexPath.item)
                return cell
            },
            supplementaryViewProvider: { collectionView, elementKind, indexPath in
                print("🔥",elementKind)
                if elementKind == UICollectionView.elementKindSectionFooter {
                    let footer = collectionView.dequeueSupplementaryFooterView(SeminarDetailFooterView.self, for: indexPath)
                    return footer
                } else if elementKind == UICollectionView.elementKindSectionHeader {
                    guard let sectionType = SeminarDetailSectionType(rawValue: indexPath.section) else { return nil }
                    let header = collectionView.dequeueSupplementaryView(SeminarDetailHeaderView.self, for: indexPath)
                    header?.configure(sectionType: sectionType)
                    return header
                }
                return nil
            }
        )
    }
}
// MARK: - Navigation
extension SeminarDetailViewController {
    
}
// MARK: - Factory
extension SeminarDetailViewController {
    
}

