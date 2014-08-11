//
//  WGLoginAndRegisterViewController.m
//  WGLogin
//
//  Created by 王刚 on 14/8/9.
//  Copyright (c) 2014年 wwwlife. All rights reserved.
//

#import "WGLoginAndRegisterViewController.h"
#import "WGLoginTableView.h"

@interface WGLoginAndRegisterViewController () <UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *tableViews;

@property (nonatomic, weak) IBOutlet UIButton *toRegisterBtn;
@property (nonatomic, weak) IBOutlet UIButton *backBtn;

@end

@implementation WGLoginAndRegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _setupScrollView];
    [self.backBtn setHidden:YES];
    [self _addTapGesture:self.view];
}


#pragma mark private methods
#pragma scrollView methods
- (void)_setupScrollView {
    
    NSUInteger numberPages = 2;
    
    NSMutableArray *views = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < numberPages; i++)
    {
		[views addObject:[NSNull null]];
    }
    self.tableViews = views;
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize =
    CGSizeMake(CGRectGetWidth(self.scrollView.frame) * numberPages, CGRectGetHeight(self.scrollView.frame));
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.scrollEnabled = NO;
    
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
    
    
}


- (void)loadScrollViewWithPage:(NSUInteger)page
{
    if (page >= 2)
        return;
    // 替换view
    WGLoginTableView *view = [self.tableViews objectAtIndex:page];
    if ((NSNull *)view == [NSNull null]) {
        view = [[WGLoginTableView alloc]initWithType:page];
        
        [self.tableViews replaceObjectAtIndex:page withObject:view];
    }
    
    // 把view添加到scrollview
    if (view.superview == nil)
    {
        CGRect frame = self.scrollView.frame;
        frame.origin.x = self.scrollView.frame.size.width * page;
        frame.origin.y = 0;
        view.frame = frame;
        [self.scrollView addSubview:view];
    }
}


- (IBAction)toRegisterView:(id)sender {
    
    //刷新注册tableview
    WGLoginTableView *view = [self.tableViews objectAtIndex:RegisterType];
    [view reloadData];
    
    self.backBtn.alpha = 0.0;
    [UIView animateWithDuration:0.3 animations:^{
        self.toRegisterBtn.alpha = 0.0;
        self.backBtn.alpha = 0.9;
        [self.scrollView setContentOffset:CGPointMake(320, 0)];
    } completion:^(BOOL finished) {
        [self.toRegisterBtn setHidden:YES];
        [self.backBtn setHidden:NO];
        
    }];
    
    
    
}

- (IBAction)backToLoginView:(id)sender {
    
    //刷新登陆tableview 
    WGLoginTableView *view = [self.tableViews objectAtIndex:LoginType];
    [view reloadData];
    
    self.toRegisterBtn.alpha = 0.0;
    [UIView animateWithDuration:0.3 animations:^{
        self.toRegisterBtn.alpha = 0.9;
        self.backBtn.alpha = 0.0;
       [self.scrollView setContentOffset:CGPointMake(0, 0)];
    } completion:^(BOOL finished) {
        [self.backBtn setHidden:YES];
        [self.toRegisterBtn setHidden:NO];
        
    }];
}



- (void)_addTapGesture:(UIView *)view {
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    [view setUserInteractionEnabled:YES];
    [view addGestureRecognizer:gesture];
}
- (void)tapView:(UITapGestureRecognizer *)gesture {
    WGLoginTableView *view;
    if (self.scrollView.contentOffset.x == 0) {
        view = [self.tableViews objectAtIndex:LoginType];
    } else {
        view = [self.tableViews objectAtIndex:RegisterType];
    }
    
    [view.currEdidTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
