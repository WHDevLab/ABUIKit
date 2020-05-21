Pod::Spec.new do |s|
	s.name             = "ABUIKit"
	s.version          = "0.0.1"
	s.summary          = "致力于提高项目 UI 开发效率的解决方案"
	s.description      = <<-DESC
							ABUIKit iOS 是一个致力于提高项目 UI 开发效率的解决方案
							DESC
	s.homepage         = "https://github.com/whdevlab/ABUIKit"
	s.license          = 'MIT'
	s.author           = {"whdevlab" => "whdevlab@163.com"}
	s.source           = {:git => "https://github.com/whdevlab/ABUIKit.git", :tag => s.version.to_s}
	s.social_media_url = 'https://github.com/whdevlab/ABUIKit'
	s.requires_arc     = true
	s.platform         = :ios, '10.0'
	s.frameworks       = 'Foundation', 'UIKit', 'CoreGraphics', 'Photos'
	s.source_files     = 'Core/*.{h,m}'
	s.subspec 'ABUIListView' do |ss|
		ss.source_files = 'Core/ABUIListView/*.{h,m}'
	end
	s.subspec 'ABExtension' do |ss|
		ss.source_files = 'Core/ABExtension/*.{h,m}'
	end
end