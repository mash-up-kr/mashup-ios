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
        self.qrButton.rx.tap.map { .didTapQRButton }
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
    }
    
    private func render(_ reactor: Reactor) {
        
    }
    
    private func consume(_ reactor: Reactor) {
        reactor.pulse(\.$step).compactMap { $0 }
        .subscribe(onNext: { [weak self] step in
            switch step {
            case .qrScan:
                self?.pushQRScanViewController()
                
            case .seminarDetail(let seminarID):
                self?.pushSeminarDetailViewController(seminarID: seminarID)
            }
        })
        .disposed(by: self.disposeBag)
    }
    
    private let qrButton = UIButton()
    private let seminarsTableView = UITableView()
    
}
// MARK: - Setup
extension SeminarScheduleViewController {
    
    private func setupUI() {
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .systemRed
        self.view.addSubview(qrButton)
        self.qrButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(56)
            $0.trailing.equalToSuperview().inset(24)
            $0.height.width.equalTo(56)
        }
        self.qrButton.do {
            $0.backgroundColor = .systemIndigo
            $0.setImage(UIImage(systemName: "qrcode.viewfinder"), for: .normal)
            $0.tintColor = .white
            $0.layer.cornerRadius = 28
        }
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
