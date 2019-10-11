#
#  Be sure to run `pod spec lint BDToolKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "BDToolKit"
  s.version      = "2.5.6"
  s.summary      = "Usefull tool for objective-c develop."
  s.description  = "Usefull tool for objective-c develop.Help yourself in this post.And buy me a cup of coffee.Just kidding.Anyway Where is coffee shop?"
  s.homepage     = "https://github.com/reference/BDToolKit"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Scott Ban" => "imti_bandianhong@126.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/reference/BDToolKit.git", :tag => "#{s.version}" }

  s.frameworks = "UIKit", "Foundation", "WebKit", "AVFoundation", "QuartzCore", "StoreKit"
  s.requires_arc = true

  s.source_files  =  "BDToolKit.h"
  s.public_header_files = "BDToolKit.h"

    s.subspec "BDDefine" do |ss|
        ss.source_files  = "BDDefine.h"
        ss.public_header_files = "BDDefine.h"
    end

    s.subspec "NSObject+Identifier" do |ss|
        ss.source_files  = "UIKit/Catagory/NSObject+Identifier/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/NSObject+Identifier/*.h"
    end

    s.subspec "BDView" do |ss|
        ss.source_files  = "UIKit/View/BDView/*.{h,m}"
        ss.public_header_files = "UIKit/View/BDView/*.h"
    end

    s.subspec "BDCountDownButton" do |ss|
        ss.source_files  = "UIKit/View/BDCountDownButton/*.{h,m}"
        ss.public_header_files = "UIKit/View/BDCountDownButton/*.h"
    end

    s.subspec "BDNavigationBar" do |ss|
        ss.source_files  = "UIKit/View/BDNavigationBar/*.{h,m}"
        ss.public_header_files = "UIKit/View/BDNavigationBar/*.h"
    end

    s.subspec "BDStackView" do |ss|
        ss.source_files  = "UIKit/View/BDStackView/*.{h,m}"
        ss.public_header_files = "UIKit/View/BDStackView/*.h"
    end

    s.subspec "UILabel+NSNumberFormat" do |ss|
        ss.source_files  = "UIKit/Catagory/UILabel+NSNumberFormat/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UILabel+NSNumberFormat/*.h"
    end

    s.subspec "NSMutableDictionary+BD" do |ss|
        ss.source_files  = "UIKit/Catagory/NSMutableDictionary+BD/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/NSMutableDictionary+BD/*.h"
    end

    s.subspec "UIView+Tap" do |ss|
        ss.source_files  = "UIKit/Catagory/UIView+Tap/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UIView+Tap/*.h"
    end

    s.subspec "UIButton+BD" do |ss|
        ss.source_files  = "UIKit/Catagory/UIButton+BD/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UIButton+BD/*.h"
    end

    s.subspec "UIViewController+BD" do |ss|
        ss.source_files  = "UIKit/Catagory/UIViewController+BD/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UIViewController+BD/*.h"
    end

    s.subspec "NSMutableArray+BDModel" do |ss|
        ss.dependency 'BDToolKit/BDModel'
        ss.source_files  = "UIKit/Catagory/NSMutableArray+BDModel/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/NSMutableArray+BDModel/*.h"
    end

    s.subspec "UIScrollView+AutoAdjustScrollInsets" do |ss|
        ss.source_files  = "UIKit/Catagory/UIScrollView+AutoAdjustScrollInsets/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UIScrollView+AutoAdjustScrollInsets/*.h"
    end

    s.subspec "UITableViewController+BD" do |ss|
        ss.source_files  = "UIKit/Catagory/UITableViewController+BD/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UITableViewController+BD/*.h"
    end

    s.subspec "UICollectionViewController+BD" do |ss|
        ss.source_files  = "UIKit/Catagory/UICollectionViewController+BD/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UICollectionViewController+BD/*.h"
    end
    
    s.subspec "UINavigationController+Pop" do |ss|
        ss.source_files  = "UIKit/Catagory/UINavigationController+Pop/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UINavigationController+Pop/*.h"
    end

    s.subspec "NSDate+BD" do |ss|
        ss.source_files  = "UIKit/Catagory/NSDate+BD/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/NSDate+BD/*.h"
    end

    s.subspec "NSObject+BD" do |ss|
        ss.source_files  = "UIKit/Catagory/NSObject+BD/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/NSObject+BD/*.h"
    end

    s.subspec "NSNumber+NumerFormat" do |ss|
        ss.source_files  = "UIKit/Catagory/NSNumber+NumerFormat/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/NSNumber+NumerFormat/*.h"
    end

    s.subspec "BDViewController" do |ss|
        ss.dependency 'BDToolKit/BDView'
        ss.dependency 'BDToolKit/BDStackView'
        ss.source_files  = "UIKit/Controller/BDViewController/*.{h,m}"
        ss.public_header_files = "UIKit/Controller/BDViewController/*.h"
    end

    s.subspec "BDTableViewController" do |ss|
        ss.dependency 'BDToolKit/BDView'
        ss.dependency 'BDToolKit/BDStackView'
        ss.source_files  = "UIKit/Controller/BDTableViewController/*.{h,m}"
        ss.public_header_files = "UIKit/Controller/BDTableViewController/*.h"
    end

    s.subspec "BDCollectionViewController" do |ss|
        ss.dependency 'BDToolKit/BDView'
        ss.dependency 'BDToolKit/BDStackView'
        ss.source_files  = "UIKit/Controller/BDCollectionViewController/*.{h,m}"
        ss.public_header_files = "UIKit/Controller/BDCollectionViewController/*.h"
    end

    s.subspec "BDTableViewCell" do |ss|
        ss.dependency 'BDToolKit/BDView'
        ss.dependency 'BDToolKit/BDStackView'
        ss.source_files  = "UIKit/View/BDTableViewCell/*.{h,m}"
        ss.public_header_files = "UIKit/View/BDTableViewCell/*.h"
    end

    s.subspec "BDCollectionReusableView" do |ss|
        ss.dependency 'BDToolKit/BDView'
        ss.dependency 'BDToolKit/BDStackView'
        ss.source_files  = "UIKit/View/BDCollectionReusableView/*.{h,m}"
        ss.public_header_files = "UIKit/View/BDCollectionReusableView/*.h"
    end

    s.subspec "BDCollectionViewCell" do |ss|
        ss.dependency 'BDToolKit/BDView'
        ss.dependency 'BDToolKit/BDStackView'
        ss.source_files  = "UIKit/View/BDCollectionViewCell/*.{h,m}"
        ss.public_header_files = "UIKit/View/BDCollectionViewCell/*.h"
    end

    s.subspec "NSArray+BDUIKIT" do |ss|
        ss.dependency 'BDToolKit/BDView'
        ss.dependency 'BDToolKit/BDStackView'
        ss.dependency 'BDToolKit/NSObject+Identifier'
        ss.source_files  = "UIKit/Catagory/NSArray+BDUIKIT/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/NSArray+BDUIKIT/*.h"
    end

    s.subspec "NSString+BD" do |ss|
        ss.source_files  = "UIKit/Catagory/NSString+BD/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/NSString+BD/*.h"
    end

    s.subspec "UINib+UIView" do |ss|
        ss.source_files  = "UIKit/Catagory/UINib+UIView/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UINib+UIView/*.h"
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

    s.subspec "NSURLProtocol+WKWebVIew" do |ss|
        ss.source_files  = "Foundation/Catagory/NSURLProtocol+WKWebVIew/*.{h,m}"
        ss.public_header_files = "Foundation/Catagory/NSURLProtocol+WKWebVIew/*.h"
    end

    s.subspec "NSData+DeviceToken" do |ss|
        ss.source_files  = "Foundation/Catagory/NSData+DeviceToken/*.{h,m}"
        ss.public_header_files = "Foundation/Catagory/NSData+DeviceToken/*.h"
    end

    s.subspec "NSBundle+Associated" do |ss|
        ss.source_files  = "Foundation/Catagory/NSBundle+Associated/*.{h,m}"
        ss.public_header_files = "Foundation/Catagory/NSBundle+Associated/*.h"
    end

    s.subspec "NSURLComponents+Pairs" do |ss|
        ss.source_files  = "Foundation/Catagory/NSURLComponents+Pairs/*.{h,m}"
        ss.public_header_files = "Foundation/Catagory/NSURLComponents+Pairs/*.h"
    end

    s.subspec "BDAudioPlayer" do |ss|
        ss.source_files  = "UIKit/Utils/BDAudioPlayer/*.{h,m}"
        ss.public_header_files = "UIKit/Utils/BDAudioPlayer/*.h"
        ss.resources = "UIKit/Utils/BDAudioPlayer/*.bundle"
    end

    s.subspec "BDFreeStyleButton" do |ss|
        ss.dependency 'BDToolKit/BDView'
        ss.source_files  = "UIKit/View/BDFreeStyleButton/*.{h,m}"
        ss.public_header_files = "UIKit/View/BDFreeStyleButton/*.h"
    end

    s.subspec "BDModel" do |ss|
        ss.source_files  = "Foundation/Utils/BDModel/*.{h,m}"
        ss.public_header_files = "Foundation/Utils/BDModel/*.h"
    end

    s.subspec "UIView+BDAnimation" do |ss|
        ss.source_files  = "UIKit/Catagory/UIView+BDAnimation/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UIView+BDAnimation/*.h"
    end

    s.subspec "UIView+Constraints" do |ss|
        ss.source_files  = "UIKit/Catagory/UIView+Constraints/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UIView+Constraints/*.h"
    end

    s.subspec "UIView+BorderLine" do |ss|
        ss.dependency 'BDToolKit/NSObject+Identifier'
        ss.source_files  = "UIKit/Catagory/UIView+BorderLine/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UIView+BorderLine/*.h"
    end

    s.subspec "NSObject+NSCoding" do |ss|
        ss.source_files  = "Foundation/Catagory/NSObject+NSCoding/*.{h,m}"
        ss.public_header_files = "Foundation/Catagory/NSObject+NSCoding/*.h"
    end

    s.subspec "NSObject+Archive" do |ss|
        ss.source_files  = "Foundation/Catagory/NSObject+Archive/*.{h,m}"
        ss.public_header_files = "Foundation/Catagory/NSObject+Archive/*.h"
    end

    s.subspec "NSString+PercentEncoding" do |ss|
        ss.source_files  = "Foundation/Catagory/NSString+PercentEncoding/*.{h,m}"
        ss.public_header_files = "Foundation/Catagory/NSString+PercentEncoding/*.h"
    end
end
