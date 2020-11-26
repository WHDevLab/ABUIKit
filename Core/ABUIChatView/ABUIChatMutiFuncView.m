//
//  ABUIChatMutiFuncView.m
//  ABUIKit
//
//  Created by qp on 2020/11/7.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIChatMutiFuncView.h"
#import "ABUIListView.h"
#import "ABUIListViewBaseItemView.h"
#import "ABUIChatConfirgure.h"
#import "UIView+AB.h"
#import "UIColor+AB.h"
@interface ABUIChatMutiFuncItemView : ABUIListViewBaseItemView
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation ABUIChatMutiFuncItemView
+(void)load {
    [[ABUIListViewMapping shared] registerClassString:@"ABUIChatMutiFuncItemView" native_id:@"mutifuncitem"];
}
- (void)setupAdjustContents {
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width*0.65, self.width*0.65)];
    self.imageView.backgroundColor = [UIColor whiteColor];
    self.imageView.layer.cornerRadius = 10;
    self.imageView.clipsToBounds = true;
    [self addSubview:self.imageView];
    
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.titleLabel.textColor = [UIColor hexColor:@"666666"];
    [self addSubview:self.titleLabel];
}

- (void)layoutAdjustContents {
    
    CGFloat top = (self.height-self.imageView.height-self.titleLabel.height)/2;
    self.imageView.top = top;
    self.imageView.centerX = self.width/2;
    
    self.titleLabel.top = self.imageView.bottom+5;
    self.titleLabel.centerX = self.width/2;
}

- (void)reload:(NSDictionary *)item {
    self.titleLabel.text = item[@"title"];
    [self.titleLabel sizeToFit];
    
    [self layoutAdjustContents];

}

@end

@interface ABUIChatMutiFuncView()<ABUIListViewDelegate>
@property (nonatomic, strong) ABUIListView *mainListView;
@property (nonatomic, strong) UIPageControl *bottomPageControl;
@end

@implementation ABUIChatMutiFuncView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat safeHeight = [ABUIChatConfirgure shared].safeHeight;
        self.backgroundColor = [UIColor hexColor:@"ededed"];
        
        self.mainListView = [[ABUIListView alloc] initWithFrame:self.bounds configure:[ABUIListViewConfigure hor]];
        [self addSubview:self.mainListView];
        self.mainListView.delegate = self;
        self.mainListView.collectionView.showsHorizontalScrollIndicator = false;
        self.mainListView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.mainListView.height = self.height-safeHeight-20;
        self.mainListView.top = 10;
        
        _bottomPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.mainListView.bottom, self.width, 20)];
        _bottomPageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _bottomPageControl.pageIndicatorTintColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
        _bottomPageControl.numberOfPages = 3;
        _bottomPageControl.pageIndicatorTintColor = [UIColor hexColor:@"dedede"];
        _bottomPageControl.currentPageIndicatorTintColor = [UIColor hexColor:@"999999"];
        [self addSubview:self.bottomPageControl];
        
        CGFloat w = floor(self.frame.size.width/4);
        CGFloat h = floor(self.mainListView.height/2);
        [self.mainListView setDataList:[ABUIChatConfirgure shared].mutiFuncDataList css:@{@"item.size.width":@(w), @"item.size.height":@(h)}];
    }
    return self;
}
- (void)listView:(ABUIListView *)listView onPageChanged:(int)page {
    self.bottomPageControl.currentPage = page;
}


- (void)listViewDidReload:(ABUIListView *)listView {
    self.bottomPageControl.numberOfPages = listView.collectionView.contentSize.width/listView.collectionView.width;
}
@end
