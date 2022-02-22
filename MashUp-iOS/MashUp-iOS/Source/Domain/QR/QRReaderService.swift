//
//  QRScanService.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/01.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import AVFoundation
import Foundation
import RxSwift
import RxRelay

typealias Code = String

protocol QRReaderService {
    var captureSession: AVCaptureSession { get }
    
    func scanCodeWhileSessionIsOpen() -> Observable<Code>
}

final class QRReaderServiceImpl: NSObject, QRReaderService  {
    
    let captureSession = AVCaptureSession()
    
    func scanCodeWhileSessionIsOpen() -> Observable<Code> {
        if self.isReadyToScan == false {
            self.setupScanPipeline()
            self.isReadyToScan = true
        }
        return self.codeRelay.asObservable()
    }
    
    private func setupScanPipeline() {
        self.readVideoCapture()
        self.decodeVideoCapture()
    }
    
    private func readVideoCapture() {
        guard let videoCapture = AVCaptureDevice.default(for: .video) else { return }
        guard let capture = try? AVCaptureDeviceInput(device: videoCapture) else { return }
        guard self.captureSession.canAddInput(capture) else { return }
        
        self.captureSession.addInput(capture)
    }
    
    private func decodeVideoCapture() {
        let scannedOutput = AVCaptureMetadataOutput()
        guard self.captureSession.canAddOutput(scannedOutput) else { return }
        self.captureSession.addOutput(scannedOutput)
        scannedOutput.setMetadataObjectsDelegate(self, queue: self.scanningQueue)
        scannedOutput.metadataObjectTypes = [.qr]
        self.captureSession.startRunning()
    }
    
    private var isReadyToScan = false
    private let scanningQueue = DispatchQueue(label: "qr.scanning.queue")
    private let codeRelay = PublishRelay<Code>()
    
}

extension QRReaderServiceImpl: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(
        _ output: AVCaptureMetadataOutput,
        didOutput metadataObjects: [AVMetadataObject],
        from connection: AVCaptureConnection
    ) {
        guard let meta = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
              let code = meta.stringValue
        else { return }
        
        self.codeRelay.accept(code)
    }
}
