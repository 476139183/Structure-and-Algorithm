Pod::Spec.new do |s|

  s.name         = "YTToolPortal"
  s.version      = "1.0.1"
  s.summary      = "YTToolPortal 工具"
  s.description      = "test description"

  s.license      = { type: 'MIT', file: 'LICENSE' }
  s.homepage     = "https://476139183.github.io" 
  s.author       = { "duanyutian" => "476139183@qq.com" }

  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/476139183/YTToolPortal.git", :tag => s.version } 

  s.source_files  = "YTToolPortal/YTToolPortal/*"
  #s.prefix_header_contents = '#import "YTToolPortal.h"'
  s.requires_arc = true
  
  s.subspec 'YTCategoryTool' do |dd|
    dd.source_files  = "YTToolPortal/YTToolPortal/YTCategoryTool/*"
  end



end