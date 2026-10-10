platform :ios, '15.0'

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
      # Xcode 27 requires iOS 15+. Old podspecs still declare 8.0/9.0/13.0.
      current = Gem::Version.new(config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_s) rescue nil
      if current.nil? || current < Gem::Version.new('15.0')
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      end

      xcconfig_path = config.base_configuration_reference.real_path
      xcconfig = File.read(xcconfig_path)
      xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
      File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
    end
  end
end
