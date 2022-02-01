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

final class FakeQRScanViewController: UIViewController, ReactorKit.View {
    typealias Reactor = FakeQRScanReactor
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupCapturePreviewLayer()
        self.setupCodeLabel()
    }
    
    func bind(reactor: FakeQRScanReactor) {
        self.rx.viewDidLoad.map { .didSetup }
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.code }
        .distinctUntilChanged()
        .bind(to: self.codeLabel.rx.text)
        .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.captureSession }
        .distinctUntilChanged()
        .subscribe(onNext: { [weak self] session in
            self?.updateCaptureSession(session)
        })
        .disposed(by: self.disposeBag)
    }
    
    private func updateCaptureSession(_ session: AVCaptureSession) {
        self.capturePreviewLayer.session = session
    }
    
    private let capturePreviewLayer = AVCaptureVideoPreviewLayer()
    private let codeLabel = UILabel()
}


// MARK: Setup
extension FakeQRScanViewController {
    
    private func setupCapturePreviewLayer() {
        self.capturePreviewLayer.frame = self.view.layer.bounds
        self.capturePreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.capturePreviewLayer.backgroundColor = UIColor.red.cgColor
        self.view.layer.addSublayer(self.capturePreviewLayer)
    }
    
    private func setupCodeLabel() {
        self.view.addSubview(self.codeLabel)
        self.codeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(24)
        }
    }
    
}
