#
#  Be sure to run `pod spec lint BDToolKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "BDToolKit"
  s.version      = "1.1.9"
  s.summary      = "Usefull tool for objective-c develop."
  s.description  = "Usefull tool for objective-c develop.Help yourself in this post.And buy me a cup of coffee.Just kidding.Anyway Where is coffee shop?"
  s.homepage     = "https://github.com/reference/BDToolKit"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Scott Ban" => "imti_bandianhong@126.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/reference/BDToolKit.git", :tag => "#{s.version}" }

  s.frameworks = "UIKit", "Foundation"
  s.requires_arc = true

  s.source_files  =  "BDToolKit.h"
  s.public_header_files = "BDToolKit.h"

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

    s.subspec "BDButton" do |ss|
        ss.source_files  = "UIKit/View/BDButton/*.{h,m}"
        ss.public_header_files = "UIKit/View/BDButton/*.h"
    end

    s.subspec "BDSegmentView" do |ss|
        ss.source_files  = "UIKit/View/BDSegmentView/*.{h,m}"
        ss.public_header_files = "UIKit/View/BDSegmentView/*.h"
    end

    s.subspec "BDImageView" do |ss|
        ss.source_files  = "UIKit/View/BDImageView/*.{h,m}"
        ss.public_header_files = "UIKit/View/BDImageView/*.h"
    end

    s.subspec "BDLabel" do |ss|
        ss.source_files  = "UIKit/View/BDLabel/*.{h,m}"
        ss.public_header_files = "UIKit/View/BDLabel/*.h"
    end

    s.subspec "UIView+BDCDS" do |ss|
        ss.source_files  = "UIKit/Catagory/UIView+BDCDS/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UIView+BDCDS/*.h"
    end

end
