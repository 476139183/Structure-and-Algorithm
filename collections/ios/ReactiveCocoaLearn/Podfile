
platform :ios, '9.0'
inhibit_all_warnings!

workspace 'RACLearning.xcworkspace'  #workspace文件名

pod 'ReactiveObjC'                                    # RAC


target :'RAC-第一课' do
  project 'RAC-第一章/RAC-第一课.xcodeproj'

end

target :'RAC-第二课' do
  project 'RAC-第二章/RAC-第二课.xcodeproj'

end

target :'RAC-第三课' do
  project 'RAC-第三章/RAC-第三课.xcodeproj'

end

target :'RAC-第四课' do
  project 'RAC-第四章/RAC-第四课.xcodeproj'

end



post_install do |installer|
  installer.pods_project.targets.each do |target|
    puts #{target.name}
  end
end




 #use_frameworks!


