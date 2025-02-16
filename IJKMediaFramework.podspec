Pod::Spec.new do |spec|

  spec.name         = "IJKMediaFramework"
  spec.version      = "0.0.3"
  spec.summary      = "IJKMediaFramework 说明."
  spec.description      = <<-DESC
  IJKMediaFramework long description of the pod here.
  DESC

  spec.homepage         = 'https://github.com/STTechnology5652/IJKMediaFramework.git'
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "defualt_author" => "defualt_email" }
  spec.ios.deployment_target = '9.0'

  # 添加这行来指定使用动态框架
  spec.static_framework = false

  spec.source       = { :git => "https://github.com/STTechnology5652/IJKMediaFramework.git", :tag => "#{spec.version}" }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#  spec.source_files = 'IJKMediaFramework/**/*'
  # spec.exclude_files = "IJKMediaFramework/Exclude" #排除文件

#  spec.project_header_files = ''
#  spec.public_header_files = 'IJKMediaFramework/Public/**/*.h'

  
  # ――― binary framework/lib ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.vendored_frameworks = 'IJKMediaFramework/Public/IJKMediaFramework.framework'
  #spec.vendored_libraries = 'IJKMediaFramework/Private/**/*.a'

  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  # 放置 json,font,jpg,png等资源
  #  spec.resources = ["IJKMediaFramework/{Public,Private}/**/*.{xib}"]
  #  spec.resource_bundles = {
  #    'IJKMediaFramework' => ['IJKMediaFramework/Assets/*.xcassets', "IJKMediaFramework/{Public,Private}/**/*.{png,jpg,font,json}"]
  #  }


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  # spec.framework  = "SomeFramework"
  spec.frameworks = "AVFoundation", "CoreGraphics", "CoreMedia", "CoreVideo", "MediaPlayer", "MobileCoreServices", "OpenGLES", "QuartzCore", "VideoToolbox", "AudioToolbox", "CoreAudio"
  spec.libraries = "bz2", "z", "stdc++"
  # spec.library   = "iconv"
  spec.libraries = "bz2", "z", "stdc++"


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
 set -x  # 启用详细日志输出
 
 rm -rf ./UnzipDir
 mkdir -pv ./UnzipDir
 
 rm -rf ./IJKMediaFramework/Public/IJKMediaFramework
 mkdir -p ./IJKMediaFramework/Public/IJKMediaFramework
 
 echo "Looking for zip file..."
 ls -l ./*.zip
 
 # 添加验证步骤
 if [ ! -f ./*.zip ]; then
    echo "Error: Framework zip file not found!"
    exit 1
 fi
 
 echo "Extracting framework..."
 tar -xzvf ./*.zip -C  ./UnzipDir/
 
 echo "Checking extracted contents..."
 ls -R ./UnzipDir/
 
 # 验证解压是否成功
 if [ ! -d ./UnzipDir/*.framework ]; then
    echo "Error: Framework not found in unzipped contents!"
    exit 1
 fi
 
 
 # 确保 Headers 目录存在
 if [ ! -d ./UnzipDir/*.framework/Headers ]; then
    echo "Error: Headers directory not found in framework!"
    exit 1
 fi
 
 echo "Moving framework..."
 mv -v ./UnzipDir/* ./IJKMediaFramework/Public/
 
 echo "Verifying file structure..."
 ls -R ./IJKMediaFramework/Public/
 
 # 验证文件是否正确复制
 if [ ! -f ./IJKMediaFramework/Public/IJKMediaFramework.framework/Headers/IJKAVMoviePlayerController.h ]; then
    echo "Error: IJKAVMoviePlayerController.h not found in public headers!"
    exit 1
 fi
 
 rm -rf ./UnzipDir
 
 echo "Setup completed successfully"
CMD

end
