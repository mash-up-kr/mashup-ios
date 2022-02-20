//
//  QRScannReactorSpec.swift
//  MashUp-iOSTests
//
//  Created by Booung on 2022/02/20.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//


import AVFoundation
import Mockingbird
import Nimble
import Quick
import RxBlocking
@testable import MashUp_iOS

final class QRScannReactorSpec: QuickSpec {
  
  override func spec() {
    var sut: QRScanReactor!
    var captureSessionDummy: AVCaptureSession!
    var qrReaderMock: QRReaderServiceMock!
    var attendanceServiceMock: AttendanceServiceMock!
    
    beforeEach {
      captureSessionDummy = AVCaptureSession()
      qrReaderMock = mock(QRReaderService.self)
      attendanceServiceMock = mock(AttendanceService.self)
    }
    describe("QRScanReactor") {
      beforeEach {
        given(qrReaderMock.scanCode()).willReturn(.empty())
        given(qrReaderMock.captureSession).willReturn(captureSessionDummy)
        sut = QRScanReactor(qrReader: qrReaderMock, attendanceService: attendanceServiceMock)
      }
      context("when did set up") {
        beforeEach {
          sut.action.onNext(.didSetup)
        }
        it("qr reader is ready to scan code") {
          verify(qrReaderMock.scanCode()).wasCalled()
        }
        context("when capture code from session") {
          let stubbedCode = "stubbed.code"
          let correctCode: String = "correct.code"
          let wrongCode: String = "wrong.code"
          beforeEach {
            given(qrReaderMock.scanCode()).willReturn(.just(stubbedCode))
            given(attendanceServiceMock.attend(withCode: any())).willReturn(.just(false))
            given(attendanceServiceMock.attend(withCode: correctCode)).willReturn(.just(true))
          }
          it("request attendence with captured code") {
            sut.action.onNext(.didSetup)
            verify(attendanceServiceMock.attend(withCode: stubbedCode)).wasCalled()
          }
          context("requesting attendance with correct code") {
            beforeEach {
              given(qrReaderMock.scanCode()).willReturn(.just(correctCode))
            }
            it("attendance did success") {
              sut.action.onNext(.didSetup)
              expect { sut.currentState.alertMessage }.to(equal("✅ 출석을 완료하셨습니다."))
            }
          }
          context("requesting attendance with wrong code") {
            beforeEach {
              given(qrReaderMock.scanCode()).willReturn(.just(wrongCode))
            }
            it("attendance did failure") {
              sut.action.onNext(.didSetup)
              expect { sut.currentState.alertMessage }.to(equal("❌ 올바른 코드가 아닙니다."))
            }
          }
        }
      }
    }
  }
}
