
Pod::Spec.new do |s|
  s.name             = 'SwiftBrick'
  s.version          = '1.5.1'
  s.summary          = '工具类组件.'
 
  s.description      = <<-DESC
							工具.
                       DESC

  s.homepage         = 'https://github.com/jackiehu/' 
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'HU' => '814030966@qq.com' }
  s.source           = { :git => 'https://github.com/jackiehu/SwiftBrick.git', :tag => s.version.to_s }

  s.ios.deployment_target = "11.0" 
  s.swift_versions     = ['5.0','5.1','5.2']
  s.requires_arc = true

  s.frameworks   = "UIKit", "Foundation" #支持的框架
  s.dependency 'SnapKit'
  

   s.resource_bundles = {
     'SwiftBrick' => ['Sources/SwiftBrick/Resources/*.xcassets']
  }

    s.subspec 'Util' do |ss| 
      ss.source_files = 'Sources/SwiftBrick/Util/**/*'
    end

    s.subspec 'Extensions' do |ss| 
      ss.dependency 'SwiftBrick/Util'
      ss.source_files = 'Sources/SwiftBrick/Extensions/**/*'
    end
    s.subspec 'BaseCell' do |ss| 
      ss.dependency 'SwiftBrick/Extensions'
      ss.source_files = 'Sources/SwiftBrick/BaseCell/**/*'
    end
    s.subspec 'BaseVC' do |ss| 
      ss.dependency 'SwiftBrick/Util'
      ss.dependency 'SwiftBrick/BaseCell'
      ss.dependency 'SwiftBrick/Extensions'
      ss.source_files = 'Sources/SwiftBrick/BaseVC/**/*'
    end
   
    s.subspec 'ViewFactory' do |ss|
      ss.dependency 'SwiftBrick/Util'
      ss.dependency 'SwiftBrick/Extensions'
      ss.source_files = 'Sources/SwiftBrick/ViewFactory/**/*'
    end

end
