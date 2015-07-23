#
# Be sure to run `pod lib lint MessageDropdown.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "MessageDropdown"
  s.version          = "0.1.0"
  s.summary          = "MessageDropdown is a lightweight Swift simple and beautiful dropdown message"
  s.description      = <<-DESC
                       MessageDropdown is a lightweight Swift simple and beautiful dropdown message. It's
                       support 5 message types: Default, Info, Success, Warning, Danger
                       DESC
  s.homepage         = "https://github.com/phanviet/MessageDropdown"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Viet Phan" => "vietphxfce@gmail.com" }
  s.source           = { :git => "https://github.com/phanviet/MessageDropdown.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'MessageDropdown' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
