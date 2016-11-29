//
//  YXSegmentedControl.m
//  FSO
//
//  Created by songyutao on 14-11-25.
//  Copyright (c) 2014年 Creditease. All rights reserved.
//

#import "YTSegmentedControl.h"

static const CGFloat KDefaultItemWidth = 60;

@implementation YTSegmentedItem

- (id)initWithTitle:(NSString *)title image:(UIImage *)image  selectImage:(UIImage *)selectImage
{
    self = [super init];
    if (self) {
        
        self.title = title;
        self.image = image;
        self.selectImage = selectImage;
        
    }
    return self;
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@interface YTSegmentedControlItemView : UIControl
@property(nonatomic, strong)YTSegmentedItem     *item;
@property(nonatomic, strong)UIImageView         *iconView;
@property(nonatomic, strong)UILabel             *titleLabel;
@property(nonatomic, strong)UIImageView         *backgroundImageView;

@property(nonatomic, strong)UIImage             *backgroundImage;
@property(nonatomic, strong)UIImage             *selectBackgroundImage;
@property(nonatomic, strong)UIColor             *backgroundColor;
@property(nonatomic, strong)UIColor             *selectBackgroundColor;

@property(nonatomic, copy  )NSDictionary        *normalAttributeDictionary;
@property(nonatomic, copy  )NSDictionary        *selectedAttributeDictionary;

- (instancetype)initWithItem:(YTSegmentedItem *)item;

@end

@implementation YTSegmentedControlItemView

- (instancetype)initWithItem:(YTSegmentedItem *)item
{
    self = [super init];
    if (self) {
        self.item = item;
    }
    return self;
}

- (void)setItem:(YTSegmentedItem *)item
{
    _item = item;
    self.iconView.image = item.image;
    self.iconView.frame = CGRectMake(0, 0, item.image.size.width, item.image.size.height) ;
    self.titleLabel.text = item.title;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundImageView = [[UIImageView alloc] init];
        [self addSubview:self.backgroundImageView];
        
        self.iconView = [[UIImageView alloc] init];
        [self addSubview:self.iconView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.titleLabel];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    const CGFloat gap = 10;
    const CGFloat width = self.bounds.size.width;
    const CGFloat height = self.bounds.size.height;
    
    self.backgroundImageView.frame = self.bounds;
    
    CGSize imageSize = self.iconView.image.size;
    CGSize titleSize = [self.titleLabel.text boundingRectWithSize:CGSizeMake(width-imageSize.width, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil].size;
    
    self.iconView.frame = CGRectMake((width-imageSize.width-titleSize.width-(imageSize.width>0 ? gap : 0))/2, (height-imageSize.height)/2, imageSize.width, imageSize.height);
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.iconView.frame)+(imageSize.width>0 ? gap : 0), (height-titleSize.height)/2, titleSize.width, titleSize.height);
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    NSDictionary *dictionary = selected ? self.selectedAttributeDictionary : self.normalAttributeDictionary;
    
    self.iconView.image = selected ? self.item.selectImage : self.item.image;
    self.iconView.frame = CGRectMake(0, 0, self.iconView.image.size.width, self.iconView.image.size.height);
    self.titleLabel.font = [dictionary objectForKey:NSFontAttributeName];
    self.titleLabel.textColor = [dictionary objectForKey:NSForegroundColorAttributeName];
    self.backgroundImageView.image = selected ? self.selectBackgroundImage : self.backgroundImage;
    
    [self setNeedsLayout];
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface YTSegmentedControl ()

@property(nonatomic, strong)NSMutableArray      *itemButtonArray;
@property(nonatomic, strong)UIScrollView        *contentView;
@property(nonatomic, assign)BOOL                onlySelected;

@end

@implementation YTSegmentedControl

+ (void)initialize
{
    [[YTSegmentedControl appearance] setTintColor:[UIColor colorWithRed:0/255 green:91/255.0 blue:255/255.0 alpha:1]];
    [[YTSegmentedControl appearance] setContentEdgeInsets:UIEdgeInsetsZero];
    
    [[YTSegmentedControl appearance] setNormalAttributeDictionary:@{NSFontAttributeName:[UIFont systemFontOfSize:14],
                                                                    NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    [[YTSegmentedControl appearance] setSelectedAttributeDictionary:@{NSFontAttributeName:[UIFont systemFontOfSize:14],
                                                                      NSForegroundColorAttributeName:[UIColor blueColor]}];
    
    [[YTSegmentedControl appearance] setItemWidth:KDefaultItemWidth];
    
    [[YTSegmentedControl appearance] setItemGap:0];
}

- (id)initWithItems:(NSArray *)items
{
    self = [super init];
    if (self) {
        
        CGFloat index = 0;
        for (YTSegmentedItem *segmentedItem in items)
        {
            [self addItem:segmentedItem atIndex:index++];
        }
        
        self.selectedIndex = 0;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        
        self.itemButtonArray = [NSMutableArray array];
        
        self.contentCorner = 0;
        self.itemGap = 0;
        
        self.backgroundColor = [UIColor clearColor];
        
        self.contentView = [[UIScrollView alloc] init];
        self.contentView.clipsToBounds = YES;
        self.contentView.backgroundColor = [UIColor clearColor];
        self.contentView.showsHorizontalScrollIndicator = NO;
        self.contentView.showsVerticalScrollIndicator = NO;
        [self addSubview:self.contentView];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [self onlySetSelectedIndex:self.selectedIndex];
    
    if (self.itemButtonArray.count > 0)
    {
        YTSegmentedControlItemView *itemView = [self.itemButtonArray objectAtIndex:self.selectedIndex];
        itemView.selected = YES;
    }
}

- (void)addItem:(YTSegmentedItem *)item atIndex:(NSUInteger)index
{
    if (index <= self.itemButtonArray.count)
    {
        YTSegmentedControlItemView *itemView = [[YTSegmentedControlItemView alloc] initWithItem:item];
        [itemView addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [itemView setNormalAttributeDictionary:self.normalAttributeDictionary];
        [itemView setSelectedAttributeDictionary:self.selectedAttributeDictionary];
        [itemView setSelected:NO];
        [self.itemButtonArray insertObject:itemView atIndex:index];
        [self.contentView addSubview:itemView];
    }
}

- (void)clearItem
{
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    [self.itemButtonArray removeAllObjects];
}

- (void)setBackgroundView:(UIView *)backgroundView
{
    [_backgroundView removeFromSuperview];
    
    _backgroundView = backgroundView;
    [self addSubview:_backgroundView];
    [self sendSubviewToBack:_backgroundView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.backgroundView.frame = self.bounds;
    
    self.contentView.frame = UIEdgeInsetsInsetRect(self.bounds, self.contentEdgeInsets);
    
    if (self.contentCorner != 0)
    {
        self.contentView.layer.cornerRadius = self.contentCorner;
        self.contentView.clipsToBounds = YES;
        
        self.contentView.layer.borderWidth = 1.0f;
        self.contentView.layer.borderColor = self.tintColor.CGColor;
    }
    else
    {
        self.contentView.clipsToBounds = NO;
    }
    
    CGRect contentRect = self.contentView.bounds;
    
    self.itemWidth = self.itemButtonArray.count*self.itemWidth <= contentRect.size.width ? (contentRect.size.width / self.itemButtonArray.count) : self.itemWidth;
    CGFloat margin = self.itemButtonArray.count*self.itemWidth > contentRect.size.width ? 0 : (contentRect.size.width-self.itemButtonArray.count*self.itemWidth-(self.itemButtonArray.count-1)*self.itemGap)/2;
    CGFloat offX = margin < 0 ? 0 : margin;
    for (YTSegmentedControlItemView *itemView in self.itemButtonArray)
    {
        itemView.frame = CGRectMake(offX, contentRect.origin.y, self.itemWidth, contentRect.size.height);
        offX += self.itemWidth + self.itemGap;
        [self layoutItemAttribute:itemView];
    }
    offX -= self.itemGap;
    offX += margin < 0 ? 0 : margin;
    self.contentView.contentSize = CGSizeMake(offX, contentRect.size.height);
}

- (void)setTintColor:(UIColor *)tintColor
{
    _tintColor = tintColor;
    [self setNeedsLayout];
}

- (void)layoutItemAttribute:(YTSegmentedControlItemView *)button
{
    for (YTSegmentedControlItemView *button in self.itemButtonArray)
    {
        if (!self.normalItemBgImage)
        {
            [button setBackgroundColor:self.backgroundColor];
        }
        else
        {
            [button setBackgroundImage:self.normalItemBgImage];
        }
        
        if (!self.selectedItemBgImage)
        {
            [button setSelectBackgroundColor:self.tintColor];
        }
        else
        {
            [button setSelectBackgroundImage:self.selectedItemBgImage];
        }
        
        [self setItemWithAttributeDictionary:self.normalAttributeDictionary item:button];
        [self setItemWithAttributeDictionary:self.selectedAttributeDictionary item:button];
        
        [button setSelected:button.selected];
    }
}

- (void)setItemWithAttributeDictionary:(NSDictionary *)attribute item:(YTSegmentedControlItemView *)itemView
{
    [itemView.titleLabel setFont:[attribute objectForKey:NSFontAttributeName]];
    [itemView.titleLabel setTextColor:[attribute objectForKey:NSForegroundColorAttributeName]];
}

- (void)setNormalAttributeDictionary:(NSDictionary *)normalAttributeDictionary
{
    _normalAttributeDictionary = normalAttributeDictionary;
    for (YTSegmentedControlItemView *itemView in self.itemButtonArray)
    {
        [itemView setNormalAttributeDictionary:normalAttributeDictionary];
    }
}

- (void)setSelectedAttributeDictionary:(NSDictionary *)selectedAttributeDictionary
{
    _selectedAttributeDictionary = selectedAttributeDictionary;
    for (YTSegmentedControlItemView *itemView in self.itemButtonArray)
    {
        [itemView setSelectedAttributeDictionary:selectedAttributeDictionary];
    }
}

- (void)setNormalItemBgImage:(UIImage *)normalItemBgImage
{
    _normalItemBgImage = normalItemBgImage;
    for (YTSegmentedControlItemView *itemView in self.itemButtonArray)
    {
        [itemView setBackgroundImage:normalItemBgImage];
    }
}

- (void)setSelectedItemBgImage:(UIImage *)selectedItemBgImage
{
    _selectedItemBgImage = selectedItemBgImage;
    for (YTSegmentedControlItemView *itemView in self.itemButtonArray)
    {
        [itemView setBackgroundImage:selectedItemBgImage];
    }
}

- (void)onlySetSelectedIndex:(NSUInteger)index
{
    self.onlySelected = YES;
    self.selectedIndex = index;
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    NSUInteger oldSelectedIndex = self.selectedIndex;
    if (selectedIndex < self.itemButtonArray.count)
    {
        _selectedIndex = selectedIndex;
        
        YTSegmentedControlItemView *itemView = [self.itemButtonArray objectAtIndex:selectedIndex];
        YTSegmentedControlItemView *oldItemView = [self.itemButtonArray objectAtIndex:oldSelectedIndex];
        [oldItemView setSelected:NO];
        [itemView setSelected:YES];
        
        CGFloat contentWidth = self.contentView.contentSize.width;
        CGFloat contentOffx = self.contentView.contentOffset.x;
        
        CGFloat minVisualX = contentOffx;
        CGFloat maxVisualX = minVisualX + self.contentView.frame.size.width > contentWidth ? contentWidth : minVisualX + self.contentView.frame.size.width;
        if (CGRectGetMaxX(itemView.frame) > maxVisualX || CGRectGetMinX(itemView.frame) < minVisualX)
        {
            CGFloat maxContentOffx = CGRectGetMaxX(itemView.frame) - self.contentView.frame.size.width < 0 ? 0 : CGRectGetMaxX(itemView.frame) - self.contentView.frame.size.width;
            [self.contentView setContentOffset:CGPointMake(maxContentOffx, itemView.frame.origin.y)  animated:YES];
        }
        
        if (!self.onlySelected)
        {
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
        self.onlySelected = NO;
    }
}

- (void)buttonTapped:(UIButton *)button
{
    NSUInteger selectedIndex = [self.itemButtonArray indexOfObject:button];
    [self setSelectedIndex:selectedIndex];
}

@end
