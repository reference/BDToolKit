/**
 MIT License
 
 Copyright (c) 2018 Scott Ban (https://github.com/reference/BDToolKit)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */
#import "BDAppStoreChecker.h"
#import <StoreKit/StoreKit.h>
#define REQUEST_SUCCEED 200
#define CURRENT_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define BUNDLE_IDENTIFIER [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]
#define SYSTEM_VERSION_8_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)? (YES):(NO))
#define TRACK_ID @"TRACKID"
#define APP_LAST_VERSION @"APPLastVersion"
#define APP_RELEASE_NOTES @"APPReleaseNotes"
#define APP_TRACK_VIEW_URL @"APPTRACKVIEWURL"
#define SPECIAL_MODE_CHECK_URL @"https://itunes.apple.com/lookup?country=%@&bundleId=%@&timestamp=%ld"
#define NORMAL_MODE_CHECK_URL @"https://itunes.apple.com/lookup?bundleId=%@&timestamp=%ld"
#define SKIP_CURRENT_VERSION @"SKIPCURRENTVERSION"
#define SKIP_VERSION @"SKIPVERSION"


@interface BDAppStoreChecker()<SKStoreProductViewControllerDelegate, UIAlertViewDelegate>
@property (nonatomic, copy) NSString *nextTimeTitle;
@property (nonatomic, copy) NSString *confimTitle;
@property (nonatomic, copy) NSString *alertTitle;
@property (nonatomic, copy) NSString *skipVersionTitle;
@end

@implementation BDAppStoreChecker

static BDAppStoreChecker *checkManager = nil;
+ (instancetype)sharedCheckManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        checkManager = [[BDAppStoreChecker alloc] init];
        checkManager.nextTimeTitle = @"下次提示";
        checkManager.confimTitle = @"前往更新";
        checkManager.alertTitle = @"发现新版本";
        checkManager.skipVersionTitle = nil;
    });
    return checkManager;
}

- (void)checkVersion {
    [self checkVersionWithAlertTitle:self.alertTitle nextTimeTitle:self.nextTimeTitle confimTitle:self.confimTitle];
}

- (void)checkVersionWithAlertTitle:(NSString *)alertTitle nextTimeTitle:(NSString *)nextTimeTitle confimTitle:(NSString *)confimTitle {
    [self checkVersionWithAlertTitle:alertTitle nextTimeTitle:nextTimeTitle confimTitle:confimTitle skipVersionTitle:nil];
}

- (void)checkVersionWithAlertTitle:(NSString *)alertTitle nextTimeTitle:(NSString *)nextTimeTitle confimTitle:(NSString *)confimTitle skipVersionTitle:(NSString *)skipVersionTitle {
    self.alertTitle = alertTitle;
    self.nextTimeTitle = nextTimeTitle;
    self.confimTitle = confimTitle;
    self.skipVersionTitle = skipVersionTitle;
    [checkManager getInfoFromAppStore];
}

- (void)getInfoFromAppStore {
    NSInteger timeStamp = [[NSDate date] timeIntervalSince1970];
    NSURL *requestURL;
    if (self.countryAbbreviation == nil) {
        requestURL = [NSURL URLWithString:[NSString stringWithFormat:NORMAL_MODE_CHECK_URL,BUNDLE_IDENTIFIER,timeStamp]];
    } else {
        requestURL = [NSURL URLWithString:[NSString stringWithFormat:SPECIAL_MODE_CHECK_URL,self.countryAbbreviation,BUNDLE_IDENTIFIER,timeStamp]];
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:requestURL];
    NSURLSession *session = [NSURLSession sharedSession];

    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)response;
        if (data == nil) {
            return ;
        }
        if (urlResponse.statusCode == REQUEST_SUCCEED) {
            @try {
                NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                if ([responseDic[@"resultCount"] intValue] == 1) {
                    NSArray *results = responseDic[@"results"];
                    NSDictionary *resultDic = [results firstObject];
                    [userDefault setObject:resultDic[@"version"] forKey:APP_LAST_VERSION];
                    [userDefault setObject:resultDic[@"releaseNotes"] forKey:APP_RELEASE_NOTES];
                    [userDefault setObject:resultDic[@"trackViewUrl"] forKey:APP_TRACK_VIEW_URL];
                    [userDefault setObject:resultDic[@"trackId"] forKey:TRACK_ID];
                    if ([resultDic[@"version"] isEqualToString:CURRENT_VERSION] || ![[userDefault objectForKey:SKIP_VERSION] isEqualToString:resultDic[@"version"]]) {
                        [userDefault setBool:NO forKey:SKIP_CURRENT_VERSION];
                    }
                    [userDefault synchronize];
#ifdef DEBUG
                    NSLog(@"*****************\nAPP_LAST_VERSION:\n%@\nAPP_RELEASE_NOTES:\n%@\n*****************",[userDefault objectForKey:APP_LAST_VERSION],[userDefault objectForKey:APP_RELEASE_NOTES]);
#endif
                    dispatch_async(dispatch_get_main_queue(), ^{

                        if (![[userDefault objectForKey:SKIP_CURRENT_VERSION] boolValue]) {
                            if (![self isEqualByCompareLastVersion:resultDic[@"version"] withCurrentVersion:CURRENT_VERSION]) {
                                [self compareWithCurrentVersion];
                            }
                        }
                    });
                }
            } @catch (NSException *exception) {
                NSLog(@"exception.name = %@, exception.reason = %@", exception.name, exception.reason);
            } @finally {

            }
        }
    }];
    [dataTask resume];
}

