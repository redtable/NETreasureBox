#
# Be sure to run `pod lib lint NETreasureBox.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NETreasureBox'
  s.version          = '0.0.1'
  s.summary          = 'A short description of NETreasureBox.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/redtable/NETreasureBox'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'redtable' => 'wangsen8@xdf.cn' }
  s.source           = { :git => 'https://github.com/redtable/NETreasureBox.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'NETreasureBox/Classes/**/*'
  s.source_files = ['NETreasureBox/Classes/**/**/**/*.{h,m,mm}', 'NETreasureBox/Classes/**/**/*.{h,m,mm}', 'NETreasureBox/Classes/**/*.{h,m,mm}', 'NETreasureBox/Classes/*.{h,m,mm}']
  s.resource_bundles = {
    'NETreasureBox' => ['NETreasureBox/Assets/**/*.xcassets','NETreasureBox/Assets/**/*.json']
  }

  s.public_header_files = 'Pod/Classes/**/**/**/*.h'
  s.prefix_header_file = 'NETreasureBox/Classes/Micro/PrefixHeader.pch'
  # s.resource_bundles = {
  #   'NETreasureBox' => ['NETreasureBox/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AFNetworking'
  s.dependency 'Masonry'
  s.dependency 'YYModel'
  s.dependency 'YYCategories'
  s.dependency 'SDWebImage'
  
end
