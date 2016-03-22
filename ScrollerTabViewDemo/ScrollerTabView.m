//
//  ScrollerTabView.m
//  ScrollerTabViewDemo
//
//  Created by yangli on 22/3/16.
//  Copyright © 2016 liya. All rights reserved.
//

#import "ScrollerTabView.h"

#define DEFAULT_TAB_WIDTH       67

@interface ScrollerTabView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, strong) UIButton *preSelectedButton;

@property (nonatomic, strong) CAGradientLayer *rightGradientLayer;
@property (nonatomic, strong) CAGradientLayer *leftGradientLayer;

@end

@implementation ScrollerTabView

- (instancetype)initWithTitleArray:(NSArray *)titles frame:(CGRect)frame {
    if (titles == nil) {
        return nil;
    }
    _titleArray = titles;
    if (self = [self initWithFrame:frame]) {
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.scrollView];
        [self addButtonArray];
    }
    return self;
}

- (void)awakeFromNib {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.scrollView];
}

#pragma mark - Private

- (void)addButtonArray {
    
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray array];
    }
    for (UIButton *btn in _buttonArray) {
        [btn removeFromSuperview];
    }
    [_buttonArray removeAllObjects];
    
    for (int i = 0; i < self.titleArray.count; i ++) {
        
        UIButton *tab = [[UIButton alloc] init];
        [tab setBackgroundColor:[UIColor whiteColor]];
        NSString *title = self.titleArray[i];
        [tab setTitle:title forState:UIControlStateNormal];
        [tab setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        tab.titleLabel.font = [UIFont systemFontOfSize:14];
        [tab setBackgroundImage:[UIImage imageNamed:@"segment_normal"] forState:UIControlStateNormal];
        tab.tag = i;
        [tab addTarget:self action:@selector(tabPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonArray addObject:tab];
        [self.scrollView addSubview:tab];
        
        if (i == 0) {
            tab.frame = CGRectMake(0, 0, self.tabWidth > 0 ? self.tabWidth : DEFAULT_TAB_WIDTH, self.frame.size.height);
        }
        else {
            tab.frame = CGRectMake(i * (self.tabWidth > 0 ? self.tabWidth : DEFAULT_TAB_WIDTH), 0, self.tabWidth > 0 ? self.tabWidth : DEFAULT_TAB_WIDTH, self.frame.size.height);
        }
    }
    self.scrollView.contentSize = CGSizeMake((self.tabWidth > 0 ? self.tabWidth : DEFAULT_TAB_WIDTH) * self.titleArray.count, self.frame.size.height);
    [self layoutIfNeeded];
    
    [self.layer addSublayer:self.rightGradientLayer];
    [self.layer addSublayer:self.leftGradientLayer];
    
    [self tabExchanged:_tabIndex];
}

- (IBAction)tabPressed:(UIButton *)sender {
    [self tabExchanged:sender.tag];
    [self.tabDelegate tabClicked:self index:sender.tag];
}

- (void)tabExchanged:(NSInteger )index {
    UIButton *btn = self.buttonArray[index];
    if (self.selectedButton == nil) {
        self.selectedButton = btn;
    }
    if (self.selectedButton != btn) {
        self.preSelectedButton = self.selectedButton;
        self.selectedButton = btn;
    }
    if (self.selectedButton) {
        [self.selectedButton setBackgroundImage:[UIImage imageNamed:@"segment_selected"] forState:UIControlStateNormal];
    }
    if (self.preSelectedButton) {
        [self.preSelectedButton setBackgroundImage:[UIImage imageNamed:@"segment_normal"] forState:UIControlStateNormal];
    }
    
    CGFloat middleDistance = (btn.center.x - self.scrollView.contentOffset.x - self.frame.size.width / 2);
    CGFloat rightMarginDistance = (self.scrollView.contentSize.width - self.scrollView.contentOffset.x - self.frame.size.width);
    CGFloat offsetDistance = middleDistance < rightMarginDistance ? middleDistance : rightMarginDistance;
    if (middleDistance > 0) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + offsetDistance, 0) animated:YES];
    }
    else {
        CGFloat leftMarginDistance = self.scrollView.contentOffset.x;
        offsetDistance = - (leftMarginDistance < fabs(middleDistance) ? leftMarginDistance : fabs(middleDistance));
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + offsetDistance, 0) animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.scrollView.contentOffset.x <= 0) {
        self.leftGradientLayer.hidden = YES;
    }
    else {
        self.leftGradientLayer.hidden = NO;
    }
    if (self.scrollView.contentSize.width - self.scrollView.contentOffset.x - self.frame.size.width > 0) {
        self.rightGradientLayer.hidden = NO;
    }
    else {
        self.rightGradientLayer.hidden = YES;
    }
}

- (void)setTabIndex:(NSInteger)tabIndex {
    _tabIndex = tabIndex;
    [self tabExchanged:tabIndex];
}

- (void)setTabWidth:(float)tabWidth {
    _tabWidth = tabWidth;
    [self addButtonArray];
    [self tabExchanged:_tabIndex];
}

#pragma mark - getter

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.frame = self.frame;
    }
    return _scrollView;
}

- (CAGradientLayer *)rightGradientLayer {
    if (_rightGradientLayer == nil) {
        _rightGradientLayer = [CAGradientLayer layer];
        _rightGradientLayer.frame = CGRectMake(self.frame.size.width - 10, 0, 10, self.frame.size.height);
        _rightGradientLayer.colors = @[(__bridge id)[UIColor colorWithWhite:1.0 alpha:0.5].CGColor,
                                       (__bridge id)[UIColor whiteColor].CGColor];
        _rightGradientLayer.locations = @[@(0.2f),@(0.8f)];
        _rightGradientLayer.startPoint = CGPointMake(0, 0);
        _rightGradientLayer.endPoint = CGPointMake(1, 0);
    }
    return _rightGradientLayer;
}

- (CAGradientLayer *)leftGradientLayer {
    if (_leftGradientLayer == nil) {
        _leftGradientLayer = [CAGradientLayer layer];
        _leftGradientLayer.frame = CGRectMake(0, 0, 10, self.frame.size.height);
        _leftGradientLayer.colors = @[(__bridge id)[UIColor whiteColor].CGColor,
                                      (__bridge id)[UIColor colorWithWhite:1.0 alpha:0.5].CGColor];
        _leftGradientLayer.locations = @[@(0.2f),@(0.8f)];
        _leftGradientLayer.startPoint = CGPointMake(0, 0);
        _leftGradientLayer.endPoint = CGPointMake(1, 0);
        _leftGradientLayer.hidden = YES;
    }
    return _leftGradientLayer;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
