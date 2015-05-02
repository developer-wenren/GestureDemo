//
//  ViewController.m
//  GestureDemo
//
//  Created by zjsruxxxy3 on 15/5/2.
//  Copyright (c) 2015年 WR. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>
{
    UIMenuController *_menuC;
    
}
@property(nonatomic,weak)UIView *destView;

@property(nonatomic,strong)UIPanGestureRecognizer *pan;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setUpView];
    
//    [self addTapGestures];
    
    [self addLongPressGesture];
    
    [self addPanGesture];
}

-(void)setUpView
{
    UIView *view= [[UIView alloc]init];
    
    view.bounds = CGRectMake(0, 0, 120, 150);
    
    view.backgroundColor = [UIColor grayColor];
    
    view.center = CGPointMake(self.view.bounds.size.width*.5, 300);
    
    [self.view addSubview:view];
    
    self.destView = view;
    
}

-(void)addLongPressGesture
{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    
    longPress.delaysTouchesBegan = YES;
    
    [self.destView addGestureRecognizer:longPress];
    
}

-(void)addPanGesture
{
    self.pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(makePan:)];

    [self.destView addGestureRecognizer:self.pan];
    
    self.pan.delegate = self;
    self.pan.cancelsTouchesInView = NO;
    
    self.pan.delaysTouchesBegan = YES;
    
}
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return [super canPerformAction:action withSender:sender];
}

-(void)makePan:(UIPanGestureRecognizer *)gr
{
//    NSLog(@"%s",__func__);
    // 支持 change状态
    CGPoint translation = [gr translationInView:self.destView];
    
    NSLog(@"%@",NSStringFromCGPoint(translation));

    
    
}

// 两个手势 同时被识别
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (gestureRecognizer == self.pan)
    {
        return YES;
    }
    
    return NO;
}

-(void)longPress:(UILongPressGestureRecognizer *)gr
{
    
    CGPoint point = [gr locationInView:self.destView];
    
//    NSLog(@"%@",NSStringFromCGPoint(point));
    
    switch (gr.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            [self addMenuController];

        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            [_menuC setMenuVisible:NO animated:YES];
        }
            break;
   
        default:
            break;
            // 没有 change state 只有locate
    }
}

-(void)addTapGestures
{
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
    
    doubleTap.numberOfTapsRequired = 2;
    
    doubleTap.delaysTouchesBegan = YES;

    [self.destView addGestureRecognizer:doubleTap];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
    
    /**
     *Creates a dependency relationship between the receiver and another gesture recognizer.
     */
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    singleTap.delaysTouchesBegan = YES;
    
    [self.destView addGestureRecognizer:singleTap];
    
}

-(void)doubleTap:(UIGestureRecognizer *)gr
{
    NSLog(@"%s",__func__);
    
   
    [self addMenuController];
//    UIGestureRecognizerStatePossible

}

-(void)addMenuController
{
    [self.destView becomeFirstResponder];
    
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    
    /**
     *     SEL 方法不实现 item不会显示 （delete，copy 方法自动生成对应item）
     */
    UIMenuItem *dada = [[UIMenuItem alloc]initWithTitle:@"dada" action:@selector(dada:)];
    
    UIMenuItem *delete = [[UIMenuItem alloc]initWithTitle:@"haha" action:@selector(haha:)];
    
    menuController.menuItems = @[delete,dada];
    menuController.arrowDirection = UIMenuControllerArrowUp;
    
    [menuController setTargetRect:CGRectMake(0, 0, 0, 0) inView:self.destView];
    
    [menuController setMenuVisible:YES animated:YES];
    
    _menuC = menuController;
    
}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

-(void)haha:(UIMenuItem *)menuItem
{
    NSLog(@"%s",__func__);

}

-(void)dada:(UIMenuItem *)menuItem
{
    NSLog(@"%s",__func__);

}

-(void)singleTap:(UIGestureRecognizer *)gr
{
    NSLog(@"%s",__func__);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__func__);
}

@end
