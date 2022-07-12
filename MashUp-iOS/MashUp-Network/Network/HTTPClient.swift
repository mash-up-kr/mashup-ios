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
        do {
            let result = try await self._request(api)
            return .success(result)
        } catch let error as MashUpError where error.asInternalError() == .unauthorized {
            guard error.asInternalError() == .unauthorized else { return .failure(.mashUpError(error)) }
            await self.updateAccessToken()
            guard let result = try? await self._request(api) else { return .failure(.mashUpError(error)) }
            return .success(result)
        } catch {
            return .failure(.undefined(error))
        }
    }
    
    public func request<API: MashUpAPI>(_ api: API) -> Observable<Result<API.Response, NetworkError>> {
        return AsyncStream { await self.request(api) }.asObservable()
    }
    
    private func _request<API: MashUpAPI>(_ api: API) async throws -> API.Response {
        let erasedAPI = MultiTarget(api)
        let response = try await self.provider.rx.request(erasedAPI).value
        let responseModel = try decoder.decode(ResponseModel<API.Response>.self, from: response.data)
        
        guard responseModel.isSuccess else {
            throw MashUpError(code: responseModel.code, message: responseModel.message)
        }
        
        return responseModel.data
    }
    
    private func updateAccessToken() async {
        #warning("토큰 업데이트 구현 - booung")
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