/**
 * 比较当前版本号是否与沙盒中的版本号相同
 */
//- (BOOL)isEqualByCompareLastVersion:(NSString *)lastVersion withCurrentVersion:(NSString *)currentVersion {
//    NSArray *lastVersionArray = [lastVersion componentsSeparatedByString:@"."];
//    NSArray *currentVersionArray = [currentVersion componentsSeparatedByString:@"."];
//    if (lastVersionArray.count != currentVersionArray.count) {
//        return NO;
//    }
//    for (int index = 0; index < lastVersionArray.count; index++) {
//        if ([currentVersionArray[index] integerValue] != [lastVersionArray[index] integerValue]) {
//            return NO;
//        }
//    }
//    return YES;
//}

- (BOOL)isEqualByCompareLastVersion:(NSString *)lastVersion withCurrentVersion:(NSString *)currentVersion {
    NSMutableArray *lastVersionArray = [[lastVersion componentsSeparatedByString:@"."] mutableCopy];
    NSMutableArray *currentVersionArray = [[currentVersion componentsSeparatedByString:@"."] mutableCopy];
    int modifyCount = abs((int)(lastVersionArray.count - currentVersionArray.count));
    if (lastVersionArray.count > currentVersionArray.count) {
        for (int index = 0; index < modifyCount; index ++) {
            [currentVersionArray addObject:@"0"];
        }
    } else if (lastVersionArray.count < currentVersionArray.count) {
        for (int index = 0; index < modifyCount; index ++) {
            [lastVersionArray addObject:@"0"];
        }
    }
    for (int index = 0; index < lastVersionArray.count; index++) {
        if ([currentVersionArray[index] integerValue] > [lastVersionArray[index] integerValue]) {
            return YES;
        } else if ([currentVersionArray[index] integerValue] < [lastVersionArray[index] integerValue]) {
            return NO;
        }
    }
    return NO;
}

- (double)floatForVersion:(NSString *)version {
    NSArray *versionArray = [version componentsSeparatedByString:@"."];
    NSMutableString *versionString = @"".mutableCopy;
    for (int index = 0; index < versionArray.count; index++) {
        [versionString appendString:versionArray[index]];
        if (!index) {
            [versionString appendString:@"."];
        }
    }
    return versionString.doubleValue;
}

- (void)compareWithCurrentVersion {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *updateMessage = [userDefault objectForKey:APP_RELEASE_NOTES];
    if (![[userDefault objectForKey:APP_LAST_VERSION] isEqualToString:CURRENT_VERSION]) {
        if (SYSTEM_VERSION_8_OR_ABOVE) {
            __weak typeof(self) weakSelf = self;
            UIAlertController *alertControler = nil;
            //check whether force update
            if (self.forceUpdateIdentifier.length && [updateMessage containsString:self.forceUpdateIdentifier]) {
                updateMessage = [updateMessage stringByReplacingOccurrencesOfString:self.forceUpdateIdentifier withString:@""];
                alertControler = [UIAlertController alertControllerWithTitle:self.alertTitle message:updateMessage preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *confimAction = [UIAlertAction actionWithTitle:self.confimTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [weakSelf openAPPStore];
                }];
                [alertControler addAction:confimAction];
            }else{
                alertControler = [UIAlertController alertControllerWithTitle:self.alertTitle message:updateMessage preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:self.nextTimeTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                  
                }];
                UIAlertAction *confimAction = [UIAlertAction actionWithTitle:self.confimTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [weakSelf openAPPStore];
                }];
                [alertControler addAction:confimAction];
                [alertControler addAction:cancelAction];
                if (self.skipVersionTitle != nil) {
                    UIAlertAction *skipVersionAction = [UIAlertAction actionWithTitle:self.skipVersionTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                        [userDefault setBool:YES forKey:SKIP_CURRENT_VERSION];
                        [userDefault setObject:[userDefault objectForKey:APP_LAST_VERSION] forKey:SKIP_VERSION];
                    }];
                    [alertControler addAction:skipVersionAction];
                }
            }
            
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertControler animated:YES completion:^{}];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:self.alertTitle message:updateMessage delegate:self cancelButtonTitle:self.nextTimeTitle otherButtonTitles:self.confimTitle, self.skipVersionTitle,nil];
            [alertView show];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != 0) {
        [self openAPPStore];
    }
}

- (void)openAPPStore {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if (!self.openAPPStoreInsideAPP) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[userDefault objectForKey:APP_TRACK_VIEW_URL]]];
    } else {
        SKStoreProductViewController *storeViewController = [[SKStoreProductViewController alloc] init];
        storeViewController.delegate = self;
        
        NSDictionary *parametersDic = @{SKStoreProductParameterITunesItemIdentifier:[userDefault objectForKey:TRACK_ID]};
        [storeViewController loadProductWithParameters:parametersDic completionBlock:^(BOOL result, NSError * _Nullable error) {
            
            if (result) {
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:storeViewController animated:YES completion:^{
                    
                }];
            }
        }];
    }
    
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
