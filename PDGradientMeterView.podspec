#
# Be sure to run `pod lib lint PDGradientMeterView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "PDGradientMeterView"
  s.version          = "0.1.0"
  s.summary          = "A simple iOS slider with a three colors gradient."

  s.description      = <<-DESC
A simple iOS slider with a three colour gradient.
The indicator is customizable with your custom view.
                       DESC

  s.homepage         = "https://github.com/PiDyGB/PDGradientMeterView"
  s.license          = 'Apache 2.0'
  s.author           = { "Giuseppe Buzzanca (PiDy)" => "giuseppebuzzanca@gmail.com" }
  s.source           = { :git => "https://github.com/PiDyGB/PDGradientMeterView.git", :tag => s.version.to_s }
  s.social_media_url = 'https://plus.google.com/u/0/+GiuseppeBuzzanca'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'PDGradientMeterView' => ['Pod/Assets/*.png']
  }
end
