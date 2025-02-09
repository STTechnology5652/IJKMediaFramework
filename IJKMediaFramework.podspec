Pod::Spec.new do |spec|

  spec.name         = "IJKMediaFramework"
  spec.version      = "0.0.1"
  spec.summary      = "IJKMediaFramework 说明."
  spec.description      = <<-DESC
  IJKMediaFramework long description of the pod here.
  DESC

  spec.homepage         = 'https://github.com/STTechnology5652/IJKMediaFramework.git'
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "defualt_author" => "defualt_email" }
  spec.ios.deployment_target = '9.0'

  spec.source       = { :git => "https://github.com/STTechnology5652/IJKMediaFramework.git", :tag => "#{spec.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source_files = 'IJKMediaFramework/{Public,Private}/**/*.{h,m,mm,c,cpp,swift}'
  # spec.exclude_files = "IJKMediaFramework/Exclude" #排除文件

  spec.project_header_files = 'IJKMediaFramework/Private/**/*.{h}'
  spec.public_header_files = 'IJKMediaFramework/Public/**/*.h' #此处放置组件的对外暴漏的头文件

  # ――― binary framework/lib ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.vendored_frameworks = 'IJKMediaFramework/Private/**/*.framework'
  #spec.vendored_libraries = 'IJKMediaFramework/Private/**/*.a'

  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  # 放置 json,font,jpg,png等资源
  #  spec.resources = ["IJKMediaFramework/{Public,Private}/**/*.{xib}"]
  #  spec.resource_bundles = {
  #    'IJKMediaFramework' => ['IJKMediaFramework/Assets/*.xcassets', "IJKMediaFramework/{Public,Private}/**/*.{png,jpg,font,json}"]
  #  }


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  # spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"
  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  # spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }

  # 其他依赖pod
  # spec.dependency "XXXXXXXX"

#   spec.subspec 'WithLoad' do |ss|
#       ss.source_files = 'YKHawkeye/Src/MethodUseTime/**/*{.h,.m}'
#       ss.pod_target_xcconfig = {
#         'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) YKHawkeyeWithLoad'
#       }
#       ss.dependency 'YKHawkeye/Core'
#       ss.vendored_frameworks = 'YKHawkeye/Framework/*.framework'
#     end

spec.prepare_command  =  <<-CMD
 rm -rf ./UnzipDir
 mkdir -pv ./UnzipDir
 
 rm -rf ./IJKMediaFramework/Public/IJKMediaFramework
 mkdir ./IJKMediaFramework/Public/IJKMediaFramework
 
 tar -xzvf ./*.zip -C  ./UnzipDir/
 
 rm -rf ./IJKMediaFramework/Private/Vendor/*

 cp -r ./UnzipDir/*.framework/Headers/ ./IJKMediaFramework/Public/IJKMediaFramework/
 mv ./UnzipDir/* ./IJKMediaFramework/Private/Vendor/
 rm -rf ./UnzipDir

 CMD

end
