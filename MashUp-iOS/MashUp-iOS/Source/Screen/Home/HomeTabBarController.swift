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

final class HomeTabBarController: BaseTabBarController, ReactorKit.View {
    typealias Reactor = HomeReactor
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func bind(reactor: Reactor) {
        self.dispatch(to: reactor)
        self.render(reactor)
        self.consume(reactor)
    }
    
    private func dispatch(to reactor: Reactor) {
        self.rx.didSelect.distinctUntilChanged()
            .withUnretained(self)
            .compactMap { $0.viewControllers?.firstIndex(of: $1) }
            .map { .didSelectTabItem(at: $0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    private func render(_ reactor: Reactor) {
        reactor.state.map { $0.tabItems }
        .distinctUntilChanged()
        .withUnretained(self)
        .map { $0.viewControllers(of: $1) }
        .onMain()
        .bind(to: self.rx.viewControllers)
        .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.currentTab.rawValue }
        .distinctUntilChanged()
        .onMain()
        .bind(to: self.rx.selectedIndex)
        .disposed(by: self.disposeBag)
    }
    
    private func consume(_ reactor: Reactor) {
        
    }
    
    
}
// MARK: - Setup
extension HomeTabBarController {
    
    private func setupUI() {
        self.tabBar.tintColor = .black
        self.tabBar.backgroundColor = .white
    }
    
}
// MARK: - Factory
extension HomeTabBarController {
    
    #warning("DIContainer로 로직 이동해야합니다.")
    private func viewControllers(of tabItems: [HomeTab]) -> [UIViewController] {
        return tabItems.map { tab in
            let viewController: UIViewController
            switch tab {
            case .seminarSchedule:
                viewController = UINavigationController(rootViewController: self.createSeminarScheduleViewController())
            case .qr:
                viewController = self.createQRScanViewController()
            case .myPage:
                viewController = self.createMyPageViewController()
            }
            viewController.tabBarItem = tab.asTabBarItem()
            return viewController
        }
    }
    
    private func createSeminarScheduleViewController() -> UIViewController {
        let seminarRepository = self.createSeminarRepository()
        let seminarScheduleReactor = SeminarScheduleReactor(seminarRepository: seminarRepository)
        let seminarScheduleViewController = SeminarScheduleViewController()
        seminarScheduleViewController.reactor = seminarScheduleReactor
        return seminarScheduleViewController
    }
    
    private func createMyPageViewController() -> UIViewController {
        let myPageViewController = MyPageViewController()
        return myPageViewController
    }
    
    private func createQRScanViewController() -> UIViewController {
        let seminarRepository = self.createSeminarRepository()
        let qrReaderService = QRReaderServiceImpl()
        let attendanceService = self.createAttendanceService()
        let attendanceTimelineRepository = self.createAttendanceTimelineRepository()
        let qrScanViewReactor = QRScanReactor(
            qrReaderService: qrReaderService,
            seminarRepository: seminarRepository,
            attendanceService: attendanceService,
            attendanceTimelineRepository: attendanceTimelineRepository
        )
        let qrScanViewController = QRScanViewController()
        qrScanViewController.reactor = qrScanViewReactor
        return qrScanViewController
    }
    
    private func createSeminarRepository() -> SeminarRepository {
        #warning("SeminarRepository 실구현체로 대체해야합니다.")
        let seminarRepository = FakeSeminarRepository()
        seminarRepository.stubedSeminars = Seminar.dummy
        return seminarRepository
    }
    
    private func createAttendanceService() -> AttendanceService {
        #warning("AttendanceService 실구현체로 대체해야합니다.")
        let attendanceService = FakeAttendanceService()
        attendanceService.stubedCorrectCode = "I'm correct"
        return attendanceService
    }
    
    private func createAttendanceTimelineRepository() -> AttendanceTimelineRepository {
        #warning("AttendanceTimelineRepository 실구현체로 대체해야합니다.")
        let attendanceTimelineRepository = FakeAttendanceTimelineRepository()
        let partialAttendance1 = PartialAttendance(
            phase: .phase1,
            status: .lateness,
            timestamp: Date(year: 2022, month: 4, day: 1, hour: 3, minute: 16, second: 24)
        )
        let partialAttendance2 = PartialAttendance(
            phase: .phase2,
            status: .attend,
            timestamp: Date(year: 2022, month: 4, day: 1, hour: 4, minute: 0, second: 24)
        )
        
        attendanceTimelineRepository.stubbedTimeline = AttendanceTimeline(partialAttendance1: partialAttendance1,
                                                                          partialAttendance2: partialAttendance2)
        return attendanceTimelineRepository
    }
    
}
