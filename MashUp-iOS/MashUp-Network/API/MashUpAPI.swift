//
//  API.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/01/10.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import Moya
import Alamofire

public typealias HTTPMethod = Moya.Method
public typealias HTTPTask = Moya.Task
public typealias JSONEncoding = Alamofire.JSONEncoding

public protocol MashUpAPI: TargetType {
    associatedtype Response: Decodable
    
    var httpMethod: HTTPMethod { get }
    var httpTask: HTTPTask { get }
}
public extension MashUpAPI {
    var baseURL: URL { URL(string: NetworkConfig.mashupHost)! }
    var method: Moya.Method { self.httpMethod }
    var task: Moya.Task { self.httpTask }
}
