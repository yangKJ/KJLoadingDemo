Pod::Spec.new do |s|
  s.name         = "KJLoading"
  s.version      = "1.2.5"
  s.summary      = "Loading Animation."
  s.homepage     = "https://github.com/yangKJ/KJLoadingDemo"
  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.license      = "Copyright (c) 2019 77"
  s.author       = { "77" => "393103982@qq.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/yangKJ/KJLoadingDemo.git", :tag => "#{s.version}" }
  s.social_media_url = 'https://www.jianshu.com/u/c84c00476ab6'
  s.requires_arc = true

  s.default_subspec  = 'KJLoading'
  s.ios.source_files = "KJLoadingDemo/KJLoading/*.{h,m}"
  
  s.subspec 'Loadings' do |ss|
    ss.source_files = "KJLoadingDemo/LoadAnimations/*.{h,m}"
    ss.resources = "KJLoadingDemo/LoadAnimations/*.{bundle}"
  end

  s.subspec 'KJProgressHUD' do |a|
    a.source_files = "KJLoadingDemo/KJProgressHUD/**/*.{h,m}"
    a.dependency 'KJLoading/KJLoading'
  end
  
  s.frameworks = 'Foundation','UIKit','CoreText'
  
end


