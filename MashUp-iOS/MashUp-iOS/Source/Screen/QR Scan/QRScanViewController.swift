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
        .subscribe(onNext: self.updateCaptureSession)
        .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.code }
        .distinctUntilChanged()
        .onMain()
        .bind(to: self.codeLabel.rx.text)
        .disposed(by: self.disposeBag)
    }
    
    private func consume(_ reactor: Reactor) {
        reactor.pulse(\.$toastMessage).compactMap { $0 }
        .throttle(.seconds(2), scheduler: MainScheduler.asyncInstance)
        .onMain()
        .subscribe(onNext: { [weak self] message in
            self?.showToast(message: message)
        })
        .disposed(by: self.disposeBag)
    }
    
    private func updateCaptureSession(_ session: AVCaptureSession) {
        self.capturePreviewLayer.session = session
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
    private let qrCodeFinderView = QRCodeFinderView()
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
    }
    
    private func setupLayout() {
        self.view.do {
            $0.addSubview(self.qrCodeFinderView)
            $0.addSubview(self.toastView)
        }
        self.qrCodeFinderView.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-120)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(self.qrCodeFinderView.snp.width)
            $0.width.equalToSuperview().inset(32)
        }
        self.toastView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
