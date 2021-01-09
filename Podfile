platform :ios, '13.0'

# ignore all warnings from all pods
inhibit_all_warnings!

target 'Clendar' do
  use_frameworks!

  # Core
  pod 'SwiftyChrono'
  pod 'SwiftLint'
  pod 'R.swift'
  pod 'LicensePlist' # Installation path: `${PODS_ROOT}/LicensePlist/license-plist`
  pod 'SwiftFormat/CLI'

  target 'ClendarTests' do
    inherit! :search_paths
  end

  target 'ClendarUITests' do
    inherit! :search_paths
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end
