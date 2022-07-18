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
import MashUp_Auth

final class MyPageViewController: BaseViewController, View {
    
    typealias Reactor = MyPageReactor
    typealias Section = MyPageSection
    typealias DataSource = UITableViewDiffableDataSource<Section, Section.Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Section.Item>
    
    #warning("DIContainer 변경 이후 수정되어야함 - booung")
    var userAuthService: (any UserAuthService)?
    var authenticationResponder: (any AuthenticationResponder)?
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupAttribute()
        self.setupLayout()
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
        
        reactor.state.compactMap { $0.summaryBarModel }
            .distinctUntilChanged()
            .onMain()
            .subscribe(onNext: { [weak self] viewModel in
                self?.summaryBar.configure(with: viewModel)
            })
            .disposed(by: self.disposeBag)
        
        reactor.state.compactMap { $0.headerModel }
            .distinctUntilChanged()
            .onMain()
            .subscribe(onNext: { [weak self] viewModel in
                self?.headerView.configure(with: viewModel)
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
                    let cell = tableView.dequeueCell(ClubActivityHistoryCell.self, for: indexPath)
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
            $0.registerHeaderFooter(ClubActivityHistoryTitleHeaderView.self)
            $0.registerHeaderFooter(ClubActivityHistorySectionHeaderView.self)
            $0.registerHeaderFooter(EmptyClubActivityHistoryView.self)
            $0.registerCell(ClubActivityHistoryCell.self)
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
            guard let userAuthService = self.userAuthService else { return }
            guard let authenticationResponder = self.authenticationResponder else { return }
            let viewController = self.makeSettingViewController(
                userAuthService: userAuthService,
                authenticationResponder: authenticationResponder
            )
            self.navigationController?.pushViewController(viewController, animated: true)
            
        case .clubActivityScoreRule:
            let viewController = self.makeClubActivityScoreRuleViewController()
            viewController.modalPresentationStyle = .pageSheet
            self.present(viewController, animated: true)
        }
    }
    
    private func makeSettingViewController(
        userAuthService: any UserAuthService,
        authenticationResponder: any AuthenticationResponder
    ) -> UIViewController {
        let reactor = SettingReactor(userAuthService: userAuthService, authenticationResponder: authenticationResponder)
        return SettingViewController().then {
            $0.reactor = reactor
            $0.hidesBottomBarWhenPushed = true
        }
    }
    
    private func makeClubActivityScoreRuleViewController() -> UIViewController {
        return ClubActivityScoreRuleViewController()
    }
    
}
extension MyPageViewController {
    
    private func apply(sections: [Section]) {
        var snapshot = Snapshot()
        
        snapshot.appendSections(sections)
        sections.forEach { section in
            guard case .histories(_, let items) = section else { return }
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
            let header = tableView.dequeueHeaderFooter(ClubActivityHistoryTitleHeaderView.self)
            header?.configure(with: viewModel)
            return header
            
        case .histories(let viewModel, _):
            let header = tableView.dequeueHeaderFooter(ClubActivityHistorySectionHeaderView.self)
            header?.configure(with: viewModel)
            return header
            
        case .empty:
            let header = tableView.dequeueHeaderFooter(EmptyClubActivityHistoryView.self)
            return header
        }
    }
    
}
