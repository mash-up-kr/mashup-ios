//
//  Network.swift
//  MashUp-Network
//
//  Created by Booung on 2022/06/02.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import RxSwift

public protocol Network {
    func request<API: MashUpAPI>(_ api: API) async -> Result<API.Response, NetworkError>
    func request<API: MashUpAPI>(_ api: API) -> Observable<Result<API.Response, NetworkError>>
}
extension Network {
    public func request<API: MashUpAPI>(_ api: API) -> Observable<Result<API.Response, NetworkError>> {
        AsyncStream.single { await self.request(api) }.asObservable()
    }
}
