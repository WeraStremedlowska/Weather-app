# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Weather-app' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'SkeletonView'
  pod 'Alamofire'
  pod 'Loaf'
  pod 'SBTUITestTunnelServer'
  pod 'GCDWebServer', :inhibit_warnings => true

  target 'Weather-appTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Weather-appUITests' do
    pod 'SBTUITestTunnelClient'
  end

end
