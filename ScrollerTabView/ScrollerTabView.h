//
//  ScrollerTabView.h
//  ScrollerTabViewDemo
//
//  Created by yangli on 22/3/16.
//  Copyright © 2016 liya. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScrollerTabView;

@protocol ScrollTabViewDelegate <NSObject>

@optional
- (void)tabClicked:(ScrollerTabView *)scrollTabView index:(NSInteger)index;

@end

@interface ScrollerTabView : UIView

@property (nonatomic, assign) NSInteger tabIndex;
@property (nonatomic, weak) id<ScrollTabViewDelegate> tabDelegate;
@property (nonatomic, assign) float tabWidth;

- (instancetype)initWithTitleArray:(NSArray *)titles frame:(CGRect)frame;

@end
