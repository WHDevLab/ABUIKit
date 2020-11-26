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
	s.platform         = :ios, '9.0'
	s.frameworks       = 'Foundation', 'UIKit', 'CoreGraphics', 'Photos'
	s.source_files     = 'Core/*.{h,m}'
	s.dependency "Toast"
	s.subspec 'ABUIListView' do |ss|
		ss.source_files = 'Core/ABUIListView/*.{h,m,json}'
	end
	s.subspec 'ABExtension' do |ss|
		ss.source_files = 'Core/ABExtension/*.{h,m}'
	end
	s.subspec 'ABUIWebView' do |ss|
		ss.source_files = 'Core/ABUIWebView/*.{h,m, html}'
	end
	s.subspec 'ABUIButtons' do |ss|
		ss.source_files = 'Core/ABUIButtons/*.{h,m}'
	end
	s.subspec 'ABUILabels' do |ss|
		ss.source_files = 'Core/ABUILabels/*.{h,m}'
	end
	s.subspec 'ABUITextFields' do |ss|
		ss.source_files = 'Core/ABUITextFields/*.{h,m}'
	end
	s.subspec 'ABUIAnimateBanner' do |ss|
		ss.source_files = 'Core/ABUIAnimateBanner/*.{h,m}'
	end
	s.subspec 'ABUITabBar' do |ss|
		ss.source_files = 'Core/ABUITabBar/*.{h,m}'
	end
	s.subspec 'ABUINavBar' do |ss|
		ss.source_files = 'Core/ABUINavBar/*.{h,m}'
	end
	s.subspec 'ABUIListViewItems' do |ss|
		ss.source_files = 'Core/ABUIListViewItems/*.{h,m}'
	end
	s.subspec 'ABUIChatView' do |ss|
		ss.source_files = 'Core/ABUIChatView/*.{h,m}'
		ss.resource_bundles =  {
			'ABWXEmoji' => ['Core/ABUIChatView/Emoji.xcassets']
		}
	end
	s.subspec 'ABUISearchBar' do |ss|
		ss.source_files = 'Core/ABUISearchBar/*.{h,m}'
	end
end
