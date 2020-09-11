# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

source 'https://github.com/CocoaPods/Specs.git'



# https://firebase.google.com/docs/ios/setup#available-pods

target 'OneSignalNotificationServiceExtension' do
  use_frameworks!
  pod 'OneSignal', '>= 2.11.2', '< 3.0'
end


target 'MOPHMa3an' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Functions'
  pod 'Firebase/Storage'
  pod 'Firebase/Auth'
  pod 'Firebase/RemoteConfig'
  pod 'FirebaseUI/Phone', '~> 8.0'
  pod 'lottie-ios'
  pod 'SwiftLint'
  pod 'UINavigationItem+Margin'
  pod 'Alamofire', '~> 5.2'
  pod 'OneSignal', '>= 2.11.2', '< 3.0'
end
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['APPLICATION_EXTENSION_API_ONLY'] = 'NO'
    end
  end
end
