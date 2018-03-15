//
//  LX_Constant.h
//  LXMVVM
//
//  Created by Maser Wang on 2018/1/31.
//  Copyright © 2018年 maser. All rights reserved.
//

#ifndef LX_Constant_h
#define LX_Constant_h

//NSLOG
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif

//HUD
#define HUDText             @"加载中..."

//颜色
#define  tabbarColor        [UIColor colorWithRed:0/255.0     green:176/255.0    blue:214/255.0  alpha:1.0]
#define  tableBackColor     [UIColor colorWithRed:244/255.0   green:245/255.0    blue:246/255.0  alpha:1.0]
#define  cellSeperColor     [UIColor colorWithRed:235/255.0   green:236/255.0    blue:237/255.0  alpha:1.0]
#define  satisfyColor       [UIColor colorWithRed:253/255.0   green:155/255.0    blue:136/255.0 alpha:1.0]
#define  unSatisfyColor     [UIColor colorWithRed:216/255.0   green:216/255.0    blue:216/255.0 alpha:1.0]

//版本
#define isIOS7              [[[UIDevice currentDevice] systemVersion] floatValue]>=7.0? YES:NO
#define isIOS8              [[[UIDevice currentDevice] systemVersion] floatValue]>=8.0? YES:NO
#define iPhoneX             ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?\
                            CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

//常量
#define SW                  [UIScreen mainScreen].bounds.size.width
#define SH                  [UIScreen mainScreen].bounds.size.height

#define kStatusBarHeight    [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight       44.0
#define kTabBarHeight       (kStatusBarHeight > 20 ? 83 : 49)
#define kTopHeight          (kStatusBarHeight + kNavBarHeight)

#define CombineURL(str)     [NSString stringWithFormat:@"%@%@",BaseURL,str]
#define LXDelegate          ((AppDelegate *)[UIApplication sharedApplication].delegate)

//URL scheme
#define BaseURL             @"http://jk.jianong.com/api/"
#define CommentURL          @"Veterinary/getComment"
#define JianceURL           @"Srtc/getList"

#endif /* LX_Constant_h */
