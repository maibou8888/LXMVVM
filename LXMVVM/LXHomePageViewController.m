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
    
    NSMutableArray *viewControllers = [NSMutableArray array];
    LXViewController *firstVC  = [LXBusMediator viewControllerForURL:[NSURL URLWithString:@"productScheme://AA"]];
    LXViewController *secondVC = [LXBusMediator viewControllerForURL:[NSURL URLWithString:@"productScheme://BB"]];
    LXViewController *thirdVC  = [LXBusMediator viewControllerForURL:[NSURL URLWithString:@"productScheme://CC"]];
    
    if (firstVC) {
        UINavigationController *firstNavigationController = ({
            firstVC.title = @"页面1";
            UIImage *itemImage = [UIImage imageNamed:@"home_s.png"];
            firstVC.tabBarItem  = [[UITabBarItem alloc] initWithTitle:@"页面1" image:itemImage tag:1];
            [[UINavigationController alloc] initWithRootViewController:firstVC];
        });
        
        [viewControllers addObject:firstNavigationController];
    }
    
    if (secondVC) {
        UINavigationController *secondNavigationController = ({
            secondVC.title = @"页面2";
            UIImage *itemImage = [UIImage imageNamed:@"money_s.png"];
            secondVC.tabBarItem  = [[UITabBarItem alloc] initWithTitle:@"页面2" image:itemImage tag:2];
            [[UINavigationController alloc] initWithRootViewController:secondVC];
        });
        
        [viewControllers addObject:secondNavigationController];
    }
    
    if (thirdVC) {
        UINavigationController *thirdNavigationController = ({
            thirdVC.title = @"页面3";
            UIImage *itemImage = [UIImage imageNamed:@"mine_s.png"];
            thirdVC.tabBarItem  = [[UITabBarItem alloc] initWithTitle:@"页面3" image:itemImage tag:3];
            [[UINavigationController alloc] initWithRootViewController:thirdVC];
        });
        
        [viewControllers addObject:thirdNavigationController];
    }

    self.tabBarController.viewControllers = viewControllers;
    [LXDelegate.navigationControllerStack pushNavigationController:viewControllers.firstObject];
    
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
