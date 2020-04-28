//
//  ZCCSegmentLabel.h
//  ZCC
//
//  Created by ZCc on 2019/8/21.
//  Copyright © 2019 laibu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZCCSegmentLabel : UILabel

@property (nonatomic, assign) BOOL isSelected; /**< 选中状态 */

- (instancetype)initWithFontSize:(CGFloat)fontSize
                  selectFontSize:(CGFloat)selectFontSize
                       textColor:(UIColor *)textColor
                   selectedColor:(UIColor *)selectedColor
                            text:(NSString *)text
                   textAlignment:(NSTextAlignment)textAlignment;

@end

NS_ASSUME_NONNULL_END
