//
//  MoyaProvider.swift
//  ZKMoya
//
//  Created by 王文壮 on 2018/6/13.
//  Copyright © 2018 王文壮. All rights reserved.
//

import Moya
import Async
import SwiftyJSON
import ZKProgressHUD

public enum ZKCheckStatus {
    case success
    case failure
    case doNothing
}

public extension MoyaProvider {
    typealias requestSuccess = (_ json: JSON) -> Void
    typealias requestFailure = () -> Void
    
    private func request(
        _ token: Target,
        success: requestSuccess? = nil,
        failure: requestFailure? = nil,
        isShowHUD: Bool = false
    ) {
        if isShowHUD {
            ZKProgressHUD.show()
        }
        self.request(token) { result in
            if isShowHUD {
                ZKProgressHUD.dismiss()
            }
            var isFailure = false
            switch result {
            case let .success(response):
                var isSuccess = false
                if let block = ZKMoya.responseCheck {
                    switch block(response) {
                    case .success:
                        isSuccess = true
                    case .failure:
                        isFailure = true
                    case .doNothing:
                        if isShowHUD {
                            return
                        } else {
                            isFailure = true
                        }
                    }
                } else {
                    isSuccess = true
                }
                if isSuccess, let block = success {
                    block(JSON(response.data))
                }
            case let .failure(error):
                print("ZKMoya error  ->  \(error)")
                isFailure = true
            }
            if isFailure {
                if isShowHUD {
                    ZKMoya.showFailure()
                }
                if let block = failure {
                    block()
                }
            }
        }
    }
    
    /// 网络请求
    func ZKRequest(
        _ token: Target,
        success: requestSuccess? = nil,
        failure: requestFailure? = nil
    ) {
        self.request(token, success: success, failure: failure, isShowHUD: false)
    }
    
    /// 网络请求并且显示 HUD
    func ZKRequestHUD(
        _ token: Target,
        success: requestSuccess? = nil,
        failure: requestFailure? = nil
    ) {
        self.request(token, success: success, failure: failure, isShowHUD: true)
    }
}

public extension MoyaProvider {
    private func simulate(
        _ token: Target,
        success: requestSuccess? = nil,
        failure: requestFailure? = nil,
        isShowHUD: Bool = false
    ) {
        guard let block = success else {
            return
        }
        if isShowHUD {
            ZKProgressHUD.show()
            Async.main(after: 0.5) {
                ZKProgressHUD.dismiss()
                block(JSON(token.sampleData))
            }
        } else {
            block(JSON(token.sampleData))
        }
    }
    
    /// 模拟网络请求
    func ZKSimulate(
        _ token: Target,
        success: requestSuccess? = nil,
        failure: requestFailure? = nil
    ) {
        simulate(token, success: success, failure: failure, isShowHUD: false)
    }
    
    /// 模拟网络请求并且显示 HUD
    func ZKSimulateHUD(
        _ token: Target,
        success: requestSuccess? = nil,
        failure: requestFailure? = nil
    ) {
        simulate(token, success: success, failure: failure, isShowHUD: true)
    }
}
