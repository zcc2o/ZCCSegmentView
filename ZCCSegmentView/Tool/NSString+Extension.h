//
//  NSString+Extension.h
//  ZCCSegmentView
//
//  Created by Laibu tech_2 on 2020/4/28.
//  Copyright © 2020 Laibu tech_2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extension)

/**
 根据字体大小 返回文本宽高
 
 @param font 字体
 @param maxSize 最大size
 */
- (CGSize)sizewithFont:(UIFont *)font andMaxSize:(CGSize)maxSize;

@end

NS_ASSUME_NONNULL_END
