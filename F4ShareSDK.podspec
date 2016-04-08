
Pod::Spec.new do |s|
  s.name         = "F4ShareSDK"
  s.version      = "1.0.2"
  s.summary      = "ShareSDK"
  s.homepage     = "http://www.baidu.com"
  s.license      = "MIT"
  s.author       = { "Pen" => "pengjunhua2005@21cn.com" }

  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/rainyboyer/F4Share.git", :tag => "1.0.2" }
                                     
  s.source_files  =  "F4ShareSDK/**/*.{h,m}"
  #s.public_header_files = 'aaaLibrary/**/*.h'
  s.resource_bundles = {
    'TencentOpenApi_IOS_Bundle' => ['F4ShareSDK/**/*.bundle']
  }                                       

  s.resources = "F4ShareSDK/**/*.png"

  s.frameworks = "Foundation","UIKit","MapKit","QuartzCore","CoreText","ImageIO","Security","CoreTelephony","CoreGraphics","SystemConfiguration"
  s.libraries = "iconv", "z","stdc++","sqlite3"
  s.requires_arc = true
  #'WeiboSDK', '~> 3.0.1'
   s.dependency 'Weibo', '~> 2.4.2'
  #s.dependency 'TencentOpenApiSDK', '~> 2.9.0'
   s.dependency 'iOSWeChatSdk', '~> 1.5.0'
   s.dependency 'SVProgressHUD', '= 2.0'
   s.dependency 'AFNetworking', '= 3.0.4'

   s.ios.vendored_frameworks = 'F4ShareSDK/**/*.framework'
end
