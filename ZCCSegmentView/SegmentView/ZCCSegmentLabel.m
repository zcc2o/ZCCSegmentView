//
//  ZCCSegmentLabel.m
//  ZCC
//
//  Created by ZCc on 2019/8/21.
//  Copyright © 2019 laibu. All rights reserved.
//

#import "ZCCSegmentLabel.h"

@interface ZCCSegmentLabel ()
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, assign) CGFloat selectFontSize;

@end

@implementation ZCCSegmentLabel

@synthesize isSelected = _isSelected;

- (instancetype)initWithFontSize:(CGFloat)fontSize
                  selectFontSize:(CGFloat)selectFontSize
                       textColor:(UIColor *)textColor
                   selectedColor:(UIColor *)selectedColor
                            text:(NSString *)text
                   textAlignment:(NSTextAlignment)textAlignment {
    if (self = [super init]) {
        _fontSize = fontSize;
        _selectFontSize = selectFontSize;
        self.font = MFontSemibold(fontSize);
        self.text = text;
        self.textColor = textColor;
        self.textAlignment = NSTextAlignmentCenter;
        _normalColor = textColor;
        _selectedColor = selectedColor;
    }
    return self;
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    if (_isSelected) {
        self.font = MFontSemibold(_selectFontSize);
        self.textColor = self.selectedColor;
    } else {
        self.font = MFontSemibold(_fontSize);
        self.textColor = self.normalColor;
    }
}

- (void)drawTextInRect:(CGRect)rect {
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:self.text attributes:@{NSFontAttributeName:self.font}];
    rect.size.height = [attributedText boundingRectWithSize:rect.size options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    
    if (self.numberOfLines != 0) {
        CGFloat textHeight = MIN(rect.size.height, self.numberOfLines * (self.font.lineHeight));
        rect.origin.y = self.frame.size.height - textHeight;
        rect.size.height = textHeight;
    }
    [super drawTextInRect:rect];
}

@end
