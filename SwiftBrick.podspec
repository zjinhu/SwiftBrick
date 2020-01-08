
Pod::Spec.new do |s|
  s.name             = 'SwiftBrick'
  s.version          = '0.0.7'
  s.summary          = '工具类组件.'
 
  s.description      = <<-DESC
							工具.
                       DESC

  s.homepage         = 'https://github.com/jackiehu/' 
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'HU' => '814030966@qq.com' }
  s.source           = { :git => 'https://github.com/jackiehu/SwiftBrick.git', :tag => s.version.to_s }

  s.ios.deployment_target = "11.0" 
  s.swift_version     = '5.1'
  s.requires_arc = true

  s.frameworks   = "UIKit", "Foundation" #支持的框架

  

   s.resource_bundles = {
     'SwiftBrick' => ['SwiftBrick/Class/*.xcassets']
  }

    s.subspec 'Extensions' do |ss|
      ss.source_files = 'SwiftBrick/Class/Extensions/**/*' 
    end
    s.subspec 'Utility' do |ss| 
      ss.source_files = 'SwiftBrick/Class/Utility/**/*' 
    end
    s.subspec 'BaseVC' do |ss|
      ss.dependency 'SnapKit'
      ss.dependency 'SwiftBrick/Utility'
      ss.source_files = 'SwiftBrick/Class/BaseVC/**/*' 
    end
   
  	s.subspec 'SnapKit' do |ss|
      ss.dependency 'SnapKit'
		  ss.source_files = 'SwiftBrick/Class/SnapKit/**/*' 
    end

end
