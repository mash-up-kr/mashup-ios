//
//  FakeQRScanViewController.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/01.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import AVFoundation
import ReactorKit
import RxSwift
import RxCocoa
import SnapKit
import UIKit


struct TimerStyle: Equatable {
    let isAdmin: Bool
    let remainTime: String?
}


final class QRScanViewController: BaseViewController, ReactorKit.View {
    typealias Reactor = QRScanReactor
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupTabBarTheme(.dark)
    }
    
    func bind(reactor: QRScanReactor) {
        self.dispatch(to: reactor)
        self.render(reactor)
        self.consume(reactor)
    }
    
    private func dispatch(to reactor: Reactor) {
        self.rx.viewDidLoad.map { .didSetup }
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
    }
    
    private func render(_ reactor: Reactor) {
        reactor.state.map { $0.captureSession }
        .distinctUntilChanged()
        .onMain()
        .withUnretained(self)
        .subscribe(onNext: { $0.updateCaptureSession($1) })
        .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.code }
        .distinctUntilChanged()
        .onMain()
        .bind(to: self.codeLabel.rx.text)
        .disposed(by: self.disposeBag)
        
        reactor.state.compactMap { $0.timer }
        .distinctUntilChanged()
        .onMain()
        .withUnretained(self)
        .subscribe(onNext: { $0.updateTimer($1) })
        .disposed(by: self.disposeBag)
        
        reactor.state.compactMap { $0.seminarAttendancePhase }
        .distinctUntilChanged()
        .onMain()
        .withUnretained(self)
        .subscribe(onNext: { $0.updateSeminarAttendancePhaseCard($1) })
        .disposed(by: self.disposeBag)
    }
    
    private func consume(_ reactor: Reactor) {
        reactor.pulse(\.$toastMessage).compactMap { $0 }
        .throttle(.seconds(2), scheduler: MainScheduler.asyncInstance)
        .onMain()
        .withUnretained(self)
        .subscribe(onNext: { $0.showToast(message: $1) })
        .disposed(by: self.disposeBag)
    }
    
    private func updateCaptureSession(_ session: AVCaptureSession) {
        self.capturePreviewLayer.session = session
    }
    
    private func updateSeminarAttendancePhaseCard(_ attendancePhaseCardViewModel: SeminarAttendancePhaseCardViewModel) {
        self.attendancePhaseCardView.configure(with: attendancePhaseCardViewModel)
    }
    
    private func updateTimer(_ timerStyle: TimerStyle) {
        self.timerView.isHidden = timerStyle.isAdmin == true
        self.adminTimerButton.isHidden = timerStyle.isAdmin != true
        self.timerView.text = timerStyle.remainTime
        self.adminTimerButton.isEnabled = timerStyle.remainTime == nil
        self.adminTimerButton.setTitle("타이머 동작중 | \(timerStyle.remainTime ?? .empty)", for: .disabled)
    }
    
    private func showToast(message: String) {
        self.toastView.text = message
        self.toastView.alpha = 0
        UIView.animate(withDuration: 0.2) {
            self.toastView.alpha = 1
        } completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                UIView.animate(withDuration: 0.2) {
                    self.toastView.alpha = 0
                }
            }
        }
    }
    
    private let capturePreviewLayer = AVCaptureVideoPreviewLayer()
    private let codeLabel = UILabel()
    private let toastView = PaddingLabel()
    private let qrGuideLabel = UILabel()
    private let timerView = PaddingLabel()
    private let adminTimerButton = UIButton()
    private let qrCodeFinderView = QRCodeFinderView()
    private let attendancePhaseCardView = SeminarAttendancePhaseCardView()
}

// MARK: Setup
extension QRScanViewController {
    
    private func setupUI() {
        self.setupCapturePreviewLayer()
        self.setupAttribute()
        self.setupLayout()
    }
    
    private func setupCapturePreviewLayer() {
        self.capturePreviewLayer.frame = self.view.layer.bounds
        self.capturePreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.capturePreviewLayer.backgroundColor = UIColor.red.cgColor
        self.view.layer.addSublayer(self.capturePreviewLayer)
    }
    
    private func setupAttribute() {
        self.toastView.do {
            $0.alpha = 0
            $0.contentInsets = UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 20)
            $0.backgroundColor = .systemGreen
            $0.textColor = .white
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 8
        }
        self.qrGuideLabel.do {
            $0.text = "QR 코드를 스캔하세요"
            $0.font = .systemFont(ofSize: 20, weight: .bold)
            $0.textColor = .white
        }
        self.timerView.do {
            $0.font = .systemFont(ofSize: 15, weight: .bold)
            $0.textColor = .white
            $0.backgroundColor = .systemIndigo
            $0.layer.cornerRadius = 16.5
            $0.clipsToBounds = true
        }
        self.adminTimerButton.do {
            $0.setTitle("타이머 시작", for: .normal)
            $0.setBackgroundColor(.systemBlue, for: .normal)
            $0.setBackgroundColor(.systemIndigo, for: .disabled)
            $0.layer.cornerRadius = 12
            $0.clipsToBounds = true
            $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        }
    }
    
    private func setupLayout() {
        self.view.do {
            $0.addSubview(self.qrCodeFinderView)
            $0.addSubview(self.toastView)
            $0.addSubview(self.timerView)
            $0.addSubview(self.adminTimerButton)
            $0.addSubview(self.qrGuideLabel)
            $0.addSubview(self.attendancePhaseCardView)
        }
        self.qrCodeFinderView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(90)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(self.qrCodeFinderView.snp.width)
        }
        self.toastView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        self.qrGuideLabel.snp.makeConstraints {
            $0.top.equalTo(self.qrCodeFinderView.snp.bottom).offset(14)
            $0.centerX.equalToSuperview()
        }
        self.timerView.snp.makeConstraints {
            $0.top.equalTo(self.qrGuideLabel.snp.bottom).offset(14)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(33)
        }
        self.adminTimerButton.snp.makeConstraints {
            $0.top.equalTo(self.qrGuideLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(48)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        self.attendancePhaseCardView.snp.makeConstraints {
            $0.top.equalTo(self.timerView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(54)
            $0.height.equalTo(162)
        }
    }
}
