/*!
  @class UIColor+extensions.h
 
  @author Matthew Inman
 
  @copyright 2013 (c). Popeye Development Limited
 
 This library is to be used as is and can be used free of charge. Please use at your own risk.
 */

#import <UIKit/UIColor.h>

@interface UIColor (extensions)

+ (UIColor *)colorWithHex:(NSString *)hexStr;
+ (UIColor *)colorWithHex:(NSString *)hexStr alpha:(CGFloat)alpha;
+ (UIColor *)colorWithGradientColorForTop:(id)topClr bottom:(id)bottomClr frame:(CGRect)frame;
+ (UIImage *)colorWithGradientImageForTop:(id)topClr bottom:(id)bottomClr frame:(CGRect)frame;

+ (UIColor *)auburnColor;
+ (UIColor *)awesomeColor;
+ (UIColor *)ashColor;
+ (UIColor *)beigeColor;
+ (UIColor *)blondColor;
+ (UIColor *)blushColor;
+ (UIColor *)boneColor;
+ (UIColor *)bubbleGumColor;
+ (UIColor *)chocolateColor;
+ (UIColor *)champagneColor;
+ (UIColor *)coffeeColor;
+ (UIColor *)copperColor;

@end