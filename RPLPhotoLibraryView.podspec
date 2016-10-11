#
# Be sure to run `pod lib lint RPLPhotoLibraryView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RPLPhotoLibraryView'
  s.version          = '0.1.3'
  s.summary          = "RPLPhotoLibraryView provides a UIView subclass that can shows the user's photos from their gallery in a collection view."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Provides `RPLPhotoLibraryView`, a class which shows the users gallery images in a collection view with 3 columns, and scrolls vertically.

Can flip the order with property `reverseAssetOrder`, and can be told to scroll to the top of the colleciton view.

Offers two delegates:
* `assetSelectionDelegate` - for handling when the user selects an asset.
* `scrollDelegate` - offers a few methods for handling scrolling events.
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Resplendent/RPLPhotoLibraryView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Benjamin Maer' => 'ben@resplendent.co' }
  s.source           = { :git => 'https://github.com/Resplendent/RPLPhotoLibraryView.git', :tag => "v#{s.version}" }

  s.ios.deployment_target = '7.0'

  s.source_files = 'RPLPhotoLibraryView/Classes/**/*'
  
  s.dependency 'ResplendentUtilities', '~> 0.4.0'
end
