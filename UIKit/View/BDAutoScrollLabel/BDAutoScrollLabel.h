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
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

/** The following enumeration controls the scrolling direction of the text.
 */
typedef NS_ENUM(NSInteger, SK_AUTOSCROLL_DIRECTION){
    /**
     * @abstract Scroll from left to right
     */
    SK_AUTOSCROLL_DIRECTION_RIGHT,
    /**
     * @abstract Scroll from right to left
     */
    SK_AUTOSCROLL_DIRECTION_LEFT,
    /**
     * @abstract Scroll from bottom to top
     */
    SK_AUTOSCROLL_DIRECTION_TOP,
    /**
     * @abstract Scroll from top to bottom
     */
    SK_AUTOSCROLL_DIRECTION_BOTTOM
};

@interface BDAutoScrollLabel : UIView

/**
 *  Initializes an `BDAutoScrollLabel` object in current viewController.
 *
 *  This is the designated initializer.
 *
 *  @param textContent Fill in the text content that needs to be scrolled here.
 *  @param direction Direction of text content scrolling. The default type is SK_AUTOSCROLL_DIRECTION_RIGHT.
 */
- (instancetype _Nullable )initWithTextContent:(NSString * _Nonnull)textContent
                      direction:(SK_AUTOSCROLL_DIRECTION)direction;

/**
 *  Initializes an `BDAutoScrollLabel` object of rich text type in current viewController.
 *
 *  This is the designated initializer.
 *
 *  @param attributedTextContent Fill in the rich text content that needs to be scrolled here.
 *  @param direction Direction of text content scrolling. The default type is SK_AUTOSCROLL_DIRECTION_RIGHT.
 */
- (instancetype _Nullable )initWithAttributedTextContent:(NSAttributedString * _Nonnull)attributedTextContent
                                    direction:(SK_AUTOSCROLL_DIRECTION)direction;

/**
 *  Direction of text content scrolling.The default type is SK_AUTOSCROLL_DIRECTION_RIGHT.
 */
@property (nonatomic, assign) SK_AUTOSCROLL_DIRECTION direction;

/**
 *  The distance each frame moves.The default vaule is 1.0f.
 */
@property (nonatomic, assign) CGFloat pointsPerFrame;

/**
 *  The spacing of each scrolling label.The default vaule is 20.
 *
 *  @discussion When the text content is scrolling, it is actually the same label that does the repeated loop animation. This property
 *  determines the spacing between the label to be displayed and the label that will disappear each time the animation is repeated,
 *  that is, the spacing between the labels of the two looping animations.
 *
 */
@property (nonatomic, assign) NSUInteger labelSpacing;

/**
 *  Plain text content.
 */
@property (nonatomic, copy, nonnull) NSString *textContent;

/**
 *  Rich text content.
 */
@property (nonatomic, copy, nonnull) NSAttributedString *attributedTextContent;

/**
 *  Plain text color.
 */
@property (nonatomic, strong) UIColor * _Nullable textColor;

/**
 *  Plain text font.
 */
@property (nonatomic, strong) UIFont * _Nullable font;

/**
 *  Plain text alignment. 
 */
@property (nonatomic) NSTextAlignment textAlignment;

/**
 *  Default YES. Enable gradients of lable boundaries to fade.
 */
@property (nonatomic, assign) BOOL enableFade;

/**
 *  Pause scrolling animation being played.
 */
- (void)pauseScroll;

/**
 *  Make a paused scrolling animation continue playing.
 */
- (void)continueScroll;

@end
