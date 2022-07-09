//
//  MyPageViewController.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/25.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import MashUp_Core
import MashUp_UIKit
import ReactorKit

final class MyPageViewController: BaseViewController, View {
    
    typealias Reactor = MyPageReactor
    typealias Section = MyPageSection
    typealias DataSource = UITableViewDiffableDataSource<Section, Section.Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Section.Item>
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGreen
        
        self.setupAttribute()
        self.setupLayout()
        
        #warning("제거해야합니다. - booung")
        self.headerView.configure(with: .init(userName: "김매시업",
                                              platformTeamText: "iOS",
                                              totalScoreText: "3.5점"))
        self.summaryBar.configure(with: .init(userName: "김매시업",
                                              totalScoreText: "3.5점"))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupTabBarTheme(.light)
    }
    
    func bind(reactor: Reactor) {
        self.dispatch(to: reactor)
        self.render(reactor)
        self.consume(reactor)
    }
    
    private func dispatch(to reactor: Reactor) {
        let yOffset =  self.historyTableView.rx.didScroll
            .withUnretained(self.historyTableView)
            .compactMap { [weak self] _ in self?.historyTableView.contentOffset.y }
        
        yOffset.map { $0 > 390 }
            .distinctUntilChanged()
            .filter { $0 }
            .map { _ in .didDisappearHeaderView }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        yOffset.map { $0 < 380 }
            .distinctUntilChanged()
            .filter { $0 }
            .map { _ in .didAppearHeaderView }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.headerView.rx.didTapSettingButton
            .map { .didTapSettingButton }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.headerView.rx.didTapQuestionMarkButton
            .map { .didTapQuestMarkButton }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)

        self.summaryBar.rx.didTapQuestionMarkButton
            .map { .didTapQuestMarkButton }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.headerView.rx.didTap5TimesMascotImage
            .map { _ in .didTap5TimesMascot }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.rx.viewDidLoad
            .take(1)
            .map { .didSetup }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.historyTableView.rx
            .setDelegate(self)
            .disposed(by: self.disposeBag)
    }
    
    private func render(_ reactor: Reactor) {
        reactor.state.map { !$0.summaryBarHasVisable }
            .distinctUntilChanged()
            .onMain()
            .subscribe(onNext: { [weak self] in
                self?.updateSummaryBarWithAnimation(isHidden: $0)
            })
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.sections }
            .distinctUntilChanged()
            .onMain()
            .subscribe(onNext: { [weak self] sections in
                self?.sections = sections
                self?.apply(sections: sections)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func consume(_ reactor: Reactor) {
        reactor.pulse(\.$step)
            .compactMap { $0 }
            .onMain()
            .subscribe(onNext: { [weak self] step in self?.move(to: step) })
            .disposed(by: self.disposeBag)
    }
    
    private let headerView = MyPageHeaderView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 380))
    private let summaryBar = MyPageSummaryBar()
    private let historyTableView = UITableView()
    
    private lazy var dataSource = self.dataSource(of: self.historyTableView)
    private let animator = UIViewPropertyAnimator(duration: 0.3, curve: .linear)
    private var sections: [Section] = []
    
}
extension MyPageViewController {
    
    private func dataSource(of tableView: UITableView) -> DataSource {
        let dataSource = DataSource(
            tableView: tableView,
            cellProvider: { (tableView, indexPath, item) in
                switch item {
                case .history(let cellModel):
                    let cell = tableView.dequeueCell(AttendanceScoreHistoryCell.self, for: indexPath)
                    cell?.configure(with: cellModel)
                    return cell
                }
            })
        return dataSource
    }
    
}
extension MyPageViewController {
    
    private func setupAttribute() {
        self.view.backgroundColor = .gray900
        self.summaryBar.do {
            $0.alpha = 0
        }
        self.historyTableView.do {
            $0.tableHeaderView = self.headerView
            $0.rowHeight = UITableView.automaticDimension
            $0.separatorStyle = .none
            $0.backgroundColor = .gray900
            $0.registerHeaderFooter(AttendanceHistoryTitleHeaderView.self)
            $0.registerHeaderFooter(AttendanceHistorySectionHeaderView.self)
            $0.registerHeaderFooter(EmptyAttendanceHistoryView.self)
            $0.registerCell(AttendanceScoreHistoryCell.self)
        }
    }
    
    private func setupLayout() {
        self.view.addSubview(self.historyTableView)
        self.historyTableView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        self.view.addSubview(self.summaryBar)
        self.summaryBar.snp.makeConstraints {
            $0.top.leading.width.equalToSuperview()
            $0.height.equalTo(126)
        }
        let footerView = UIView().then {
            $0.backgroundColor = .gray50
            $0.bounds.size.height = 200
        }
        self.historyTableView.tableFooterView = footerView
    }
    
    private func updateSummaryBarWithAnimation(isHidden: Bool) {
        self.animator.stopAnimation(true)
        self.animator.addAnimations {
            self.summaryBar.alpha = isHidden ? 0 : 1
        }
        self.animator.startAnimation()
    }
    
}

extension MyPageViewController {
    
    private func move(to step: MyPageStep) {
        switch step {
        case .setting:
            let viewController = self.makeSettingViewController()
            
        case .attendanceScoreRule:
            let viewController = self.makeAttendanceScoreRuleViewController()
            viewController.modalPresentationStyle = .pageSheet
            self.present(viewController, animated: true)
        }
    }
    
    private func makeSettingViewController() -> UIViewController {
        return UIViewController()
    }
    
    private func makeAttendanceScoreRuleViewController() -> UIViewController {
        return AttendanceScoreRuleViewController()
    }
    
}
extension MyPageViewController {
    
    private func apply(sections: [Section]) {
        var snapshot = Snapshot()
        
        snapshot.appendSections(sections)
        sections.forEach { section in
            guard case .historys(_, let items) = section else { return }
            snapshot.appendItems(items, toSection: section)
        }
        self.dataSource.apply(snapshot)
    }
    
}
extension MyPageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let section = self.sections[safe: section] else { return nil }
        
        switch section {
        case .title(let viewModel):
            let header = tableView.dequeueHeaderFooter(AttendanceHistoryTitleHeaderView.self)
            header?.configure(with: viewModel)
            return header
            
        case .historys(let viewModel, _):
            let header = tableView.dequeueHeaderFooter(AttendanceHistorySectionHeaderView.self)
            header?.configure(with: viewModel)
            return header
            
        case .empty:
            let header = tableView.dequeueHeaderFooter(EmptyAttendanceHistoryView.self)
            return header
        }
    }
    
}
