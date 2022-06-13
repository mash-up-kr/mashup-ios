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
import RxSwift
import RxBlocking
import MashUp_Core
@testable import MashUp_iOS

final class QRScanReactorSpec: QuickSpec {
  
  override func spec() {
    var sut: QRScanReactor!
    var captureSessionDummy: AVCaptureSession!
    var qrReaderServiceMock: QRReaderServiceMock!
    var attendanceServiceMock: AttendanceServiceMock!
    var formatterMock: QRScanFormatterMock!
    
    beforeEach {
      captureSessionDummy = AVCaptureSession()
      qrReaderServiceMock = mock(QRReaderService.self)
      attendanceServiceMock = mock(AttendanceService.self)
      formatterMock = mock(QRScanFormatter.self)
    }
    describe("QRScanReactor") {
      let seminarCardViewModelStub = QRSeminarCardViewModel.stub()
      beforeEach {
        given(qrReaderServiceMock.scanCodeWhileSessionIsOpen()).willReturn(.empty())
        given(qrReaderServiceMock.captureSession).willReturn(captureSessionDummy)
        given(formatterMock.formatSeminarCard(
          from: any(),
          timeline: any()
        )).willReturn(seminarCardViewModelStub)
        sut = QRScanReactor(
          qrReaderService: qrReaderServiceMock,
          attendanceService: attendanceServiceMock,
          formatter: formatterMock
        )
      }
      context("화면이 준비가 되면") {
        beforeEach {
          sut.action.onNext(.didSetup)
        }
        it("QR코드를 인식할 준비를 합니다.") {
          verify(qrReaderServiceMock.scanCodeWhileSessionIsOpen()).wasCalled()
        }
      }
      context("QR코드를 인식하면") {
        let stubbedCode = "stubbed.code"
        let correctCode: String = "correct.code"
        let wrongCode: String = "wrong.code"
        beforeEach {
          given(qrReaderServiceMock.scanCodeWhileSessionIsOpen()).willReturn(.just(stubbedCode))
          given(attendanceServiceMock.attend(withCode: any())).willReturn(.just(false))
          given(attendanceServiceMock.attend(withCode: correctCode)).willReturn(.just(true))
        }
        it("디코딩된 코드로 출석체크 요청을 합니다.") {
          sut.action.onNext(.didSetup)
          verify(attendanceServiceMock.attend(withCode: stubbedCode)).wasCalled()
        }
        context("코드가 올바르다면") {
          beforeEach {
            given(qrReaderServiceMock.scanCodeWhileSessionIsOpen()).willReturn(.just(correctCode))
          }
          it("출석체크 성공 토스트가 표시됩니다") {
            sut.action.onNext(.didSetup)
            expect { sut.currentState.toastMessage }.to(equal("✅ 출석을 완료하셨습니다."))
          }
        }
        context("코드가 올바르지 않다면") {
          beforeEach {
            given(qrReaderServiceMock.scanCodeWhileSessionIsOpen()).willReturn(.just(wrongCode))
          }
          it("출석체크 실패 토스트가 표시됩니다") {
            sut.action.onNext(.didSetup)
            expect { sut.currentState.toastMessage }.to(equal("❌ 올바른 코드가 아닙니다."))
          }
        }
      }
    }
  }
}
