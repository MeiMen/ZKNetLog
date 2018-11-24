//
//  ZKShowNetLogView.m
 
//
//  Created by ZK-2 on 2018/8/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ZKShowNetLogView.h"
#import "ZKNetLogListVC.h"
#import "ZKNetLogHeader.h"
@interface ZKShowNetLogView()

@property (nonatomic, assign) CGPoint starPoint;
@property (assign, nonatomic) BOOL showing; /**<  */
@end

@implementation ZKShowNetLogView

+ (void)showLogViewInView:(UIView *)view {

    ZKShowNetLogView *show = nil;
    show = [[ZKShowNetLogView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-60-20, kStatusBarHeight+1, 60, 25)];
    show.tag = 100;
    show.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    show.layer.cornerRadius = 4;
    show.layer.masksToBounds = YES;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 60, 25);
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [btn setTitle:@"show log" forState:UIControlStateNormal];
    [show addSubview:btn];
    [btn addTarget:show action:@selector(showLogViewCallback:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:show];
}

- (void)showLogViewCallback:(UIButton*)sender {
    if (self.showing) {
        [[UIViewController currentViewController] dismissViewControllerAnimated:YES completion:^{
            [sender setTitle:@"show log" forState:UIControlStateNormal];
            self.showing = NO;
        }];
        return;
    }
    ;
    [[UIViewController currentViewController] presentViewController:[[ZKNetLogListVC alloc] init] animated:YES completion:^{
        [sender setTitle:@"close" forState:UIControlStateNormal];
        self.showing = YES;
    }];
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandle:)];
        [self addGestureRecognizer:panGesture];
    }
    return self;
}

-(void)panHandle:(UIPanGestureRecognizer *)panGesture{
    //    CGPoint translation = [panGesture translationInView:self];
    CGPoint translation = [panGesture locationInView:self];
    
    CGRect frame = self.frame;
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            self.starPoint = [panGesture locationInView:self];;
            break;
        case UIGestureRecognizerStateChanged:
            if (translation.x - self.starPoint.x +  frame.origin.x >= 0 && translation.x - self.starPoint.x + frame.origin.x <= SCREEN_WIDTH - self.frame.size.width) {
                frame.origin.x = translation.x +  frame.origin.x - self.starPoint.x;
            }
            if (translation.y - self.starPoint.y +  frame.origin.y >= 0 && translation.y - self.starPoint.y + frame.origin.y <= SCREEN_HEIGHT - self.frame.size.width) {
                frame.origin.y = translation.y +  frame.origin.y - self.starPoint.y;
            }
            self.frame = frame;
            break;
        default:
            break;
    }
}


@end
