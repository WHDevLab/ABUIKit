//
//  ABUIListViewFlowLayout.m
//  ABUIKit
//
//  Created by qp on 2020/9/26.
//  Copyright © 2020 abteam. All rights reserved.
//

#import "ABUIListViewFlowLayout.h"
#import "ABUIListViewHelper.h"
static NSString *kDecorationReuseIdentifier = @"section_background";
static NSString *kCellReuseIdentifier = @"view_cell";
@implementation ABUICollectionViewLayoutAttributes

@end

@implementation ABUIListViewDecorationView
- (void)applyLayoutAttributes:(ABUICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    self.backgroundColor = layoutAttributes.color;
}
@end

@implementation ABUIListViewFlowLayout

- (instancetype)initWithConfigure:(ABUIListViewConfigure *)configure
{
    self = [super init];
    if (self) {
        self.configure = configure;
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    [self registerClass:[ABUIListViewDecorationView class] forDecorationViewOfKind:kDecorationReuseIdentifier];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    if (self.configure.sectionColor != nil) {
        NSMutableArray *allAttributes = [NSMutableArray arrayWithArray:attributes];
        
        NSInteger sections = [self.collectionView numberOfSections];
        for (NSInteger section = 0; section < sections; section++) {
            NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
            if (numberOfItems > 0) {
                UICollectionViewLayoutAttributes *firstAttr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
                CGRect firstFrame = firstAttr.frame;

                UICollectionViewLayoutAttributes *lastAttr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:(numberOfItems - 1) inSection:section]];
                CGRect lastFrame = lastAttr.frame;

                CGFloat height = lastFrame.origin.y-firstFrame.origin.y+lastFrame.size.height;
                CGRect sectionFrame = CGRectMake(self.collectionView.contentInset.left, firstFrame.origin.y, self.collectionView.frame.size.width, height);
                
                ABUICollectionViewLayoutAttributes *decorationAttributes =
                [ABUICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:kDecorationReuseIdentifier
                                                                            withIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
                decorationAttributes.frame = sectionFrame;
                decorationAttributes.zIndex = -1;
                decorationAttributes.color = self.configure.sectionColor;

                // Add the attribute to the list
                [allAttributes addObject:decorationAttributes];
                
            }
        }
        return allAttributes;
    }
    return attributes;
}

@end
