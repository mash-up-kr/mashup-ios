//
//  HTTPClient.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/01/10.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import MashUp_Core
import Moya
import RxMoya


public final class HTTPClient: Network {
    
    public init() {}
    
    public func request<API: MashUpAPI>(_ api: API) async -> Result<API.Response, NetworkError> {
        let erasedAPI = MultiTarget(api)
        do {
            let response = try await self.provider.rx.request(erasedAPI).value
            let responseModel = try decoder.decode(ResponseModel<API.Response>.self, from: response.data)
            return .success(responseModel.data)
        } catch let error as AFError {
            Logger.log(error.localizedDescription, .error)
            if error.isExplicitlyCancelledError { return .failure(.cancelled) }
            else { return .failure(.undefined(error)) }
        } catch let error as MoyaError {
            Logger.log(error.localizedDescription)
            return .failure(.undefined(error))
        } catch let error as DecodingError {
            Logger.log(error.localizedDescription)
            return .failure(.undefined(error))
        } catch {
            Logger.log(error.localizedDescription, .error)
            return .failure(.undefined(error))
        }
    }
    
    public func request<API: MashUpAPI>(_ api: API) -> Observable<Result<API.Response, NetworkError>> {
        return AsyncStream { await self.request(api) }.asObservable()
    }
    
    private let provider = MoyaProvider<MultiTarget>()
    private let decoder = JSONDecoder()
    
}
