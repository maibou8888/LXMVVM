//
//  HomePageViewController.m
//  LXMVVM
//
//  Created by 王明哲 on 16/1/9.
//  Copyright © 2016年 王明哲. All rights reserved.
//

#import "LXHomePageViewController.h"
#import "HomePageViewModel.h"

@interface LXHomePageViewController ()

@property (nonatomic, strong) HomePageViewModel *homeViewModel;

@end

@implementation LXHomePageViewController

-(instancetype)initWithViewModel:(id<LXViewModelProtocol>)viewModel {
    self = [super init];
    if (self) {
        self.homeViewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationController *firstNavigationController = ({
        LXViewController *firstVC = [LXBusMediator viewControllerForURL:[NSURL URLWithString:@"productScheme://AA"]];
        firstVC.title = @"页面1";
        UIImage *itemImage = [UIImage imageNamed:@"home_s.png"];
        firstVC.tabBarItem  = [[UITabBarItem alloc] initWithTitle:@"页面1" image:itemImage tag:1];
        
        [[UINavigationController alloc] initWithRootViewController:firstVC];
    });
    
    UINavigationController *secondNavigationController = ({
        LXViewController *secondVC = [LXBusMediator viewControllerForURL:[NSURL URLWithString:@"productScheme://BB"]];
        
        secondVC.title = @"页面2";
        UIImage *itemImage = [UIImage imageNamed:@"money_s.png"];
        secondVC.tabBarItem  = [[UITabBarItem alloc] initWithTitle:@"页面2" image:itemImage tag:2];
        
        [[UINavigationController alloc] initWithRootViewController:secondVC];
    });

    
    UINavigationController *thirdNavigationController = ({
        LXViewController *thirdVC = [LXBusMediator viewControllerForURL:[NSURL URLWithString:@"productScheme://CC"]];
        
        thirdVC.title = @"页面3";
        UIImage *itemImage = [UIImage imageNamed:@"mine_s.png"];
        thirdVC.tabBarItem  = [[UITabBarItem alloc] initWithTitle:@"页面3" image:itemImage tag:3];
        
        [[UINavigationController alloc] initWithRootViewController:thirdVC];
    });

    self.tabBarController.viewControllers = @[firstNavigationController, secondNavigationController,thirdNavigationController];
    [LXDelegate.navigationControllerStack pushNavigationController:firstNavigationController];
    
    [[self
      rac_signalForSelector:@selector(tabBarController:didSelectViewController:)
      fromProtocol:@protocol(UITabBarControllerDelegate)]
     subscribeNext:^(RACTuple *tuple) {
         [LXDelegate.navigationControllerStack popNavigationController];
         [LXDelegate.navigationControllerStack pushNavigationController:tuple.second];
     }];
    
    [self.tabBarController.tabBar setTintColor:tabbarColor];
    self.tabBarController.delegate = self;
}

@end
