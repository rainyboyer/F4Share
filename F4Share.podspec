Pod::Spec.new do |s|
  s.name             = "F4Share"
  s.version          = "1.0.0"
  s.summary          = "A marquee view used on iOS."
  s.description      = <<-DESC
                       It is a marquee view used on iOS, which implement by Objective-C.
                       DESC
  s.license          = 'MIT'
  s.author           = 'FlinkInfo'
  s.source           = { :git => "https://github.com/rainyboyer/F4Share.git", :tag => s.version.to_s }
  s.platform     = :ios, '4.3'
  s.requires_arc = true
  s.libraries = 'z','stdc++','sqlite3','iconv'
  s.source_files = 'haha/*'
  s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit','QuartzCore','CoreText',
		 'ImageIO','Security','CoreTelephony',
                 'SystemConfiguration'
end
