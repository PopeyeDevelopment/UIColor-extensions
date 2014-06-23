/*!
 @class UIColor+extensions.h
 
 @author Matthew Inman
 
 @copyright 2013 (c). Popeye Development Limited
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and 
 associated documentation files (the "Software"), to deal in the Software without restriction, including 
 without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the 
 following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial 
 portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT 
 LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
 IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE 
 OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import <UIKit/UIColor.h>

@interface UIColor (extensions)

+ (UIColor *)colorWithHex:(NSString *)hexStr;
+ (UIColor *)colorWithHex:(NSString *)hexStr alpha:(CGFloat)alpha;
+ (UIColor *)colorWithGradientColorForTop:(id)topClr bottom:(id)bottomClr frame:(CGRect)frame;
+ (UIImage *)colorWithGradientImageForTop:(id)topClr bottom:(id)bottomClr frame:(CGRect)frame;

+ (UIColor *)randomColor;
+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha;
+ (CGFloat)randomAlpha;

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
