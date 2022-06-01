//
//  API.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/01/10.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import Moya

public protocol MashUpAPI: TargetType {
    associatedtype Response: Decodable
}
public extension MashUpAPI {
    var baseURL: URL { URL(string: NetworkConfig.mashupHost)! }
}

public enum MAPI : MashUpAPI {
  public var path: String {  "" }
  
  public var method: Moya.Method { .get }
  
  public var task: Task { .requestPlain }
  
  public var headers: [String : String]? { [:] }
  
    case normal
}
extension MAPI {
  public typealias Response = Int
}
