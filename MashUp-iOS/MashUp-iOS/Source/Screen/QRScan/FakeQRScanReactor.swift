//
//  FakeQRScanReactor.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/02.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import ReactorKit
import AVFoundation

final class FakeQRScanReactor: Reactor {
    
    enum Action {
        case didSetup
    }
    
    enum Mutation {
        case updateCode(Code)
    }
    
    struct State {
        let captureSession: AVCaptureSession
        var code: Code?
    }
    
    let initialState: State
    
    init(qrReader: QRReaderService = QRReaderServiceImpl()) {
        self.qrReader = qrReader
        self.initialState = State(captureSession: qrReader.captureSession)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didSetup:
            return self.qrReader.scanCode()
                .distinctUntilChanged()
                .map { .updateCode($0) }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .updateCode(let code):
            newState.code = code
        }
        return newState
    }
    
    private let qrReader: QRReaderService
    
}
