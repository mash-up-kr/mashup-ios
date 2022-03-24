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
@testable import MashUp_iOS

final class QRScanReactorSpec: QuickSpec {
  
  override func spec() {
    var sut: QRScanReactor!
    var captureSessionDummy: AVCaptureSession!
    var qrReaderServiceMock: QRReaderServiceMock!
    var seminarRepositoryMock: SeminarRepositoryMock!
    var attendanceServiceMock: AttendanceServiceMock!
    var timerServiceMock: TimerServiceMock!
    var attendanceTimelineRepositoryMock: AttendanceTimelineRepositoryMock!
    var formatterMock: QRScanFormatterMock!
    
    beforeEach {
      captureSessionDummy = AVCaptureSession()
      qrReaderServiceMock = mock(QRReaderService.self)
      seminarRepositoryMock = mock(SeminarRepository.self)
      attendanceServiceMock = mock(AttendanceService.self)
      timerServiceMock = mock(TimerService.self)
      attendanceTimelineRepositoryMock = mock(AttendanceTimelineRepository.self)
      formatterMock = mock(QRScanFormatter.self)
    }
    describe("QRScanReactor") {
      let dummyTimeline = AttendanceTimeline.stub()
      let nearestSeminarStub = Seminar.stub()
      let seminarCardViewModelStub = QRSeminarCardViewModel.stub()
      beforeEach {
        given(qrReaderServiceMock.scanCodeWhileSessionIsOpen()).willReturn(.empty())
        given(qrReaderServiceMock.captureSession).willReturn(captureSessionDummy)
        given(seminarRepositoryMock.nearestSeminar()).willReturn(.just(nearestSeminarStub))
        given(attendanceTimelineRepositoryMock.attendanceTimeline(
          ofUserID: any(),
          seminarID: any()
        )).willReturn(.just(dummyTimeline))
        given(formatterMock.formatSeminarCard(
          from: any(),
          timeline: any()
        )).willReturn(seminarCardViewModelStub)
        sut = QRScanReactor(
          qrReaderService: qrReaderServiceMock,
          seminarRepository: seminarRepositoryMock,
          attendanceService: attendanceServiceMock,
          timerService: timerServiceMock,
          attendanceTimelineRepository: attendanceTimelineRepositoryMock,
          formatter: formatterMock
        )
      }
      context("when did set up") {
        beforeEach {
          sut.action.onNext(.didSetup)
        }
        it("qr reader is ready to scan code") {
          verify(qrReaderServiceMock.scanCodeWhileSessionIsOpen()).wasCalled()
        }
        it("load nearest seminar info") {
          verify(seminarRepositoryMock.nearestSeminar()).wasCalled()
        }
      }
      context("when capture code from session") {
        let stubbedCode = "stubbed.code"
        let correctCode: String = "correct.code"
        let wrongCode: String = "wrong.code"
        beforeEach {
          given(qrReaderServiceMock.scanCodeWhileSessionIsOpen()).willReturn(.just(stubbedCode))
          given(attendanceServiceMock.attend(withCode: any())).willReturn(.just(false))
          given(attendanceServiceMock.attend(withCode: correctCode)).willReturn(.just(true))
        }
        it("request attendence with captured code") {
          sut.action.onNext(.didSetup)
          verify(attendanceServiceMock.attend(withCode: stubbedCode)).wasCalled()
        }
        context("when request attendance with correct code") {
          beforeEach {
            given(qrReaderServiceMock.scanCodeWhileSessionIsOpen()).willReturn(.just(correctCode))
          }
          it("attendance did success") {
            sut.action.onNext(.didSetup)
            expect { sut.currentState.toastMessage }.to(equal("✅ 출석을 완료하셨습니다."))
          }
        }
        context("when request attendance with wrong code") {
          beforeEach {
            given(qrReaderServiceMock.scanCodeWhileSessionIsOpen()).willReturn(.just(wrongCode))
          }
          it("attendance did failure") {
            sut.action.onNext(.didSetup)
            expect { sut.currentState.toastMessage }.to(equal("❌ 올바른 코드가 아닙니다."))
          }
        }
      }
    }
  }
}
