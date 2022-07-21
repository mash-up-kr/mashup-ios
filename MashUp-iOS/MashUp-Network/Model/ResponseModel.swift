//
//  MashUpResponseModel.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/01/10.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

struct ResponseModel<Model: Decodable>: Decodable {
    let code: String
    let message: String
    let data: Model?
}
extension ResponseModel {
    var isSuccess: Bool { self.code.lowercased() == "success" }
}
