//
//  QRScannReactorSpec.swift
//  MashUp-iOSTests
//
//  Created by Booung on 2022/02/20.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//


import Quick
import RxBlocking
@testable import MashUp_iOS
import Mockingbird

final class QRScannReactorSpec: QuickSpec {
  
  override func spec() {
    var sut: QRScanReactor!
    var qrReaderMock: QRReaderServiceMock!
    var attendanceServiceMock: AttendanceServiceMock!
    
    beforeEach {
      qrReaderMock = mock(QRReaderService.self)
      attendanceServiceMock = mock(AttendanceService.self)
      sut = QRScanReactor(qrReader: qrReaderMock, attendanceService: attendanceServiceMock)
    }
    
    describe("QRScanReactor") {
      context("when did set up") {
        it("qr reader is ready to scan code") {
          
        }
      }
    }
  }
  
}
