Pod::Spec.new do |spec|
	spec.name         = "ABUIKit"
	spec.version      = "0.0.1"
	spec.summary      = "A short description of ABUIKit."
	spec.platform     = :ios, "10.0"
	spec.ios.deployment_target = "10.0"
	spec.homepage     = "https://github.com/whdevlab/ABUIKit"
	spec.license      = 'MIT'
	spec.author             = { "whdevlab" => "whdevlab@163.com" }
	spec.source       = { :git => "https://github.com/whdevlab/ABUIKit.git", :tag => "#{spec.version}" }
	spec.source_files  = "ABUIKit/ABUIKit.h"
	spec.frameworks = 'UIKit', 'Foundation'
	# spec.dependency "AFNetworking" 
end