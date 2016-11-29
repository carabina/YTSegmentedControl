//
//  UIColor+Ext.m
//  YTCategory
//
//  Created by songyutao on 14-8-18.
//  Copyright (c) 2014年 Creditease. All rights reserved.
//

#import "UIColor+Ext.h"

@implementation UIColor (Ext)

+ (UIColor *)colorWithRGBA:(NSUInteger)color
{
    return [UIColor colorWithRed:((float)((color >> 24) & 0xFF))/255.0
                           green:((float)((color >> 16) & 0xFF))/255.0
                            blue:((float)((color >> 8) & 0xFF))/255.0
                           alpha:((float)(color & 0xFF))/255.0];
}

+ (UIColor *)colorWithString:(NSString *)color
{
    NSString *colorStr = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([colorStr hasPrefix:@"0X"])
    {
        colorStr = [colorStr substringFromIndex:2];
    }
    else if ([colorStr hasPrefix:@"#"])
    {
        colorStr = [colorStr substringFromIndex:1];
    }
    
    NSString *R=nil,*G=nil,*B=nil,*A=nil;
    
    switch (colorStr.length) {
        case 3:
        case 4:
        {
            NSRange range = NSMakeRange(0, 1);
            R = [colorStr substringWithRange:range];
            R = [NSString stringWithFormat:@"%@%@", R, R];
            
            range.location = 1;
            G = [colorStr substringWithRange:range];
            G = [NSString stringWithFormat:@"%@%@", G, G];
            
            range.location = 2;
            B = [colorStr substringWithRange:range];
            B = [NSString stringWithFormat:@"%@%@", B, B];
            
            range.location = 3;
            A = colorStr.length == 4 ? [colorStr substringWithRange:range] : @"F";
            A = [NSString stringWithFormat:@"%@%@", A, A];

            break;
        }
        case 6:
        case 8:
        {
            NSRange range = NSMakeRange(0, 2);
            R = [colorStr substringWithRange:range];
            
            range.location = 2;
            G = [colorStr substringWithRange:range];
            
            range.location = 4;
            B = [colorStr substringWithRange:range];
            
            range.location = 6;
            A = colorStr.length == 8 ? [colorStr substringWithRange:range] : @"FF";
            
            break;
        }
        default:
        {
            return [UIColor clearColor];
            break;
        }
    }
    
    NSUInteger r, g, b, a;
    [[NSScanner scannerWithString:R] scanHexInt:(unsigned *)&r];
    [[NSScanner scannerWithString:G] scanHexInt:(unsigned *)&g];
    [[NSScanner scannerWithString:B] scanHexInt:(unsigned *)&b];
    [[NSScanner scannerWithString:A] scanHexInt:(unsigned *)&a];
    
    return [UIColor colorWithRed:((float)(r & 0xFF))/255.0
                           green:((float)(g & 0xFF))/255.0
                            blue:((float)(b & 0xFF))/255.0
                           alpha:((float)(a & 0xFF))/255.0];
}

@end
