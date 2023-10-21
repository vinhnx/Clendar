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
  pod 'TPInAppReceipt'

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

      xcconfig_path = config.base_configuration_reference.real_path
      xcconfig = File.read(xcconfig_path)
      xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
      File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
    end
  end
end
