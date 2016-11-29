//
//  UIView+Ext.h
//  YTCategory
//
//  Created by songyutao on 14-8-14.
//  Copyright (c) 2014年 Creditease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Ext)

@property(nonatomic, assign)CGFloat         left;
@property(nonatomic, assign)CGFloat         top;
@property(nonatomic, assign)CGFloat         right;
@property(nonatomic, assign)CGFloat         bottom;
@property(nonatomic, assign)CGFloat         width;
@property(nonatomic, assign)CGFloat         height;
@property(nonatomic, assign)CGSize          size;
@property(nonatomic, assign)CGPoint         origin;

- (void)removeAllSubviews;

@end
