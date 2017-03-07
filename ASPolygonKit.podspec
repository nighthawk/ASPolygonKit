
Pod::Spec.new do |s|
  s.name             = 'ASPolygonKit'
  s.version          = '0.1.4'
  s.summary          = 'A little Swift toolkit for working with polygons'

  s.description      = <<-DESC
  A small collection of classes, primarily used for handling creating a union of polygons. The resulting polygons are compatible with MapKit. Be warned, it doesn't work for all kinds of polygons.
                       DESC

  s.homepage         = 'https://github.com/nighthawk/ASPolygonKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'nighthawk' => 'adrian.schoenig@gmail.com' }
  s.source           = { :git => 'https://github.com/nighthawk/ASPolygonKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/nhawk'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.11'

  s.source_files = 'ASPolygonKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ASPolygonKit' => ['ASPolygonKit/Assets/*.png']
  # }

  s.frameworks = 'MapKit'
end
