//
//  YXSegmentedControl.h
//  FSO
//
//  全局外观支持
//    UIImage *selectedImage = [[UIImage imageNamed:@"segmented_selected"] stretchableImageWithLeftCapWidth:[UIImage imageNamed:@"segmented_selected"].size.width/2 topCapHeight:[UIImage imageNamed:@"segmented_selected"].size.height/2];
//    UIImage *unSelectedImage = [[UIImage imageNamed:@"segmented_bg"] stretchableImageWithLeftCapWidth:[UIImage imageNamed:@"segmented_bg"].size.width/2 topCapHeight:[UIImage imageNamed:@"segmented_bg"].size.height/2];
//    [[YTSegmentedControl appearance] setSelectedItemBgImage:selectedImage];
//    [[YTSegmentedControl appearance] setNormalItemBgImage:unSelectedImage];
//    [[YTSegmentedControl appearance] setNormalAttributeDictionary:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:[UIColor blueColor]}];
//    [[YTSegmentedControl appearance] setSelectedAttributeDictionary:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:[UIColor grayColor]}];
//    [[YTSegmentedControl appearance] setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
//    [[YTSegmentedControl appearance] setItemWidth:80];
//
//  实例
//    YTSegmentedItem *item = [[YTSegmentedItem alloc] initWithTitle:@"zero" image:nil];
//    YTSegmentedItem *item2 = [[YTSegmentedItem alloc] initWithTitle:@"one" image:nil];
//    YTSegmentedItem *item3 = [[YTSegmentedItem alloc] initWithTitle:@"two" image:nil];
//    YTSegmentedItem *item4 = [[YTSegmentedItem alloc] initWithTitle:@"three" image:nil];
//
//    YTSegmentedControl *segmentedControl = [[YTSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:item, item2, item3, item4, nil]];
//    segmentedControl.frame = CGRectMake(10, 40, 200, 50);
//    [segmentedControl addTarget:self action:@selector(segmentedControlSelected:) forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:segmentedControl];
//
//  Created by songyutao on 14-11-25.
//  Copyright (c) 2014年 Creditease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTSegmentedItem : NSObject

- (id)initWithTitle:(NSString *)title image:(UIImage *)image selectImage:(UIImage *)selectImage;

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
