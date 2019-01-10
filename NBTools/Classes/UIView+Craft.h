//
//  UIView+Craft.h
//  Pods
//
//  Created by 张杰 on 2019/1/9.
//

#import <UIKit/UIKit.h>
/**
 *  UIView倒角位置枚举
 */
typedef NS_ENUM(NSInteger, NBCornerPosition) {//圆角位置
    NBCornerPosition_None,                  //默认无
    NBCornerPosition_Top,                   //上部圆角
    NBCornerPosition_Left,                  //左部圆角
    NBCornerPosition_Bottom,                //下部
    NBCornerPosition_Right,                 //右部
    NBCornerPosition_All,                   //全部
    NBCornerPosition_AllRound,              //圆形
    NBCornerPosition_LB_RT,                 //左下右上
    NBCornerPosition_LT_RB,                 //左上右下
    NBCornerPosition_LB,                    //左下角
    NBCornerPosition_LT,                    //左上角
    NBCornerPosition_RT,                    //右上角
    NBCornerPosition_RB                     //右下角
};
/**
 *  UIView渐变色方向走向
 */
typedef NS_ENUM(NSInteger, NBGradientPosition) {
    NBGradientPosition_RightToLeft,        //从左到右
    NBGradientPosition_TopToBottom         //从上到下
};


NS_ASSUME_NONNULL_BEGIN

@interface UIView (Craft)

@property (nonatomic, assign)NBCornerPosition nb_cornerPosition;//倒角位置
@property (nonatomic, assign)CGFloat nb_cornerRadius;//倒角大小

@property(nonatomic,strong)UIColor * nb_borderColor;//倒角border的颜色
@property(nonatomic,assign)CGFloat nb_borderWidth;//倒角的宽度
@property(nonatomic, assign,readonly)BOOL nb_added;//是否添加了borderLayer 默认为NO;
@property(nonatomic,strong,readonly)CAShapeLayer * nb_borderLayer;//倒角的layer



@property(nonatomic,assign)BOOL showGradientBackGround;//展示渐变背景
@property(nonatomic,assign)NBGradientPosition nb_gradientPosition;//渐变方位
@property(nonatomic,strong,nullable)UIColor * nb_fromColor;//渐变的起始颜色
@property(nonatomic,strong,nullable)UIColor * nb_toColor;//渐变终色
@property(nonatomic,strong,nullable,readonly)CAGradientLayer * nb_gradientLayer;//渐变layer


/**倒角上边全部**/
- (void)nb_setTopCornerRadius:(CGFloat)radius;
/**倒角左边全部**/
- (void)nb_setLeftCornerRadius:(CGFloat)radius;
/**倒角下边全部**/
- (void)nb_setBottomCornerRadius:(CGFloat)radius;
/**倒角右边全部**/
- (void)nb_setRightCornerRadius:(CGFloat)radius;
/**倒角全部**/
- (void)nb_setAllCornerRadius:(CGFloat)radius;
/**倒角成为一个圆形(类似于头像)**/
- (void)nb_setAllCornerRound;//倒角为圆形
/**不设置角**/
- (void)nb_setNoneCorner;

@end

NS_ASSUME_NONNULL_END
