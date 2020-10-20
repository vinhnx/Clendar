platform :ios, '11.0'

# ignore all warnings from all pods
inhibit_all_warnings!

target 'Clendar' do
  use_frameworks!

  # Core
  pod 'SwiftyChrono'
  pod 'SwiftDate', '~> 5.0'
  
  # Helper
  pod 'SwiftLint'
  pod 'R.swift'

  # View
  pod 'CVCalendar', '~> 1.7.0'
  pod 'PanModal'

  target 'ClendarTests' do
    inherit! :search_paths
  end

  target 'ClendarUITests' do
    inherit! :search_paths
  end
end
