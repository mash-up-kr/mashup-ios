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
        
        yOffset.map { $0 > 210 }
            .distinctUntilChanged()
            .filter { $0 }
            .map { _ in .didDisappearHeaderView }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        yOffset.map { $0 < 200 }
            .distinctUntilChanged()
            .filter { $0 }
            .map { _ in .didAppearHeaderView }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
    }
    
    private func render(_ reactor: Reactor) {
        reactor.state.map { !$0.summaryBarHasVisable }
            .distinctUntilChanged()
            .bind(to: self.summaryBar.rx.isHidden)
            .disposed(by: self.disposeBag)
    }
    
    private func consume(_ reactor: Reactor) {
        
    }
    
    private let headerView = MyPageHeaderView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 200))
    private let summaryBar = MyPageSummaryBar()
    private let historyTableView = UITableView()
}
extension MyPageViewController {
    
    private func setupAttribute() {
        self.view.backgroundColor = .gray50
        self.historyTableView.do {
            $0.tableHeaderView = self.headerView
            $0.backgroundColor = .green100
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
            $0.top.leading.width.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(84)
        }
        self.summaryBar.isHidden = true
    }
    
}

extension MyPageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell().then { $0.contentView.backgroundColor = .gray500 }
    }
    
    
}
