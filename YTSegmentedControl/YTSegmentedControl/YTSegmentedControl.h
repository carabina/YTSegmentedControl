//
//  YXSegmentedControl.h
//  FSO
//
//  全局外观支持
//    UIImage *selectedImage = [[YXSkin imageNamed:@"segmented_selected_red"] stretchableImage];
//    UIImage *unSelectedImage = [UIImage imageWithColor:[UIColor clearColor]];
//    [[YXSegmentedControl appearance] setSelectedImage:selectedImage];
//    [[YXSegmentedControl appearance] setNormalImage:unSelectedImage];
//    [[YXSegmentedControl appearance] setNormalAttributeDictionary:@{TextFontAttribute:[UIFont iOS7FontWithSize:16 attribute:Font7AttributeNone], TextColorAttribute:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.8]}];
//    [[YXSegmentedControl appearance] setSelectedAttributeDictionary:@{TextFontAttribute:[UIFont iOS7FontWithSize:16 attribute:Font7AttributeMedium], TextColorAttribute:[UIColor colorWhite]}];
//    [[YXSegmentedControl appearance] setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
//    [[YXSegmentedControl appearance] setItemWidth:80];
//
//  实例
//    YXSegmentedItem *item = [[YXSegmentedItem alloc] initWithTitle:@"one" image:nil controllerClass:nil];
//    YXSegmentedItem *item2 = [[YXSegmentedItem alloc] initWithTitle:@"two" image:nil controllerClass:nil];
//
//    YXSegmentedControl *segmentedControl = [[YXSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:item, item2, nil]];
//    segmentedControl.frame = CGRectMake(0, 0, self.tableView.width, 130);
//    segmentedControl.contentCorner = 5;
//    self.tableView.tableHeaderView = segmentedControl;
//    [segmentedControl addTarget:self action:@selector(segmentedControlSelected:) forControlEvents:UIControlEventValueChanged];
//
//  Created by songyutao on 14-11-25.
//  Copyright (c) 2014年 Creditease. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTCategory.h"

@interface YTSegmentedItem : NSObject

- (id)initWithTitle:(NSString *)title image:(UIImage *)image;

@property(nonatomic, strong)UIImage         *image;
@property(nonatomic, strong)UIImage         *selectImage;
@property(nonatomic, strong)NSString        *title;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface YTSegmentedControl : UIControl

@property(nonatomic, assign)UIEdgeInsets    contentEdgeInsets                   UI_APPEARANCE_SELECTOR;
@property(nonatomic, copy  )UIColor         *tintColor                          UI_APPEARANCE_SELECTOR;
@property(nonatomic, copy  )NSDictionary    *normalAttributeDictionary          UI_APPEARANCE_SELECTOR;//support NSFontAttributeName and NSForegroundColorAttributeName
@property(nonatomic, copy  )NSDictionary    *selectedAttributeDictionary        UI_APPEARANCE_SELECTOR;
@property(nonatomic, copy  )UIImage         *normalItemBgImage                  UI_APPEARANCE_SELECTOR;
@property(nonatomic, copy  )UIImage         *selectedItemBgImage                UI_APPEARANCE_SELECTOR;
@property(nonatomic, assign)CGFloat         contentCorner;
@property(nonatomic, assign)CGFloat         itemGap                             UI_APPEARANCE_SELECTOR;//default : 0
@property(nonatomic, assign)CGFloat         itemWidth                           UI_APPEARANCE_SELECTOR;//default : 60，If this value is multiplied by the item number less than contentview, the value will be re calculated.

@property(nonatomic, strong)UIView          *backgroundView;
@property(nonatomic, assign)NSUInteger      selectedIndex;

- (id)initWithItems:(NSArray *)items;

- (void)addItem:(YTSegmentedItem *)item atIndex:(NSUInteger)index;

- (void)clearItem;

- (void)onlySetSelectedIndex:(NSUInteger)index;//just change the current selected index, does not send UIControlEventValueChanged event.

@end
