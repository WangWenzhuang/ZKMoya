![(logo)](https://raw.githubusercontent.com/WangWenzhuang/ZKAlamofire/master/images/logo.png)

# ZKMoya

![license](https://img.shields.io/badge/license-MIT-brightgreen.svg)
![CocoaPods](https://img.shields.io/badge/pod-v5.0.1-brightgreen.svg)
![platform](https://img.shields.io/badge/platform-iOS-brightgreen.svg)

将 [Moya](https://github.com/Moya/Moya)、[ZKProgressHUD](https://github.com/WangWenzhuang/ZKProgressHUD)、[SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) 封装，简化网络请求代码

Moya 请求代码

```swift
ZKProgressHUD.show()
myApi.request(.list) { result in
    ZKProgressHUD.dismiss()
    switch result {
    case let .success(response):
        let list = JSON(response.data).arrayValue
        /// ....
    case .failure:
        /// ....
    }
}
```

使用 ZKMoya 请求代码
```swift
myApi.ZKRequestHUD(.list, success: { json in
	let list = json.arrayValue
    /// ....
})
```

上面代码中的 *json* 是 JSON 类型，请查看 [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)

## 运行环境

* iOS 10.0 +
* Xcode 8 +
* Swift 5.0 +

## 安装

### CocoaPods

你可以使用 [CocoaPods](http://cocoapods.org/) 安装 `ZKMoya`，在你的 `Podfile` 中添加：

```ogdl
platform :ios, '10.0'
use_frameworks!

target 'MyApp' do
    pod 'ZKMoya'
end
```

## 快速使用

### 导入 `ZKMoya`

```swift
import ZKMoya
```

### 设置请求错误消息，当使用 HUD 方式请求出错时会显示此消息

```swift
/// 如果不设置，默认值是："连接服务器失败，请稍后再试"
ZKMoya.failureMsg = "请求出错，请稍后再试"

/// 如果不设置，默认值是：ZKProgressHUD.showError(failureMsg)
ZKMoya.showFailure = {
    // 自定义请求失败
}
```

### 显示 HUD 请求

```swift
myApi.ZKRequestHUD(.list, success: { json in
	/// 你的代码
})
```

### 不显示 HUD 请求

```swift
myApi.ZKRequest(.list, success: { json in
	/// 你的代码
})
```

### 错误处理

ZKRequestHUD、ZKRequest 请求时添加 *failure* 参数，这是一个可选参数

```swift
myApi.ZKRequest(.list, success: { json in
	/// 你的代码
}, failure: {
	/// 你的代码
})
```

### 自定义 HUD 样式

自定义需要添加 [ZKProgressHUD](https://github.com/WangWenzhuang/ZKProgressHUD) ，之后设置其样式即可

### 接口未完成的情况下，可以使用 ZKSimulate 和 ZKSimulateHUD 进行接口模拟

在 sampleData 中根据接口返回对应的 JSON 数据 

```swift
var sampleData: Data {
    switch self {
    case .list:
        return "{\"message\":\"\",\"error_code\":0,\"data\":[{\"id\":1,\"title\":\"哼哼哈嘿\"}]}".data(using: String.Encoding.utf8)!
    }
}
```

使用

```swift
myApi.ZKSimulateHUD(.list, success: { json in
	/// 你的代码
})
```