//
//  DYFactory.m
//  DYFactory
//
//  Created by yidai on 2019/6/6.
//  Copyright © yidai. All rights reserved.
//

#import "DYFactory.h"

@implementation DYFactory

+ (UILabel *)initLabelWithFrame: (CGRect)frame text: (NSString *)text textColor: (UIColor *)color font: (UIFont*)font {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = color;
    label.font = font;
    
    return label;
}

+ (UILabel *)initLabelWithFrame: (CGRect)frame text: (NSString *)text textColor: (UIColor *)color fontSize: (CGFloat)fontSize {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:fontSize];
    
    return label;
}

+ (UILabel *)initLabelWithFrame: (CGRect)frame text: (NSString *)text textColor: (UIColor *)color font: (UIFont*)font align:(NSTextAlignment)align {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.textColor = color;
    label.font = font;
    label.textAlignment = align;
    
    return label;
}


#pragma mark - UIButton------------------------------------
+ (UIButton *)initButtonWithFrame: (CGRect)frame title: (NSString *)title titleColor: (UIColor *)color font: (UIFont*)font {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = frame;
    button.titleLabel.font = font;
    [button setTitle:title forState:(UIControlStateNormal)];
    [button setTitleColor:color forState:(UIControlStateNormal)];
    
    return button;
}

+ (UIButton *)initButtonWithFrame: (CGRect)frame title: (NSString *)title titleColor: (UIColor *)color font: (UIFont*)font target:(id)target action: (SEL)action  {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = frame;
    button.titleLabel.font = font;
    [button setTitle:title forState:(UIControlStateNormal)];
    [button setTitleColor:color forState:(UIControlStateNormal)];
    [button addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    return button;
}

+ (UIButton *)initButtonWithFrame: (CGRect)frame img: (UIImage *)img {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = frame;
    [button setImage:img forState:(UIControlStateNormal)];
    
    return button;
}

+ (UIButton *)initButtonWithFrame: (CGRect)frame img: (UIImage *)img backImg: (UIImage *)backImg  {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = frame;
    [button setImage:img forState:(UIControlStateNormal)];
    if (backImg != nil) {
        [button setBackgroundImage:backImg forState:(UIControlStateNormal)];
    }
    
    return button;
}

+ (UIButton *)initButtonWithFrame: (CGRect)frame img: (UIImage *)img backImg: (UIImage *)backImg target:(id)target action: (SEL)action {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = frame;
    [button setImage:img forState:(UIControlStateNormal)];
    [button addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    if (backImg != nil) {
        [button setBackgroundImage:backImg forState:(UIControlStateNormal)];
    }
    
    return button;
}

+ (UIButton *)initButtonWithFrame: (CGRect)frame title: (NSString *)title titleColor: (UIColor *)color font: (UIFont*)font target:(id)target action: (SEL)action img: (UIImage *)img  isIcon: (BOOL)isIcon {
    UIButton *btn = [self initButtonWithFrame:frame title:title titleColor:color font:font target:target action:action];
    if (img) {
        if (isIcon) {
            [btn setImage:img forState:(UIControlStateNormal)];
        } else {
            [btn setBackgroundImage:img forState:(UIControlStateNormal)];
        }
    }
    
    return btn;
}

#pragma mark - UITextFiled------------------------------------
+ (UITextField *)initFieldWithFrame: (CGRect)frame textColor: (UIColor *)color font: (UIFont*)font {
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.font = font;
    textField.textColor = color;
    
    return textField;
}

+ (UITextField *)initFieldWithFrame: (CGRect)frame textColor: (UIColor *)color font: (UIFont*)font placeholder: (NSString *)placeholder {
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.font = font;
    textField.textColor = color;
    textField.placeholder = placeholder;
    
    return textField;
}

+ (UITableView *)initTableViewWithFrame: (CGRect)frame style: (UITableViewStyle)style rowHeight: (CGFloat)rowHeight {
    return [self initTableViewWithFrame:frame style:style rowHeight:rowHeight backgroundColor:[UIColor clearColor]];
}

+ (UITableView *)initTableViewWithFrame: (CGRect)frame style: (UITableViewStyle)style rowHeight: (CGFloat)rowHeight backgroundColor: (UIColor *)backgroundColor {
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:style];
    tableView.backgroundColor = backgroundColor;
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tableView.rowHeight = rowHeight;
    tableView.estimatedRowHeight = rowHeight;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    return tableView;
}


@end
