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
import MashUp_Core
import MashUp_UIKit
import MashUp_User
import FLEX

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
        
        self.qrButton.rx.tap
            .map { .didTapQRButton }
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
        reactor.pulse(\.$step)
            .compactMap { $0 }
            .onMain()
            .subscribe(onNext: { [weak self] step in self?.move(to: step) })
            .disposed(by: self.disposeBag)
    }
    
    private let qrButton = UIButton()
    
}
// MARK: - Setup
extension HomeTabBarController {
    
    private func setupUI() {
        self.tabBar.do {
            $0.tintColor = .black
            $0.backgroundColor = .white
            $0.itemSpacing = 120
            $0.itemPositioning = .centered
        }
        
        self.qrButton.do {
            $0.backgroundColor = .brand500
            $0.layer.cornerRadius = 24
            $0.layer.masksToBounds = true
            $0.setImage(.ic_qr?.resized(side: 24).withTintColor(.white), for: .normal)
        }
        self.tabBar.addSubview(self.qrButton)
        self.qrButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.tabBar).inset(10)
            $0.size.equalTo(48)
        }
    }
    
}
// MARK: - Factory
extension HomeTabBarController {
    
    private func move(to step: HomeStep) {
        switch step {
        case .qr:
            let viewController = self.createQRScanViewController()
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true)
        }
    }
    
    #warning("DIContainer로 로직 이동해야합니다.")
    private func viewControllers(of tabItems: [HomeTab]) -> [UIViewController] {
        return tabItems.map { tab in
            let viewController: UIViewController
            switch tab {
            case .seminarSchedule:
                viewController = UINavigationController(rootViewController: self.createSeminarScheduleViewController())
            case .myPage:
                viewController = self.createMyPageViewController()
            }
            viewController.tabBarItem = tab.asTabBarItem()
            return viewController
        }
    }
    
    private func createSeminarScheduleViewController() -> UIViewController {
        let seminarRepository = self.createSeminarRepository()
        let seminarSchedulerFormatter = SeminarSchedulerFormatterImpl()
        let seminarScheduleReactor = SeminarScheduleReactor(
            seminarRepository: seminarRepository,
            seminarSchedulerFormatter: seminarSchedulerFormatter
        )
        let seminarScheduleViewController = SeminarScheduleViewController()
        seminarScheduleViewController.reactor = seminarScheduleReactor
        return seminarScheduleViewController
    }
    
    private func createMyPageViewController() -> UIViewController {
        let myPageViewController = MyPageViewController()
        let clubActivityRepository = FakeClubActivityRepository()
        let clubActivityService = ClubActivityServiceImp(clubActivityRepository: clubActivityRepository)
        let formatter = MyPageFormatterImp()
        #warning("user session injection - booung")
        let userSession = UserSession(
            id: .empty,
            accessToken: .empty,
            name: "김매시업",
            platformTeam: .iOS,
            generations: [12]
        )
        myPageViewController.reactor = MyPageReactor(
            userSession: userSession,
            clubActivityService: clubActivityService,
            formatter: formatter,
            debugSystem: FLEXManager.shared
        )
        return UINavigationController(rootViewController: myPageViewController).then {
            $0.navigationBar.isHidden = true
        }
    }
    
    private func createQRScanViewController() -> UIViewController {
        let qrReaderService = QRReaderServiceImpl()
        let attendanceService = self.createAttendanceService()
        let formatter = QRScanFormatterImpl()
        let qrScanViewReactor = QRScanReactor(
            qrReaderService: qrReaderService,
            attendanceService: attendanceService,
            formatter: formatter
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
    
}
