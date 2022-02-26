//
//  SeminarScheduleViewController.swift
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

final class SeminarScheduleViewController: BaseViewController, ReactorKit.View {
    typealias Reactor = SeminarScheduleReactor
    typealias Section = SeminarScheduleSection
    
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
    }
    
    private func render(_ reactor: Reactor) {
        
    }
    
    private func consume(_ reactor: Reactor) {
        reactor.pulse(\.$step).compactMap { $0 }
        .subscribe(onNext: { [weak self] step in
            switch step {
            case .seminarDetail(let seminarID):
                self?.pushSeminarDetailViewController(seminarID: seminarID)
            }
        })
        .disposed(by: self.disposeBag)
    }
    
    private let seminarsTableView = UITableView()
    
}
// MARK: - Setup
extension SeminarScheduleViewController {
    
    private func setupUI() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
}
// MARK: - Navigation
extension SeminarScheduleViewController {
    
    private func pushQRScanViewController() {
        let qrScanViewContorller = self.createQRScanViewController()
        self.navigationController?.pushViewController(qrScanViewContorller, animated: true)
    }
    
    private func pushSeminarDetailViewController(seminarID: String) {
        let seminarDetailViewController = self.createSeminarDetailViewController(seminarID: seminarID)
        self.navigationController?.pushViewController(seminarDetailViewController, animated: true)
    }
    
}
// MARK: - Factory
extension SeminarScheduleViewController {
    
    private func createQRScanViewController() -> QRScanViewController {
        let qrReaderService = QRReaderServiceImpl()
        let attendanceService = FakeAttendanceService()
        attendanceService.stubedCorrectCode = "I'am correct"
        let qrScanViewReactor = QRScanReactor(qrReaderService: qrReaderService, attendanceService: attendanceService)
        let qrScanViewController = QRScanViewController()
        qrScanViewController.reactor = qrScanViewReactor
        return qrScanViewController
    }
    
    private func createSeminarDetailViewController(seminarID: String) -> SeminarDetailViewController {
        let seminarDetailViewController = SeminarDetailViewController()
        return seminarDetailViewController
    }
    
}
