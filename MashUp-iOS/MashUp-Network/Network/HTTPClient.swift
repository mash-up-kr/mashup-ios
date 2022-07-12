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
            
            if responseModel.isSuccess {
                return .success(responseModel.data)
            } else {
                let mashUpError = MashUpError(code: responseModel.code, message: responseModel.message)
                if let internalError = mashUpError.asInternalError() {
                    switch internalError {
                    case .unauthorized:
                        #warning("토큰 업데이트 구현 - booung")
                        Logger.log(mashUpError.message, .error)
                        #warning("재요청 구현 - booung")
                        return .failure(.undefined(mashUpError.message))
                    default:
                        Logger.log(mashUpError.message, .error)
                        return .failure(.undefined(mashUpError.message))
                    }
                } else {
                    return .failure(.undefined(String.empty))
                }
            }
        } catch {
            let networkError = self.prehandleError(error)
            return .failure(networkError)
        }
    }
    
    public func request<API: MashUpAPI>(_ api: API) -> Observable<Result<API.Response, NetworkError>> {
        return AsyncStream { await self.request(api) }.asObservable()
    }
    
    private func prehandleError(_ error: Error) -> NetworkError {
        Logger.log(error.localizedDescription, .error)
        
        switch error {
        case let error as AFError where error.isExplicitlyCancelledError:
            return .cancelled
        default:
            return .undefined(error)
        }
    }
    
    private let provider = MoyaProvider<MultiTarget>()
    private let decoder = JSONDecoder()
    
}
