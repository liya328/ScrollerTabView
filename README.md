# ScrollerTabView
可滚动的tab切换空间，并且可居中滚动，左右两边还有虚化效果

## Usage
<pre><code>
self.titleScrollTabView = [[ScrollerTabView alloc] initWithTitleArray:@[@"title0",@"title1",@"title2",@"title3",@"title4",@"title5",@"title6",@"title7",@"title8"] frame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
self.titleScrollTabView.tabDelegate = self;
self.titleScrollTabView.tabIndex = 3;
[self.view addSubview:self.titleScrollTabView];
//self.titleScrollTabView.tabWidth = 90;    //可以设置tab的宽度
</pre></code>
