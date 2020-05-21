//
//  ZCCCommonTool.h
//  ZCCSegmentView
//
//  Created by Laibu tech_2 on 2020/4/28.
//  Copyright © 2020 Laibu tech_2. All rights reserved.
//

#ifndef ZCCCommonTool_h
#define ZCCCommonTool_h

// 通知中心
#define ZCCNotificationCenter [NSNotificationCenter defaultCenter]
// 随机颜色
#define ZCCRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
//进制颜色 0x333333
#define HEXCOLOR(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]
// RGB颜色
#define ZCCRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// RGB颜色带透明度
#define ZCCRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

//灰色
#define ZCCGrayColor(a) ZCCRGBAColor(a,a,a,1.0)

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

#define Height_For_AppHeader  ([[UIApplication sharedApplication] statusBarFrame].size.height+44)
#define Height_For_StatusBar  [[UIApplication sharedApplication] statusBarFrame].size.height
#define Height_For_IphoneBottom   ((kScreenH>=812)?34:0)

#define kWidth(R) (R)*(kScreenW)/750.0
#define kHeight(R) (R)*(kScreenH)/667.0

// 字体
#define MFontRegular(size) [UIFont systemFontOfSize:(size) weight:UIFontWeightRegular]
#define MFontMedium(size) [UIFont systemFontOfSize:(size) weight:UIFontWeightMedium]
#define MFontSemibold(size) [UIFont systemFontOfSize:(size) weight:UIFontWeightSemibold]

//屏幕的高宽比(涉及到图片高度适配的时候使用)
#define kScreenHWRatio (kScreenHeight/kScreenWidth)
#define iPhoneX    ((int)(kScreenHWRatio * 100) == 216 ? YES : NO)
#define kStatusBarHeight (iPhoneX ? (44) : (20))
#define kNavBarHeight (kStatusBarHeight + 44)

#ifndef kScreenWidth
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#endif

#ifndef kScreenHeight
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#endif

#endif /* ZCCCommonTool_h */
