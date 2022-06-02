//
//  MashUpResponseModel.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/01/10.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

public struct ResponseModel<Model: Decodable>: Decodable {
    public let status: Int
    public let data: Model
}
