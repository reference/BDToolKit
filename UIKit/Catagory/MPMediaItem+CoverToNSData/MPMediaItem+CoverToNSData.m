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
#import "MPMediaItem+CoverToNSData.h"

@implementation MPMediaItem(CoverToNSData)

-(void)coverMusicToNSData:(void (^)(NSData *data))completion
{
    NSURL *url = [self valueForProperty: MPMediaItemPropertyAssetURL];
    AVURLAsset *songAsset = [AVURLAsset URLAssetWithURL: url options:nil];
    AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset: songAsset
                                                                      presetName:AVAssetExportPresetAppleM4A];
    exporter.outputFileType = @"com.apple.m4a-audio";

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * myDocumentsDirectory = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;

    [[NSDate date] timeIntervalSince1970];
    NSTimeInterval seconds = [[NSDate date] timeIntervalSince1970];
    NSString *intervalSeconds = [NSString stringWithFormat:@"%0.0f",seconds];

    NSString * fileName = [NSString stringWithFormat:@"%@.m4a",intervalSeconds];

    NSString *exportFile = [myDocumentsDirectory stringByAppendingPathComponent:fileName];

    NSURL *exportURL = [NSURL fileURLWithPath:exportFile];
    exporter.outputURL = exportURL;

    // do the export
    // (completion handler block omitted)
    [exporter exportAsynchronouslyWithCompletionHandler: ^{
        AVAssetExportSessionStatus exportStatus = exporter.status;
        NSData *data = nil;
        switch (exportStatus)
        {
            case AVAssetExportSessionStatusFailed:
            {
                NSError *exportError = exporter.error;
                NSLog (@"AVAssetExportSessionStatusFailed: %@", exportError);
                break;
            }
            case AVAssetExportSessionStatusCompleted:
            {
                NSLog (@"AVAssetExportSessionStatusCompleted");
                data = [NSData dataWithContentsOfFile: [myDocumentsDirectory stringByAppendingPathComponent:fileName]];
                break;
            }
            case AVAssetExportSessionStatusUnknown:
            {
                NSLog (@"AVAssetExportSessionStatusUnknown"); break;
            }
            case AVAssetExportSessionStatusExporting:
            {
                NSLog (@"AVAssetExportSessionStatusExporting"); break;
            }
            case AVAssetExportSessionStatusCancelled:
            {
                NSLog (@"AVAssetExportSessionStatusCancelled"); break;
            }
            case AVAssetExportSessionStatusWaiting:
            {
                NSLog (@"AVAssetExportSessionStatusWaiting"); break;
            }
            default:
            {
                NSLog (@"didn't get export status"); break;
            }
        }
        if (completion) {
            completion(data);
        }
     }];
}

@end
