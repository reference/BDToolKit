#
#  Be sure to run `pod spec lint BDToolKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "BDToolKit"
  s.version      = "1.0.0"
  s.summary      = "Usefull tool for objective-c develop."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = "A simple toolkit for ios dev"

  s.homepage     = "https://github.com/reference/BDToolKit"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See http://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  s.author             = { "Scott Ban" => "scottban@126.com" }
  # Or just: s.author    = "bandianhong"
  # s.authors            = { "bandianhong" => "scottban@126.com" }
  # s.social_media_url   = "http://twitter.com/bandianhong"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  s.platform     = :ios
  # s.platform     = :ios, "9.0"

  #  When using multiple platforms
  s.ios.deployment_target = "9.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  s.source       = { :git => "https://github.com/reference/BDToolKit.git", :tag => "#{s.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files  =  "BDToolKit.h"
  s.public_header_files = "BDToolKit.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

    s.subspec "BDViewController" do |ss|
        ss.source_files  = "UIKit/Controller/BDViewController/*.{h,m}"
        ss.public_header_files = "UIKit/Controller/BDViewController/*.h"
    end

    s.subspec "BDTableViewController" do |ss|
        ss.source_files  = "UIKit/Controller/BDTableViewController/*.{h,m}"
        ss.public_header_files = "UIKit/Controller/BDTableViewController/*.h"
    end

    s.subspec "BDCollectionViewController" do |ss|
        ss.source_files  = "UIKit/Controller/BDCollectionViewController/*.{h,m}"
        ss.public_header_files = "UIKit/Controller/BDCollectionViewController/*.h"
    end

    s.subspec "BDView" do |ss|
        ss.source_files  = "UIKit/View/BDView/*.{h,m}"
        ss.public_header_files = "UIKit/View/BDView/*.h"
    end

    s.subspec "BDTableViewCell" do |ss|
        ss.source_files  = "UIKit/View/BDTableViewCell/*.{h,m}"
        ss.public_header_files = "UIKit/View/BDTableViewCell/*.h"
    end

    s.subspec "BDCollectionViewCell" do |ss|
        ss.source_files  = "UIKit/View/BDCollectionViewCell/*.{h,m}"
        ss.public_header_files = "UIKit/View/BDCollectionViewCell/*.h"
    end

    s.subspec "NSArray+BDUIKIT" do |ss|
        ss.source_files  = "UIKit/Catagory/NSArray+BDUIKIT/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/NSArray+BDUIKIT/*.h"
    end

    s.subspec "NSString+BD" do |ss|
        ss.source_files  = "UIKit/Catagory/NSString+BD/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/NSString+BD/*.h"
    end

    s.subspec "UILabel+BD" do |ss|
        ss.source_files  = "UIKit/Catagory/UILabel+BD/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UILabel+BD/*.h"
    end

    s.subspec "UITextField+BD" do |ss|
        ss.source_files  = "UIKit/Catagory/UITextField+BD/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UITextField+BD/*.h"
    end

    s.subspec "UITextView+BD" do |ss|
        ss.source_files  = "UIKit/Catagory/UITextView+BD/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UITextView+BD/*.h"
    end

    s.subspec "UIView+BD" do |ss|
        ss.source_files  = "UIKit/Catagory/UIView+BD/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UIView+BD/*.h"
    end


  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  s.frameworks = "UIKit", "Foundation"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
