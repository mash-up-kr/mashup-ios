//
//  API.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/01/10.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import Moya

protocol MashUpAPI: TargetType {
    associatedtype Response: Decodable
}
extension MashUpAPI {
    var baseURL: URL { URL(string: NetworkConfig.mashupHost)! }
}
