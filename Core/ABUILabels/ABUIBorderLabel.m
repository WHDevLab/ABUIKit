//
//  ABUIBorderLabel.m
//  ABUIKit
//
//  Created by qp on 2020/6/23.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIBorderLabel.h"
#import "UIColor+AB.h"
@implementation ABUIBorderLabel
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.interColor = [UIColor blackColor];
        self.outerColor = [UIColor redColor];
        self.outerWidth = 2;
    }
    return self;
}
- (void)drawTextInRect:(CGRect)rect

{

    //描边

    CGContextRef c = UIGraphicsGetCurrentContext ();

    CGContextSetLineWidth (c, self.outerWidth);

    CGContextSetLineJoin (c, kCGLineJoinRound);

    CGContextSetTextDrawingMode (c, kCGTextStroke);

    //描边颜色

    self.textColor = self.outerColor;

    [super drawTextInRect:rect];

    //文字颜色

    self.textColor = self.interColor;

    CGContextSetTextDrawingMode (c, kCGTextFill);

    [super drawTextInRect:rect];

}

@end
