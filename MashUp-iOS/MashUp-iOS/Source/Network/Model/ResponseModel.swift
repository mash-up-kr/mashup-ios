//
//  MashUpResponseModel.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/01/10.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

struct ResponseModel<Model: Decodable>: Decodable {
    let status: Int
    let data: Model
}
