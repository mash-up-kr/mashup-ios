//
//  MyPageViewController.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/25.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import MashUp_Core

final class MyPageViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGreen
        
        self.setupLayout()
        
        self.headerView.configure(with: .init(userName: "김매시업", platformTeamText: "iOS", totalScoreText: "3.5점"))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupTabBarTheme(.light)
    }
    
    private let headerView = MyPageHeaderView()
    
}
extension MyPageViewController {
    
    private func setupLayout() {
        self.view.addSubview(self.headerView)
        self.headerView.snp.makeConstraints {
            $0.top.leading.width.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(200)
        }
    }
    
}
