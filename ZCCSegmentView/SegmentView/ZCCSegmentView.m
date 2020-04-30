//
//  ZCCSegmentView.m
//  ZCC
//
//  Created by ZCc on 2019/8/21.
//  Copyright © 2019 laibu. All rights reserved.
//

#import "ZCCSegmentView.h"
#import "ZCCSegmentLabel.h"
//#import "NSString+Extension.h"
@interface ZCCSegmentView ()

@property (nonatomic, strong) NSMutableArray *labelTagsArray;
@property (nonatomic, strong) NSMutableArray *labelSizeArray;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) CGFloat margin;
@property (nonatomic, strong) UIImage *selectIcon;
@property (nonatomic, assign) CGFloat normalFontSize; /**< 默认情况选中字体大小 */
@property (nonatomic, assign) CGFloat selectFontSize; /**< 默认情况选中字体大小 */
@property (nonatomic, strong) UIImageView *flowerIconView;
@property (nonatomic, strong) UIView *focusSliderBar;
@property (nonatomic, weak) ZCCSegmentLabel *currentSelectedLabel; //当前选中的label
@end

@implementation ZCCSegmentView

- (instancetype)initWithSegmentsArray:(NSArray *)segmentsList margin:(CGFloat)margin {
    return [self initWithSegmentsArray:segmentsList seletedIcon:nil margin:margin normalFontSize:kWidth(30) selectFontSize:kWidth(30 + 14)];
}

- (instancetype)initWithSegmentsArray:(NSArray *)segmentsList
                          seletedIcon:(UIImage *)selectedIcon
                               margin:(CGFloat)margin
                       normalFontSize:(CGFloat)normalFontSize
                       selectFontSize:(CGFloat)selectFontSize {
    if (self = [super init]) {
        _margin = margin;
        _normalFontSize = normalFontSize;
        _selectFontSize = selectFontSize;
        if (segmentsList.count > 0) {
            [self loadSubViewsWithArray:segmentsList];
        }
    }
    return self;
}

- (void)loadSubViewsWithArray:(NSArray *)segments {
    _labelTagsArray = [NSMutableArray array];
    _labelSizeArray = [NSMutableArray array];
    NSInteger i = 0;
    ZCCSegmentLabel *lastLabel;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = 0;
    CGFloat height = 0;
    for (NSString * segment in segments) {
        ZCCSegmentLabel *segLabel = [[ZCCSegmentLabel alloc] initWithFontSize:_selectFontSize selectFontSize:_selectFontSize textColor:ZCCRGBColor(160, 160, 160) selectedColor:ZCCRGBColor(68, 68, 68) text:segment textAlignment:NSTextAlignmentCenter];
        // 计算frame
        if (lastLabel == nil) {
            x = 0;
            segLabel.isSelected = YES;
        } else {
            x = CGRectGetMaxX(lastLabel.frame) + _margin;
        }
        y = kWidth(22);
        // 按照最大字体计算
        CGSize labelSize = [segment sizewithFont:MFontSemibold(_selectFontSize) andMaxSize:CGSizeMake(MAXFLOAT, _selectFontSize)];
        NSValue *labelSizeValue = [NSValue valueWithCGSize:labelSize];
        width = labelSize.width;
        height = kWidth(46);
        segLabel.frame = CGRectMake(x, y, width, height);
        // 增加标记
        segLabel.tag = i;
        // 添加事件
        segLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(segLabelTaped:)];
        [segLabel addGestureRecognizer:tapGesture];
        [self addSubview:segLabel];
        [_labelTagsArray addObject:segLabel];
        [_labelSizeArray addObject:labelSizeValue];
        lastLabel = segLabel;
        i ++;
    }
    ZCCSegmentLabel *firstLabel = self.labelTagsArray.firstObject;
    [self addSubview:self.flowerIconView];
    self.flowerIconView.frame = CGRectMake(CGRectGetMaxX(firstLabel.frame) - kWidth(10), 0, kWidth(37), kWidth(28));
    
    _focusSliderBar = [[UIImageView alloc] init];
    _focusSliderBar.frame = CGRectMake(0, CGRectGetMaxY(firstLabel.frame) + kWidth(10), kWidth(60), kWidth(8));
    _focusSliderBar.backgroundColor = ZCCRGBColor(93, 117, 224);
    _focusSliderBar.layer.masksToBounds = true;
    _focusSliderBar.layer.cornerRadius = kWidth(4);
    [self addSubview:_focusSliderBar];
    _focusSliderBar.centerX = firstLabel.centerX;
}

