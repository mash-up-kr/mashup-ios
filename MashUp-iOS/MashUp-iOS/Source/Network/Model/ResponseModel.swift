//
//  MashUpResponseModel.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/01/10.
//

import Foundation

struct ResponseModel<Model: Decodable>: Decodable {
    let status: Int
    let data: Model
}
