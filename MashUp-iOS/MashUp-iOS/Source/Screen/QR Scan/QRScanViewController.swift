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
import MashUp_Core

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
        
        self.closeButton.rx.tap
            .map { .didTapClose }
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
    }
    
    private func consume(_ reactor: Reactor) {
        reactor.pulse(\.$toastMessage).compactMap { $0 }
            .throttle(.seconds(2), scheduler: MainScheduler.asyncInstance)
            .onMain()
            .subscribe(onNext: { [weak self] message in self?.showToast(message: message) })
            .disposed(by: self.disposeBag)
        
        reactor.pulse(\.$shouldClose).compactMap { $0 }
            .onMain()
            .subscribe(onNext: { [weak self] in self?.close() })
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
    
    private func close() {
        self.dismiss(animated: true)
    }
    
    private let capturePreviewLayer = AVCaptureVideoPreviewLayer()
    private let closeButton = UIButton()
    private let toastView = PaddingLabel()
    private let qrGuideLabel = UILabel()
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
        self.closeButton.do {
            $0.setBackgroundImage(UIImage(named: "name=xmark, color=white, size=Default"), for: .normal)
        }
        self.qrGuideLabel.do {
            $0.text = "QR 코드를 스캔하세요"
            $0.font = .systemFont(ofSize: 16, weight: .bold)
            $0.textColor = .white
        }
        self.toastView.do {
            $0.alpha = 0
            $0.contentInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
            $0.backgroundColor = .gray700
            $0.textColor = .white
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 12
        }
    }
    
    private func setupLayout() {
        self.view.do {
            $0.addSubview(self.closeButton)
            $0.addSubview(self.qrGuideLabel)
            $0.addSubview(self.toastView)
        }
        self.closeButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(21)
            $0.trailing.equalToSuperview().inset(14)
            $0.size.equalTo(40)
        }
        self.qrGuideLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(122)
        }
        self.toastView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(33)
        }
    }
}
