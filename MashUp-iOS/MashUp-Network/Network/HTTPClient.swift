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
    
    #warning("DI된 후 싱글턴 제거 되어야합니다 - booung")
    public init(tokenStorage: (any AuthorizationStorage)? = nil) {
        self.authorizationStorage = tokenStorage ?? AuthorizationStorageImp.shared
        
        let authorizationHeaderFieldsResolver: (MultiTarget) -> Endpoint = { [authorizationStorage] target in
            var headerFields = target.headers
            if let accessToken = authorizationStorage.fetchAccessToken() {
                headerFields?["Authorization"] = accessToken
            }
            return Endpoint(
                url: URL(target: target).absoluteString,
                sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                method: target.method,
                task: target.task,
                httpHeaderFields: headerFields
            )
        }
        
        self.provider = MoyaProvider<MultiTarget>(endpointClosure: authorizationHeaderFieldsResolver)
    }
    
    public func request<API: MashUpAPI>(_ api: API) async -> Result<API.Response, NetworkError> {
        do {
            let result = try await self._request(api)
            return .success(result)
        } catch let error as MashUpError {
            guard self.needToUpdateToken(whenOccurs: error) else {
                return .failure(.mashUpError(error))
            }
            await self.updateAccessToken()
            guard let retryResult = try? await self._request(api) else {
                self.clearAccessToken()
                return .failure(.mashUpError(error))
            }
            return .success(retryResult)
        } catch {
            return .failure(.undefined(error))
        }
    }
    
    @discardableResult
    private func _request<API: MashUpAPI>(_ api: API) async throws -> API.Response {
        let erasedAPI = MultiTarget(api)
        let response = try await self.provider.rx.request(erasedAPI).value
        
        let responseModel = try decoder.decode(ResponseModel<API.Response>.self, from: response.data)
        
        guard responseModel.isSuccess else {
            throw MashUpError(code: responseModel.code, message: responseModel.message)
        }
        guard let data = responseModel.data else {
            throw NetworkError.undefined("bad response")
        }
        
        if let authorization = responseModel.data as? Authorization {
            self.authorizationStorage.saveAccessToken(authorization.accessToken)
            Logger.log("✅ 토큰 업데이트 성공: \(authorization.accessToken)")
        }
        
        return data
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
    
    private func needToUpdateToken(whenOccurs error: MashUpError) -> Bool {
        return error.asInternalError() == .unauthorized
    }
    
    private func updateAccessToken() async {
        do {
            let authenticationAPI = AuthenticationAPI()
            try await self._request(authenticationAPI)
        } catch {
            Logger.log("❌ 토큰 업데이트 실패: \(error.localizedDescription)")
        }
    }
    
    private func clearAccessToken() {
        self.authorizationStorage.deleteAccessToken()
    }
    
    private let provider: MoyaProvider<MultiTarget>
    private let decoder = JSONDecoder()
    private var authorizationStorage: any AuthorizationStorage
}
