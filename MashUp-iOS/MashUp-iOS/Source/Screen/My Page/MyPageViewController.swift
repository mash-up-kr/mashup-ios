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
        
        self.headerView.rx.didTap5TimesMascotImage
            .map { _ in .didTap5TimesMascot }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    private func render(_ reactor: Reactor) {
        reactor.state.map { !$0.summaryBarHasVisable }
            .distinctUntilChanged()
            .onMain()
            .subscribe(onNext: { [weak self] in self?.updateSummaryBarWithAnimation(isHidden: $0) })
            .disposed(by: self.disposeBag)
    }
    
    private func consume(_ reactor: Reactor) {
        
    }
    
    private let headerView = MyPageHeaderView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 380))
    private let summaryBar = MyPageSummaryBar()
    private let historyTableView = UITableView()
    
    private lazy var animator = UIViewPropertyAnimator(duration: 0.3, curve: .linear)
    
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
            $0.dataSource = self
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
    }
    
    private func updateSummaryBarWithAnimation(isHidden: Bool) {
        self.animator.stopAnimation(true)
        self.animator.addAnimations {
            self.summaryBar.alpha = isHidden ? 0 : 1
        }
        self.animator.startAnimation()
    }
    
    
}

extension MyPageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = AttendanceScoreHistoryCellModel(
            historyTitle: "전체 세미나 지각",
            description: "2022.03.05 | 2차 전체 세미나",
            scoreChangeStyle: [.addition("+1점"), .deduction("-1점"), .custom("💖 🔫")].randomElement()!,
            appliedTotalScoreText: "4점"
        )
        return AttendanceScoreHistoryCell().then {
            $0.configure(with: model)
        }
    }
    
    
}
