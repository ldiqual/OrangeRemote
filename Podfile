source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '11.0'
use_frameworks!
inhibit_all_warnings!

# Disable sending stats (takes too much time)
ENV['COCOAPODS_DISABLE_STATS'] = 'true'

target 'OrangeRemote'
pod 'Alamofire', '4.7.3'
pod 'PromiseKit/CorePromise', '6.5.3'

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            
            # Disable code signing for all Pods to avoid error at packaging time
            config.build_settings['PROVISIONING_PROFILE_SPECIFIER'] = ''
            
            # Enable Whole Module Optimization for all configurations to speed up build times
            config.build_settings['SWIFT_WHOLE_MODULE_OPTIMIZATION'] = 'YES'
            
            # Build all archs otherwise Pods for extensions won't build properly in debug mode
            config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
        end
    end
end
