//
//  ZCCSegmentView.h
//  ZCC
//
//  Created by ZCc on 2019/8/21.
//  Copyright © 2019 laibu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZCCSegmentViewDelegate <NSObject>

- (void)segmentLabelTapedIndex:(NSInteger)index;

@end

@interface ZCCSegmentView : UIView
@property (nonatomic, strong, readonly) NSMutableArray *labelTagsArray;
@property (nonatomic, weak) id<ZCCSegmentViewDelegate> delegate;


/// 初始化
/// @param segmentsList 标题数组
/// @param margin 间距
- (instancetype)initWithSegmentsArray:(NSArray *)segmentsList margin:(CGFloat)margin;


/// 初始化
/// @param segmentsList 标题数组
/// @param selectedIcon 选中之后右上角小图标效果
/// @param margin 间距
/// @param normalFontSize 默认字体
/// @param selectFontSize 选中字体
- (instancetype)initWithSegmentsArray:(NSArray *)segmentsList
                          seletedIcon:(nullable UIImage *)selectedIcon
                               margin:(CGFloat)margin
                       normalFontSize:(CGFloat)normalFontSize
                       selectFontSize:(CGFloat)selectFontSize;

/// 获得当前选中分段tag
- (NSInteger)getCurrentSelectIndex; /**< 获得当前选中的tag */

/// 获得整个segment的size
- (CGSize)getSegmentViewSize;// 获得当前view尺寸

/// 选中某个 分段
/// @param index 选中
- (void)segmentSelectIndex:(NSInteger)index; //被动选中

/// 更新滚动
/// @param offsetX 下面滚动的距离
- (void)updateSliderBarWithScrollViewOffserX:(CGFloat)offsetX;// 更新滚动

@end

NS_ASSUME_NONNULL_END
