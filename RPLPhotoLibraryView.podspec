#
# Be sure to run `pod lib lint RPLPhotoLibraryView.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "RPLPhotoLibraryView"
  s.version          = "0.1.2"
  s.summary          = "RPLPhotoLibraryView provides a UIView subclass that can shows the user's photos from their gallery in a collection view."
#  s.description      = <<-DESC
#                      An optional longer description of RPLPhotoLibraryView
#
#                      * Markdown format.
#                      * Don't worry about the indent, we strip it!
#                      DESC
  s.homepage         = "https://github.com/Resplendent/RPLPhotoLibraryView"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "BenMaer" => "ben@resplendent.co" }
  s.source           = { :git => "https://github.com/Resplendent/RPLPhotoLibraryView.git", :tag => "v#{s.version}" }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'RPLPhotoLibraryView' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit', 'AssetsLibrary'
  s.dependency 'ResplendentUtilities', '~> 0.2'
end
