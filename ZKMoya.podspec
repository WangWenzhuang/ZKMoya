Pod::Spec.new do |s|
  s.name = 'ZKMoya'
  s.version = '1.0'
  s.ios.deployment_target = '8.0'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.summary = '包含 HUD 的网络请求框架，Moya 二次封装'
  s.homepage = 'https://github.com/WangWenzhuang/ZKMoya'
  s.authors = { 'WangWenzhuang' => '1020304029@qq.com' }
  s.source = { :git => 'https://github.com/WangWenzhuang/ZKMoya.git', :tag => s.version }
  s.description = '将 Moya、ZKProgressHUD、SwiftyJSON 封装，简化网络请求代码。'
  s.source_files = 'ZKMoya/**/*.swift'
  s.requires_arc = true
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }
  s.dependency 'Moya'
  s.dependency 'SwiftyJSON'
  s.dependency 'ZKProgressHUD'
end