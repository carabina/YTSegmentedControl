//
//  UIColor+Ext.h
//  YTCategory
//
//  Created by songyutao on 14-8-18.
//  Copyright (c) 2014年 Creditease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Ext)

//
//  eg:
//      UIColor *color = [UIColor colorWithRGBA:0xFF00AAFF];
//
+ (UIColor *)colorWithRGBA:(NSUInteger)color;

//
//  eg:
//      UIColor *color = [UIColor colorWithString:@"0xFF00AAFF"];
//      UIColor *color = [UIColor colorWithString:@"#FF00FFFF"];
//      UIColor *color = [UIColor colorWithString:@"0xFFFF"];
//
+ (UIColor *)colorWithString:(NSString *)color;

@end