- (CGSize)getSegmentViewSize {
    ZCCSegmentLabel *lastLabel = self.labelTagsArray.lastObject;
    return CGSizeMake(CGRectGetMaxX(lastLabel.frame) + kWidth(20), CGRectGetMaxY(self.focusSliderBar.frame) + kWidth(2));
}

- (NSInteger)getCurrentSelectIndex {
    for (ZCCSegmentLabel *segLabel in self.labelTagsArray) {
        if (segLabel.isSelected) {
            return segLabel.tag;
            break;
        }
    }
    return 0;
}

#pragma mark - 随scrollView offset被选中
- (void)segmentSelectIndex:(NSInteger)index {
    for (ZCCSegmentLabel *segLabel in self.labelTagsArray) {
        // 先判断 当前index 是否就是 点击的index
        if (index == segLabel.tag) {
            if (segLabel.tag == 0) {
                self.flowerIconView.frame = CGRectMake(CGRectGetMaxX(segLabel.frame) - kWidth(10), 0, kWidth(37), kWidth(28));
                [UIView animateWithDuration:0.1 animations:^{
                    self.flowerIconView.alpha = 1;
                }];
            }
            if (segLabel.isSelected == YES) {
                return;
            }
            segLabel.isSelected = YES;
        } else {
            // index = 0的时候 必须高亮
            if (segLabel.isSelected == YES && index != 0) {
                [UIView animateWithDuration:0.1 animations:^{
                    self.flowerIconView.alpha = 0;
                }];
            }
            segLabel.isSelected = NO;
        }
    }
}

