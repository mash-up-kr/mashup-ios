//
//  AttendanceRepository.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/07/20.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import MashUp_Core
import MashUp_Network

final class AttendanceRepositoryImpl: AttendanceRepository {
    
    init(network: any Network) {
        self.network = network
    }
    
    func attend(withCode code: Code) async -> Bool {
        let api = QRCodeAttendanceAPI(code: code)
        let result = await self.network.request(api)
        
        do {
            #warning("지각 처리 논의 되어야함 - booung")
            let status = try result.get().status
            guard status == .attendance else { return false }
            return true
        } catch let error as MashUpError {
            #warning("에러 핸들링 처리 필요 - booung")
            Logger.log("💥 \(error.asAttendanceError().localizedDescription)")
            return false
        } catch {
            #warning("undefined 에러 핸들링 처리 필요 - booung")
            Logger.log("💥 \(error.localizedDescription)")
            return false
        }
    }
    
    private let network: any Network
    
}
