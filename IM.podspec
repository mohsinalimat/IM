#
# Be sure to run `pod lib lint IM.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "IM"
  s.version          = "1.0.0"
  s.summary          = "An iOS IM UI framework written in Swift."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                        IM is an iOS IM UI framework written in Swift.
                        DESC

  s.homepage         = "https://github.com/Meniny/IM"
  s.license          = 'MIT'
  s.author           = { "Meniny" => "Meniny@qq.com" }
  s.source           = { :git => "https://github.com/Meniny/IM.git", :tag => s.version.to_s }
  s.social_media_url = 'http://meniny.cn/'

  s.ios.deployment_target = '8.0'

  s.source_files = 'IM/**/*.{h,m,swift}'
  s.public_header_files = 'IM/**/*.{h}'
  s.resources = 'IM/**/*.{xib}', 'IM/**/*.{bundle}'
  # s.resource_bundles = {
  #   'IMMessagesAssets' => ['IM/**/*.{bundle}']
  # }
  s.frameworks = 'Foundation', 'UIKit', 'QuartzCore', 'CoreGraphics', 'CoreLocation', 'MapKit', 'MobileCoreServices', 'AVFoundation'
  s.dependency 'CocoaHelper'
  s.dependency 'SystemSounds'
  s.requires_arc = true
end
