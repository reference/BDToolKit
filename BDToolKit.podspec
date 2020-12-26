#
#  Be sure to run `pod spec lint BDToolKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "BDToolKit"
  s.version      = "3.2.8"
  s.summary      = "Usefull tool for objective-c develop."
  s.description  = "Usefull tool for objective-c develop.Help yourself in this post.And buy me a cup of coffee.Just kidding.Anyway Where is coffee shop?"
  s.homepage     = "https://github.com/reference/BDToolKit"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Scott Ban" => "imti_bandianhong@126.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/reference/BDToolKit.git", :tag => "#{s.version}" }

  s.frameworks = "UIKit", "Foundation", "WebKit", "AVFoundation", "QuartzCore", "StoreKit", "Security", "AVFoundation", "MediaPlayer", "QuartzCore"
  s.requires_arc = true

  s.source_files  =  "BDToolKit.h"
  s.public_header_files = "BDToolKit.h"

    s.subspec "BDDefine" do |ss|
        ss.public_header_files  = "Foundation/BDDefine/BDDefine.h"
        ss.source_files  = "Foundation/BDDefine/*.{h,m}"
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

    s.subspec "BDMovingIcon" do |ss|
        ss.source_files  = "UIKit/View/BDMovingIcon/*.{h,m}"
        ss.public_header_files = "UIKit/View/BDMovingIcon/*.h"
    end
    
    s.subspec "BDQuickSecurityCode" do |ss|
        ss.dependency 'BDToolKit/UITextField+BDQuickSecurityCode'
        ss.source_files  = "UIKit/View/BDQuickSecurityCode/*.{h,m}"
        ss.public_header_files = "UIKit/View/BDQuickSecurityCode/*.h"
    end
    
    s.subspec "UILabel+NSNumberFormat" do |ss|
        ss.source_files  = "UIKit/Catagory/UILabel+NSNumberFormat/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UILabel+NSNumberFormat/*.h"
    end
    
    s.subspec "WKWebView+AccessoryHiding" do |ss|
        ss.source_files  = "UIKit/Catagory/WKWebView+AccessoryHiding/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/WKWebView+AccessoryHiding/*.h"
    end
    
    s.subspec "UINavigationBar+BDToolKit" do |ss|
        ss.source_files  = "UIKit/Catagory/UINavigationBar+BDToolKit/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UINavigationBar+BDToolKit/*.h"
    end
    
    s.subspec "MPMediaItem+CoverToNSData" do |ss|
        ss.source_files  = "UIKit/Catagory/MPMediaItem+CoverToNSData/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/MPMediaItem+CoverToNSData/*.h"
    end
    
    s.subspec "UIView+ShadowPath" do |ss|
        ss.source_files  = "UIKit/Catagory/UIView+ShadowPath/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UIView+ShadowPath/*.h"
    end
    
    s.subspec "UIViewController+AutoRotaion" do |ss|
        ss.source_files  = "UIKit/Catagory/UIViewController+AutoRotaion/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UIViewController+AutoRotaion/*.h"
    end
    
    s.subspec "NSError+LocalizedDescription" do |ss|
        ss.source_files  = "UIKit/Catagory/NSError+LocalizedDescription/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/NSError+LocalizedDescription/*.h"
    end
    
    s.subspec "UIResponder+AutoRotation" do |ss|
        ss.dependency 'BDToolKit/UIViewController+AutoRotaion'
        ss.source_files  = "UIKit/Catagory/UIResponder+AutoRotation/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UIResponder+AutoRotation/*.h"
    end
    
    s.subspec "UIImage+QRCode" do |ss|
        ss.source_files  = "UIKit/Catagory/UIImage+QRCode/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UIImage+QRCode/*.h"
    end
    
    s.subspec "UICollectionViewFlowLayout+Float" do |ss|
        ss.source_files  = "UIKit/Catagory/UICollectionViewFlowLayout+Float/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UICollectionViewFlowLayout+Float/*.h"
    end

    s.subspec "UIImage+Color" do |ss|
        ss.source_files  = "UIKit/Catagory/UIImage+Color/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UIImage+Color/*.h"
    end

    s.subspec "NSMutableDictionary+BD" do |ss|
        ss.source_files  = "UIKit/Catagory/NSMutableDictionary+BD/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/NSMutableDictionary+BD/*.h"
    end
    
    s.subspec "UIButton+Badge" do |ss|
        ss.source_files  = "UIKit/Catagory/UIButton+Badge/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UIButton+Badge/*.h"
    end
    
    s.subspec "UIBarButtonItem+Badge" do |ss|
        ss.source_files  = "UIKit/Catagory/UIBarButtonItem+Badge/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UIBarButtonItem+Badge/*.h"
    end
    
    s.subspec "WKWebView+MultiImages" do |ss|
        ss.source_files  = "UIKit/Catagory/WKWebView+MultiImages/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/WKWebView+MultiImages/*.h"
    end

    s.subspec "UIView+Tap" do |ss|
        ss.source_files  = "UIKit/Catagory/UIView+Tap/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UIView+Tap/*.h"
    end
    
    s.subspec "UITextField+BDQuickSecurityCode" do |ss|
        ss.source_files  = "UIKit/Catagory/UITextField+BDQuickSecurityCode/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UITextField+BDQuickSecurityCode/*.h"
    end
    
    s.subspec "UITableView+Dequeue" do |ss|
        ss.source_files  = "UIKit/Catagory/UITableView+Dequeue/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UITableView+Dequeue/*.h"
    end
    
    s.subspec "UIButton+BD" do |ss|
        ss.source_files  = "UIKit/Catagory/UIButton+BD/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UIButton+BD/*.h"
    end
    
    s.subspec "NSData+Encryption" do |ss|
        ss.source_files  = "UIKit/Catagory/NSData+Encryption/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/NSData+Encryption/*.h"
    end
    
    s.subspec "NSString+Encryption" do |ss|
        ss.dependency 'BDToolKit/NSData+Encryption'
        ss.source_files  = "UIKit/Catagory/NSString+Encryption/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/NSString+Encryption/*.h"
    end
    
    s.subspec "NSString+RandomKey" do |ss|
        ss.dependency 'BDToolKit/NSString+Encryption'
        ss.source_files  = "UIKit/Catagory/NSString+RandomKey/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/NSString+RandomKey/*.h"
    end
    
    s.subspec "NSData+RandomData" do |ss|
        ss.source_files  = "UIKit/Catagory/NSData+RandomData/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/NSData+RandomData/*.h"
    end

    s.subspec "UIViewController+BD" do |ss|
        ss.source_files  = "UIKit/Catagory/UIViewController+BD/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UIViewController+BD/*.h"
    end
    
    s.subspec "UIBarButtonItem+Property" do |ss|
        ss.source_files  = "UIKit/Catagory/UIBarButtonItem+Property/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UIBarButtonItem+Property/*.h"
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
    
    s.subspec "NSObject+Ivar" do |ss|
        ss.source_files  = "UIKit/Catagory/NSObject+Ivar/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/NSObject+Ivar/*.h"
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
    
    s.subspec "BDCollectionViewFlowLayout" do |ss|
        ss.source_files  = "UIKit/View/BDCollectionViewFlowLayout/*.{h,m}"
        ss.public_header_files = "UIKit/View/BDCollectionViewFlowLayout/*.h"
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
    
    s.subspec "BDAutoScrollLabel" do |ss|
        ss.source_files  = "UIKit/View/BDAutoScrollLabel/*.{h,m}"
        ss.public_header_files = "UIKit/View/BDAutoScrollLabel/*.h"
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
    
    s.subspec "NSString+Base64Image" do |ss|
        ss.source_files  = "Foundation/Catagory/NSString+Base64Image/*.{h,m}"
        ss.public_header_files = "Foundation/Catagory/NSString+Base64Image/*.h"
    end
    
    s.subspec "UINib+UIView" do |ss|
        ss.source_files  = "UIKit/Catagory/UINib+UIView/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UINib+UIView/*.h"
    end

    s.subspec "UILabel+BD" do |ss|
        ss.source_files  = "UIKit/Catagory/UILabel+BD/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UILabel+BD/*.h"
    end
    
    s.subspec "UIButton+Layout" do |ss|
        ss.source_files  = "UIKit/Catagory/UIButton+Layout/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UIButton+Layout/*.h"
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
    
    s.subspec "UITableViewHeaderFooterView+BDMasonryAutoFooterView" do |ss|
        ss.source_files  = "UIKit/Catagory/UITableViewHeaderFooterView+BDMasonryAutoFooterView/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UITableViewHeaderFooterView+BDMasonryAutoFooterView/*.h"
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
    
    s.subspec "BDPOPNumberAnimation" do |ss|
        ss.source_files  = "UIKit/Utils/BDPOPNumberAnimation/*.{h,m}"
        ss.public_header_files = "UIKit/Utils/BDPOPNumberAnimation/*.h"
        ss.dependency = 'pop'
    end
    
    s.subspec "BDTagView" do |ss|
        ss.source_files  = "UIKit/Utils/BDTagView/*.{h,m}"
        ss.public_header_files = "UIKit/Utils/BDTagView/*.h"
    end
    
    s.subspec "BDPullScaleCollectionViewFlowLayout" do |ss|
        ss.source_files  = "UIKit/Utils/BDPullScaleCollectionViewFlowLayout/*.{h,m}"
        ss.public_header_files = "UIKit/Utils/BDPullScaleCollectionViewFlowLayout/*.h"
    end
    
    s.subspec "BDComponentFactory" do |ss|
        ss.source_files  = "UIKit/Utils/BDComponentFactory/*.{h,m}"
        ss.public_header_files = "UIKit/Utils/BDComponentFactory/*.h"
    end

    s.subspec "BDAnimation" do |ss|
        ss.source_files  = "UIKit/Utils/BDAnimation/*.{h,m}"
        ss.public_header_files = "UIKit/Utils/BDAnimation/*.h"
    end
    
    s.subspec "BDAppStoreChecker" do |ss|
        ss.source_files  = "UIKit/Utils/BDAppStoreChecker/*.{h,m}"
        ss.public_header_files = "UIKit/Utils/BDAppStoreChecker/*.h"
    end
    
    s.subspec "BDCommonCryptor" do |ss|
        ss.source_files  = "UIKit/Utils/BDCommonCryptor/*.{h,m}"
        ss.public_header_files = "UIKit/Utils/BDCommonCryptor/*.h"
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

    s.subspec "BDRSA" do |ss|
        ss.source_files  = "Foundation/Utils/BDRSA/*.{h,m}"
        ss.public_header_files = "Foundation/Utils/BDRSA/*.h"
    end
    
    s.subspec "BDRSAEncryptor" do |ss|
        ss.source_files  = "Foundation/Utils/BDRSAEncryptor/*.{h,m}"
        ss.public_header_files = "Foundation/Utils/BDRSAEncryptor/*.h"
    end
    
    s.subspec "UIView+BDAnimation" do |ss|
        ss.source_files  = "UIKit/Catagory/UIView+BDAnimation/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UIView+BDAnimation/*.h"
    end

    s.subspec "UIView+Constraints" do |ss|
        ss.source_files  = "UIKit/Catagory/UIView+Constraints/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/UIView+Constraints/*.h"
    end
    
    s.subspec "WKWebView+Constraints" do |ss|
        ss.source_files  = "UIKit/Catagory/WKWebView+Constraints/*.{h,m}"
        ss.public_header_files = "UIKit/Catagory/WKWebView+Constraints/*.h"
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
