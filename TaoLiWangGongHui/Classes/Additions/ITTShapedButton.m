//
//  ITTShapedButton.m
//  iTotemFramework
//
//  Created by Sword on 13-11-11.
//  Copyright (c) 2013年 iTotemStudio. All rights reserved.
//

#import "ITTShapedButton.h"
#import "UIImage+ITTAdditions.h"

@interface ITTShapedButton()

@property (nonatomic, assign) BOOL response;
@property (nonatomic, assign) CGPoint previousHitTestPoint;
@property (nonatomic, strong) UIImage *buttonImage;
@property (nonatomic, strong) UIImage *backgroundImage;

@end

#define kAlphaVisibleThreshold 0.1

@implementation ITTShapedButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		[self setup];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)awakeFromNib
{
	[super awakeFromNib];
	[self setup];
}

#pragma mark - accessors
- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
	[super setImage:image forState:state];
	[self updateImageCacheForCurrentState];
	[self resetHitTestResponse];
}

- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state
{
	[super setBackgroundImage:image forState:state];
	[self updateImageCacheForCurrentState];
	[self resetHitTestResponse];
}

- (void)setSelected:(BOOL)selected
{
	[super setSelected:selected];
	[self updateImageCacheForCurrentState];
}

- (void)setHighlighted:(BOOL)highlighted
{
	[super setHighlighted:highlighted];
	[self updateImageCacheForCurrentState];
}

- (void)setEnabled:(BOOL)enabled
{
	[super setEnabled:enabled];
	[self updateImageCacheForCurrentState];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
	NSLog(@"- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event");
    // Return NO if even super returns NO (i.e., if point lies outside our bounds)
    BOOL superResult = [super pointInside:point withEvent:event];
    if (!superResult) {
        return superResult;
    }
	
    // Don't check again if we just queried the same point
    // (because pointInside:withEvent: gets often called multiple times)
    if (CGPointEqualToPoint(point, self.previousHitTestPoint)) {
        return self.response;
    } else {
        self.previousHitTestPoint = point;
    }
	
    BOOL response = NO;
    
    if (self.buttonImage == nil && self.backgroundImage == nil) {
        response = YES;
    }
    else if (self.buttonImage != nil && self.backgroundImage == nil) {
        response = [self isAlphaVisibleAtPoint:point forImage:self.buttonImage];
    }
    else if (self.buttonImage == nil && self.backgroundImage != nil) {
        response = [self isAlphaVisibleAtPoint:point forImage:self.backgroundImage];
    }
    else {
        if ([self isAlphaVisibleAtPoint:point forImage:self.buttonImage]) {
            response = YES;
        } else {
            response = [self isAlphaVisibleAtPoint:point forImage:self.backgroundImage];
        }
    }
    self.response = response;
    return response;
}

#pragma mark - private methods


- (BOOL)isAlphaVisibleAtPoint:(CGPoint)point forImage:(UIImage *)image
{
    // Correct point to take into account that the image does not have to be the same size
    // as the button. See https://github.com/ole/OBShapedButton/issues/1
    CGSize iSize = image.size;
    CGSize bSize = self.bounds.size;
    point.x *= (bSize.width != 0) ? (iSize.width / bSize.width) : 1;
    point.y *= (bSize.height != 0) ? (iSize.height / bSize.height) : 1;
	
    UIColor *pixelColor = [image colorAtPixel:point];
    CGFloat alpha = 0.0;
    
    if ([pixelColor respondsToSelector:@selector(getRed:green:blue:alpha:)])
    {
        // available from iOS 5.0
        [pixelColor getRed:NULL green:NULL blue:NULL alpha:&alpha];
    }
    else
    {
        // for iOS < 5.0
        // In iOS 6.1 this code is not working in release mode, it works only in debug
        // CGColorGetAlpha always return 0.
        CGColorRef cgPixelColor = [pixelColor CGColor];
        alpha = CGColorGetAlpha(cgPixelColor);
    }
    return alpha >= kAlphaVisibleThreshold;
}

- (void)setup
{
	[self updateImageCacheForCurrentState];
	[self resetHitTestResponse];
}

- (void)updateImageCacheForCurrentState
{
	self.buttonImage = self.currentImage;
	self.backgroundImage = self.currentBackgroundImage;
}

- (void)resetHitTestResponse
{
	_previousHitTestPoint = CGPointMake(CGFLOAT_MIN, CGFLOAT_MIN);
	_response = FALSE;
}
@end
