//
//  TwoViewController.m
//  LisztTransitionAnimationExample
//
//  Created by LisztCoder on 2018/3/9.
//  Copyright © 2018年 http://www.lisztcoder.com. All rights reserved.
//

#import "TwoViewController.h"
#import "UIView+Snapshotting.h"

@interface TwoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /** 设置当前控制器背景 */
    [self.bgImageView setImage:[[self getPresentedViewController].view dt_takeSnapshot]];
    
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    /** 设置自定义导航栏高度 */
    CGRect headFrame = self.headView.frame;
    headFrame.size.height = [[UIApplication sharedApplication] statusBarFrame].size.height + 44;
    self.headView.frame = headFrame;
}

/** 点击按钮退出 */
- (IBAction)exitButtonAction:(id)sender {
    [self dismissMenuController];
}

/** 获取上一个控制器 */
- (UIViewController *)getPresentedViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

/** 正在滚动的时候 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(!scrollView.dragging)return;
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat alpha = offsetY/200;
    scrollView.backgroundColor = [UIColor colorWithRed:0/255.f green:0/255.f blue:0/255.f alpha:1 - -alpha];
}

/** 取消拖动的时候 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(-scrollView.contentOffset.y<120){
        [self showMenuController];
    }
    else{
        scrollView.backgroundColor = [UIColor clearColor];
        [self dismissMenuController];
    }
}

/** 显示当前控制器 */
- (void)showMenuController{
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), CGRectGetHeight(self.tableView.frame));
    }];
}

/** 退出当前控制器 */
- (void)dismissMenuController{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect tempFrame = self.tableView.frame;
        tempFrame.origin.y = self.tableView.bounds.size.height;
        self.tableView.frame = tempFrame;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

#pragma mark - <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 330;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
