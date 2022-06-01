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

public enum NetworkError: Error {
    case moyaError(MoyaError)
    case decodeFailure(DecodingError)
    case undefined(Error)
}

public protocol Network {
    func request<API: MashUpAPI>(_ api: API) async -> Result<API.Response, NetworkError>
    func request<API: MashUpAPI>(_ api: API) -> Observable<Result<API.Response, NetworkError>>
}

public final class HTTPClient: Network {
    
    public init() {}
    
    public func request<API: MashUpAPI>(_ api: API) async -> Result<API.Response, NetworkError> {
        let erasedAPI = MultiTarget(api)
        do {
            let response = try await self.provider.rx.request(erasedAPI).value
            let responseModel = try decoder.decode(ResponseModel<API.Response>.self, from: response.data)
            return .success(responseModel.data)
        } catch let error as MoyaError {
            return .failure(.moyaError(error))
        } catch let error as DecodingError {
            return .failure(.decodeFailure(error))
        } catch {
            return .failure(.undefined(error))
        }
    }
    
    public func request<API: MashUpAPI>(_ api: API) -> Observable<Result<API.Response, NetworkError>> {
        return AsyncStream { await self.request(api) }.asObservable()
    }
    
    private let provider = MoyaProvider<MultiTarget>()
    private let decoder = JSONDecoder()
    
}
