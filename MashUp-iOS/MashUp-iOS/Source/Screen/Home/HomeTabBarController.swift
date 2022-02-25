//
//  HomeViewController.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/25.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import ReactorKit
import RxSwift
import RxCocoa
import SnapKit
import UIKit
import ReactiveSwift

final class HomeTabBarController: BaseTabBarController, ReactorKit.View {
    typealias Reactor = HomeReactor
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = .black
        self.tabBar.backgroundColor = .white
    }
    
    func bind(reactor: Reactor) {
        self.dispatch(to: reactor)
        self.render(reactor)
        self.consume(reactor)
    }
    
    private func dispatch(to reactor: Reactor) {
        self.rx.didSelect.distinctUntilChanged()
            .compactMap { [weak self] in self?.viewControllers?.firstIndex(of: $0) }
            .map { .didSelectTabItem($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    private func render(_ reactor: Reactor) {
        reactor.state.map { $0.tabItems }
        .distinctUntilChanged()
        .map(self.viewControllers(of:))
        .bind(to: self.rx.viewControllers)
        .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.currentTab.rawValue }
        .distinctUntilChanged()
        .bind(to: self.rx.selectedIndex)
        .disposed(by: self.disposeBag)
    }
    
    private func consume(_ reactor: Reactor) {
        
    }
    
    #warning("DIContainer로 로직 이동해야합니다.")
    private func viewControllers(of tabItems: [HomeTab]) -> [UIViewController] {
        return tabItems.map { tab in
            let viewController: UIViewController
            switch tab {
            case .seminarSchedule:
                viewController = self.createSeminarScheduleViewController()
            case .myPage:
                viewController = self.createMyPageViewController()
            case .setting:
                viewController = self.createSettingViewController()
            }
            viewController.tabBarItem = tab.asTabBarItem()
            return viewController
        }
    }
    
    private func createSeminarScheduleViewController() -> UIViewController {
        let seminarScheduleViewController = SeminarScheduleViewController()
        return seminarScheduleViewController
    }
    
    private func createMyPageViewController() -> UIViewController {
        let myPageViewController = MyPageViewController()
        return myPageViewController
    }
    
    private func createSettingViewController() -> UIViewController {
        let settingViewController = SettingViewController()
        return settingViewController
    }
    
}