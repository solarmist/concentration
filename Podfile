# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

target 'CardGames' do
  # Pods for CardGames
  pod 'SwiftLint', '~> 0.41.0'
  pod 'SwiftGen', '~> 6.4.0'
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Work around for https://github.com/firebase/firebase-ios-sdk/issues/6533
  # from https://github.com/CocoaPods/CocoaPods/issues/9884#issuecomment-696228403
  post_install do |pi|
     t = pi.pods_project.targets.find { |t| t.name == 'MyPod' }
     t.build_configurations.each do |bc|
       bc.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
     end
  end
end
