Pod::Spec.new do |s|
  s.name         = "KJLoadingAnimationTool"
  s.version      = "1.0.0"
  s.summary      = "Loading Animation ."
  s.homepage     = "https://github.com/yangKJ/KJLoadingDemo"
  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.license      = "Copyright (c) 2019 77"
  s.author       = { "77" => "393103982@qq.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/yangKJ/KJLoadingDemo.git", :tag => "#{s.version}" }
  s.social_media_url = 'https://www.jianshu.com/u/c84c00476ab6'
  s.requires_arc = true
  
  s.subspec 'KJLoadingAnimationTool' do |ss|
    ss.source_files = "KJLoadingDemo/KJLoadingAnimationTool/**/*.{h,m}" # 添加文件
    ss.public_header_files = "KJLoadingDemo/KJLoadingAnimationTool/**/*.h",'KJLoadingDemo/KJLoadingAnimationTool/*.h'# 添加头文件
  end
  
  s.frameworks = 'Foundation','UIKit'
  
end


