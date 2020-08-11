#
# Be sure to run `pod lib lint CocoapodKBDemo.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CocoapodKBDemo'
  s.version          = '0.1.0'
  s.summary          = 'kaba pod test'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
CocoapodKBDemo 是一个用于保存常用工具类的工具
                       DESC

  s.homepage         = 'https://github.com/HUANDU153666/KBDemo'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'HUANDU153666' => 'HUAN153666@163.com' }
  s.source           = { :git => 'https://github.com/HUANDU153666/CocoapodKBDemo.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'CocoapodKBDemo/Classes/**/*.{h,m,mm}'
  
  # 设置资源
  # s.resource_bundles = {
  #   'CocoapodKBDemo' => ['CocoapodKBDemo/Assets/*.png']
  # }

  # 设置全局引用 直接在.pch文件中引用
  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.requires_arc = true
  s.frameworks = 'UIKit', 'Foundation'
  s.dependency 'YTKNetwork'
  s.dependency 'MJExtension'
  s.dependency 'CTMediator'

end
