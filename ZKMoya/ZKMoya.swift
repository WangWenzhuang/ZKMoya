//
//  ZKMoyaConfig.swift
//  ZKMoya
//
//  Created by 王文壮 on 2018/6/13.
//  Copyright © 2018 王文壮. All rights reserved.
//

import Moya
import ZKProgressHUD

public final class ZKMoya {
    /// HUD 请求失败，会显示此消息。默认为：连接服务器失败，请稍后再试
    public static var failureMsg = "连接服务器失败，请稍后再试"
    /// HUD 请求失败，会执行此方法
    public static let showFailure = {
        ZKProgressHUD.showError(failureMsg)
    }
    /// 验证
    public static var responseCheck: ((_ response: Response) -> ZKCheckStatus)?
}
