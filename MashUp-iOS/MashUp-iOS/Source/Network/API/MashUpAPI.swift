//
//  API.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/01/10.
//

import Foundation
import Moya

protocol MashUpAPI: TargetType {
    associatedtype Response: Decodable
}
