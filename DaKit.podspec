#
# Be sure to run `pod lib lint DaKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DaKit'
  s.version          = '0.1.3'
  s.summary          = 'davidlii\'s Kit for iOS developing~'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                       Kit to simplify your developing process, I will continuously update this Kit.
                       DESC

  s.homepage         = 'https://github.com/davidli-/DaKit'
  s.screenshots      = 'https://davidlii.nos-eastchina1.126.net/pic_DaKit.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'davidlii' => 'macmafia@sina.cn' }
  s.source           = { :git => 'https://github.com/davidli-/DaKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://davidlii.cn'

  s.ios.deployment_target = '8.0'

  s.source_files = 'DaKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'DaKit' => ['DaKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
