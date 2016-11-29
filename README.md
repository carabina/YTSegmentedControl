# YTSegmentedControl
a custom sliding segmented control

Examples:
----

UIAppearance setting
```
UIImage *selectedImage = [[UIImage imageNamed:@"segmented_selected"] stretchableImageWithLeftCapWidth:[UIImage imageNamed:@"segmented_selected"].size.width/2 topCapHeight:[UIImage imageNamed:@"segmented_selected"].size.height/2];
UIImage *unSelectedImage = [[UIImage imageNamed:@"segmented_bg"] stretchableImageWithLeftCapWidth:[UIImage imageNamed:@"segmented_bg"].size.width/2 topCapHeight:[UIImage imageNamed:@"segmented_bg"].size.height/2];
[[YTSegmentedControl appearance] setSelectedItemBgImage:selectedImage];
[[YTSegmentedControl appearance] setNormalItemBgImage:unSelectedImage];
[[YTSegmentedControl appearance] setNormalAttributeDictionary:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:[UIColor blueColor]}];
[[YTSegmentedControl appearance] setSelectedAttributeDictionary:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:[UIColor grayColor]}];
[[YTSegmentedControl appearance] setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
[[YTSegmentedControl appearance] setItemWidth:80];

```

Use way:
----
```
YTSegmentedItem *item = [[YTSegmentedItem alloc] initWithTitle:@"zero" image:nil];
YTSegmentedItem *item2 = [[YTSegmentedItem alloc] initWithTitle:@"one" image:nil];
YTSegmentedItem *item3 = [[YTSegmentedItem alloc] initWithTitle:@"two" image:nil];
YTSegmentedItem *item4 = [[YTSegmentedItem alloc] initWithTitle:@"three" image:nil];

YTSegmentedControl *segmentedControl = [[YTSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:item, item2, item3, item4, nil]];
segmentedControl.frame = CGRectMake(10, 40, 200, 50);
[segmentedControl addTarget:self action:@selector(segmentedControlSelected:) forControlEvents:UIControlEventValueChanged];
[self.view addSubview:segmentedControl];
```
