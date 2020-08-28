//
//  DYFactory.h
//  DYFactory
//
//  Created by yidai on 2019/6/6.
//  Copyright © yidai. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface DYFactory : NSObject

/**
 创建UILabel

 @param frame frame
 @param text  text
 @param color textColor
 @param font  textFont
 @return label
 */
+ (UILabel *)initLabelWithFrame: (CGRect)frame text: (NSString *)text textColor: (UIColor *)color font: (UIFont*)font;

/**
 创建UILabel  --> 指定文字大小

 @param frame frame
 @param text  text
 @param color textColor
 @param fontSize regular字体的文字大小
 @return label
 */
+ (UILabel *)initLabelWithFrame: (CGRect)frame text: (NSString *)text textColor: (UIColor *)color fontSize: (CGFloat)fontSize;

/**
 创建UILabel  --> 指定文字的对其方式

 @param frame frame
 @param text  text
 @param color textColor
 @param font  textFont
 @param align textAlign
 @return label
 */
+ (UILabel *)initLabelWithFrame: (CGRect)frame text: (NSString *)text textColor: (UIColor *)color font: (UIFont*)font align:(NSTextAlignment)align;



/**
 创建UIButton  --> 只通过文字创建button，不带有方法

 @param frame frame
 @param title 按钮的title
 @param color 按钮的title颜色
 @param font  按钮的title的字体
 @return button
 */
+ (UIButton *)initButtonWithFrame: (CGRect)frame title: (NSString *)title titleColor: (UIColor *)color font: (UIFont*)font;

/**
 创建UIButton  --> 只通过文字创建button，带有方法

 @param frame frame
 @param title 按钮的title
 @param color 按钮的title颜色
 @param font  按钮的title的字体
 @param target target
 @param action 点击方法的SEL
 @return button
 */
+ (UIButton *)initButtonWithFrame: (CGRect)frame title: (NSString *)title titleColor: (UIColor *)color font: (UIFont*)font target:(id)target action: (SEL)action;

/**
 创建UIButton  --> 只通过icon创建Button，无背景图片，无点击方法

 @param frame frame
 @param img   按钮的icon
 @return button
 */
+ (UIButton *)initButtonWithFrame: (CGRect)frame img: (UIImage  * _Nullable )img;

/**
 创建UIButton  --> 只通过icon创建Button，有背景图片，无点击方法

 @param frame frame
 @param img   按钮的icon
 @param backImg 按钮的背景图片
 @return button
 */
+ (UIButton *)initButtonWithFrame: (CGRect)frame img: (UIImage * _Nullable)img backImg: (UIImage * _Nullable)backImg;

/**
 创建UIButton  --> 只通过icon创建Button，有背景图片，有点击方法

 @param frame frame
 @param img   按钮的icon
 @param backImg 按钮的背景图片
 @param target  target
 @param action  按钮的点击方法SEL
 @return button
 */
+ (UIButton *)initButtonWithFrame: (CGRect)frame img: (UIImage * _Nullable)img backImg: (UIImage * _Nullable)backImg target:(id)target action: (SEL)action;

/**
 创建UIButton  --> 通过图片(icon或者背景图)，文字创建Button，有背景图片，有点击方法

 @param frame frame
 @param title 按钮的title
 @param color 按钮的titleColor
 @param font  按钮的titleFont
 @param target target
 @param action 按钮的点击方法SEL
 @param img    按钮的图片(icon或者是背景图)
 @param isIcon 是否为icon，如果不是icon，那么img就是背景图。
 @return button
 */
+ (UIButton *)initButtonWithFrame: (CGRect)frame title: (NSString *)title titleColor: (UIColor *)color font: (UIFont*)font target:(id)target action: (SEL)action img: (UIImage *)img  isIcon: (BOOL)isIcon;



/**
 创建UITextField

 @param frame frame
 @param color textColor
 @param font  textFont
 @return textField
 */
+ (UITextField *)initFieldWithFrame: (CGRect)frame textColor: (UIColor *)color font: (UIFont*)font;

/**
 创建UITextField

 @param frame frame
 @param color textColor
 @param font  textFont
 @param placeholder 占位字符串
 @return textField
 */
+ (UITextField *)initFieldWithFrame: (CGRect)frame textColor: (UIColor *)color font: (UIFont*)font placeholder: (NSString *)placeholder;

/// 创建tableView
/// @param frame frame
/// @param style UITableViewStyle
/// @param rowHeight rowHeight
+ (UITableView *)initTableViewWithFrame: (CGRect)frame style: (UITableViewStyle)style rowHeight: (CGFloat)rowHeight;

/// 创建tableView
/// @param frame frame
/// @param style UITableViewStyle
/// @param rowHeight rowHeight
/// @param backgroundColor backgroundColor
+ (UITableView *)initTableViewWithFrame: (CGRect)frame style: (UITableViewStyle)style rowHeight: (CGFloat)rowHeight backgroundColor: (UIColor *)backgroundColor;



@end

NS_ASSUME_NONNULL_END
