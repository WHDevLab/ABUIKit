# Installation
ABUIKit supports multiple methods for installing the library in a project.
### Installation with CocoaPods
```
pod 'ABUIKit', :git => "https://github.com/whdevlab/ABUIKit"
```
# Usage
### ABUIListView
使用配置文件驱动的列表视图

##### 创建一个itemView继承自ABUIListViewBaseItemView,并为其绑定一个全局唯一的视图ID

ABUIListView001ItemView.h

```
#import "ABUIListViewBaseItemView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ABUIListView001ItemView : ABUIListViewBaseItemView
@property (nonatomic, strong) UILabel *titleLabel;
@end
```

ABUIListView001ItemView.m

```
#import "ABUIListView001ItemView.h"

@implementation ABUIListView001ItemView
+ (void)load {
    // 注册当前View的ID到ABUIListViewMapping中
    [[ABUIListViewMapping shared] registerClassString:@"ABUIListView001ItemView" native_id:@"ablist_item_001"];
}
- (void)setupAdjustContents { //调用时机同init
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.textColor = [UIColor hexColor:@"#292B32"];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.titleLabel];
}

- (void)layoutAdjustContents { //调用时机同layoutsubview
    self.titleLabel.left = 15;
    self.titleLabel.centerY = self.height/2;
}

- (void)reload:(NSDictionary *)item { //当前视图对应的数据
    self.titleLabel.text = item[@"data.title"];
    if (item[@"css.font"] != nil) {
        self.titleLabel.font = item[@"css.title.font"];
    }
    if (item[@"css.color"] != nil) {
        self.titleLabel.textColor = item[@"css.title.color"];
    }
    [self.titleLabel sizeToFit];
}

@end
```

##### 创建ABUIListView对象
native_id: 需要展示当前行数据的对应viewid

```
self.mainListView = [[ABUIListView alloc] initWithFrame:self.view.bounds];
self.mainListView.delegate = self;
[self.view addSubview:self.mainListView];

NSArray *dataList = @[
	@{
		@"native_id":@"abuilist_item_001",
		@"data.title":@"设置"
	},
	@{
		@"native_id":@"abuilist_item_001",
		@"data.title":@"卡包"
	}
];
[self.mainListView setDataList:dataList css:@{
	@"item.size.height":@(50), //行高
	@"item.rowSpacing":@(1),//行间距
}];
```
