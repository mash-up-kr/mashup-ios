//
//  HTTPClient.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/01/10.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import RxMoya

protocol Network {
    func request<API: MashUpAPI>(_ api: API) -> Observable<API.Response>
}

final class HTTPClient: Network {
    
    func request<API>(_ api: API) -> Observable<API.Response> where API : MashUpAPI {
        let erasedAPI = MultiTarget(api)
        
        return self.provider.rx.request(erasedAPI)
            .asObservable()
            .compactMap { [weak self] in
                try self?.decoder.decode(ResponseModel<API.Response>.self, from: $0.data).data
            }
    }
    
    private let provider = MoyaProvider<MultiTarget>()
    private let decoder = JSONDecoder()
    
}