// 根据下一个label 动态获取将要滚动的距离
- (void)updateSliderBarWithScrollViewOffserX:(CGFloat)offsetX scrollViewWidth:(CGFloat)viewWidth {
    if (viewWidth == 0) {
        return ;
    }
    // offsetX 除 kscrrenwidth
    NSNumber *offsetNum = [NSNumber numberWithFloat:offsetX];
    NSInteger offsetInteger = [offsetNum integerValue];
    NSInteger screenWidthInteger = [[NSNumber numberWithFloat:viewWidth] integerValue];
    NSInteger currentIndex = offsetInteger / screenWidthInteger;
    ZCCSegmentLabel *label;
    
    // 滑块长度不变
    if (currentIndex < 0) {
        NSLog(@"currentIndex < 0。最左边 currentIndex = %ld", currentIndex);
        currentIndex = 0;
        label = self.labelTagsArray[currentIndex];
        self.focusSliderBar.centerX = label.centerX + (offsetX / viewWidth) * kWidth(80);
    } else if (currentIndex >= self.labelTagsArray.count - 1) {
        NSLog(@"currentIndex >= self.labelTagsArray.count - 1 最右边 currentIndex = %ld", currentIndex);
        currentIndex = self.labelTagsArray.count - 1;
        label = self.labelTagsArray[currentIndex];
        CGFloat pageOffsetX = offsetInteger % screenWidthInteger;
        self.focusSliderBar.centerX = label.centerX + (pageOffsetX / viewWidth) * kWidth(80);
    } else {
        NSLog(@"currentIndex < self.labelTagsArray.count - 1  currentIndex >=0  中间位置 currentIndex = %ld", currentIndex);
        label = self.labelTagsArray[currentIndex];
        ZCCSegmentLabel *nextLabel = self.labelTagsArray[currentIndex + 1];
        CGFloat pageOffsetX = offsetInteger % screenWidthInteger;
        self.focusSliderBar.centerX = label.centerX + (pageOffsetX / viewWidth) * (nextLabel.centerX - label.centerX);
    }
#warning  ————————————————————————————— 滑块长度和label文本相同的方式 ——————————————————————————————
    // 滑块长度和label文本相同的方式
    // 左边label  leftLabel = label currentIndex
    // 右边label  rightLabel = self.labelTagsArray(currentIndex + 1)
    CGFloat pageOffsetX = offsetInteger % screenWidthInteger;
    ZCCSegmentLabel *nextLabel = nil;
    NSValue *leftLabelSizeValue = nil;
    CGSize leftLabelSize = CGSizeZero;
    NSValue *rightLabelSizeValue = nil;
    CGSize rightLabelSize = CGSizeZero;
    CGFloat sliderWidth = 0;
    CGFloat sliderCenterX = 0;
    if (currentIndex < 0) {
        currentIndex = 0;
        nextLabel = self.labelTagsArray[currentIndex];
        leftLabelSizeValue = self.labelSizeArray[currentIndex];
        leftLabelSize = [leftLabelSizeValue CGSizeValue];
        sliderWidth = leftLabelSize.width;
        sliderCenterX = nextLabel.centerX + (offsetX / viewWidth) * kWidth(80);
        self.focusSliderBar.frame = CGRectMake(sliderCenterX - sliderWidth / 2, self.focusSliderBar.y, sliderWidth, kWidth(8));
    } else if (currentIndex >= self.labelTagsArray.count - 1) {
        currentIndex = self.labelTagsArray.count - 1;
        nextLabel = self.labelTagsArray[currentIndex];
        NSValue *rightLabelSizeValue = self.labelSizeArray[currentIndex];
        CGSize rightLabelSize = [rightLabelSizeValue CGSizeValue];
        CGFloat sliderWidth = rightLabelSize.width;
        sliderCenterX = nextLabel.centerX + (pageOffsetX / viewWidth) * kWidth(80);
        self.focusSliderBar.frame = CGRectMake(sliderCenterX - sliderWidth / 2, self.focusSliderBar.y, sliderWidth, kWidth(8));
    } else {
        NSValue *leftLabelSizeValue = self.labelSizeArray[currentIndex];
        CGSize leftLabelSize = [leftLabelSizeValue CGSizeValue];
        
        rightLabelSizeValue = self.labelSizeArray[currentIndex + 1];
        rightLabelSize = [rightLabelSizeValue CGSizeValue];
        
        sliderWidth = (pageOffsetX / viewWidth) * (rightLabelSize.width - leftLabelSize.width) + leftLabelSize.width;
        sliderCenterX = label.centerX + (pageOffsetX / viewWidth) * (nextLabel.centerX - label.centerX);
        self.focusSliderBar.frame = CGRectMake(sliderCenterX - sliderWidth / 2, self.focusSliderBar.y, sliderWidth, kWidth(8));
    }
    
    ZCCSegmentLabel *currentLabel;
    NSInteger index = (offsetX + viewWidth / 2) / viewWidth;
//    NSLog(@"(index %ld = offsetx %lf + self.width / 2 %lf) / self.width %lf", index, offsetX, viewWidth / 2, viewWidth);
    if (index >= 0 && index < self.labelTagsArray.count) {
        currentLabel = self.labelTagsArray[index];
        if (currentLabel != _currentSelectedLabel) {
            currentLabel.isSelected = YES;
            _currentSelectedLabel.isSelected = NO;
            _currentSelectedLabel = currentLabel;
        }
    }
}

// 被动选中
- (void)segLabelTaped:(UITapGestureRecognizer *)tap {
    ZCCSegmentLabel *segLabel = (ZCCSegmentLabel *)tap.view;
    if (segLabel.isSelected) {
        return ;
    } else {
//        ZCCSegmentLabel *shouldSelectedLabel; // 需要选中的按钮
//        ZCCSegmentLabel *formalSelectedLabel; // 之前选中的按钮
        [UIView animateWithDuration:0.1 animations:^{
            self.flowerIconView.alpha = 0;
        }];
        for (ZCCSegmentLabel *label in self.labelTagsArray) {
            if (label == segLabel) {
                label.isSelected = YES;
                [UIView animateWithDuration:0.1 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    if (self.selectIcon) {
                        self.flowerIconView.alpha = 1;
                        self.flowerIconView.x = CGRectGetMaxX(label.frame) - kWidth(10);
                    }
                    self.focusSliderBar.centerX = label.centerX;
                } completion:nil];
                
                if ([self.delegate respondsToSelector:@selector(segmentLabelTapedIndex:)]) {
                    // 返回 当前选中了第几个
                    [self.delegate segmentLabelTapedIndex:label.tag];
                }
                _currentSelectedLabel = segLabel;
            } else {
                label.isSelected = NO;
            }
        }
    }
}

- (UIImageView *)flowerIconView {
    if (!_flowerIconView) {
        _flowerIconView = [[UIImageView alloc] init]; // WithImage:[UIImage imageNamed:@"icon_xh"]
        _flowerIconView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _flowerIconView;
}

@end
