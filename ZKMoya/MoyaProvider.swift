//
//  MoyaProvider.swift
//  ZKMoya
//
//  Created by 王文壮 on 2018/6/13.
//  Copyright © 2018 王文壮. All rights reserved.
//

import Moya
import SwiftyJSON
import ZKProgressHUD

public extension MoyaProvider {
    public typealias requestSuccess = (_ json: JSON) -> Void
    public typealias requestFailure = () -> Void

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
                if let block = ZKMoyaConfig.responseCheck {
                    isFailure = !block(response)
                }
                if !isFailure {
                    if let block = success {
                        block(JSON(response.data))
                    }
                }
            case let .failure(error):
                print("ZKMoya error  ->  \(error)")
                isFailure = true
            }
            if isFailure {
                if isShowHUD {
                    ZKProgressHUD.showError(ZKMoyaConfig.requestFailureMsg)
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
