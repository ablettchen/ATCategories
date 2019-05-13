#
# Be sure to run `pod lib lint ATCategories.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ATCategories'
  s.version          = '0.1.9'
  s.summary          = 'Category 类型工具库'
  s.homepage         = 'https://github.com/ablettchen/ATCategories'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ablettchen' => 'ablettchen@gmail.com' }
  s.source           = { :git => 'https://github.com/ablettchen/ATCategories.git', :tag => s.version.to_s }
  s.social_media_url = 'https://weibo.com/ablettx'
  
  s.platform                = :ios, '8.0'
  s.ios.deployment_target   = '8.0'
  s.requires_arc            = true
  
  s.source_files = 'ATCategories/**/*.{h,m}'
  s.public_header_files = 'ATCategories/**/*.{h}'
  
  s.libraries = 'z'
  s.frameworks = 'UIKit', 'CoreFoundation' ,'QuartzCore', 'CoreGraphics', 'CoreImage', 'CoreText', 'ImageIO', 'Accelerate'
end
