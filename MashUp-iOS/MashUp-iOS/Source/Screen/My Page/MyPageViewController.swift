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

final class MyPageViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGreen
        
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
    
    private let headerView = MyPageHeaderView()
    private let summaryBar = MyPageSummaryBar()
    
}
extension MyPageViewController {
    
    private func setupLayout() {
        self.view.addSubview(self.headerView)
        self.headerView.snp.makeConstraints {
            $0.top.leading.width.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(200)
        }
        self.view.addSubview(self.summaryBar)
        self.summaryBar.snp.makeConstraints {
            $0.top.leading.width.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(84)
        }
    }
    
}
