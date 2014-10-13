/*!
 @class UIColor+extensions.m
 
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

#import "UIColor+extensions.h"
#define ARC4RANDOM_MAX 255
@implementation UIColor (extensions)


+ (UIColor *)colorAtPoint:(CGPoint)point forView:(UIView *)view
{
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [view.layer renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    return [UIColor colorWithRed:pixel[0]/255.0
                           green:pixel[1]/255.0
                            blue:pixel[2]/255.0
                           alpha:pixel[3]/255.0];
}

+ (UIColor *)colorWithHex:(NSString *)hexStr
{
    return [[self class] colorWithHex:hexStr alpha:1.0f];
}

+ (UIColor *)colorWithHex:(NSString *)hexStr alpha:(CGFloat)alpha
{
    NSString *removedHashStr = [hexStr stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([removedHashStr length] == 3)
        removedHashStr = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                          [removedHashStr substringWithRange:NSMakeRange(0, 1)],
                          [removedHashStr substringWithRange:NSMakeRange(0, 1)],
                          [removedHashStr substringWithRange:NSMakeRange(1, 1)],
                          [removedHashStr substringWithRange:NSMakeRange(1, 1)],
                          [removedHashStr substringWithRange:NSMakeRange(2, 1)],
                          [removedHashStr substringWithRange:NSMakeRange(2, 1)]];
    
    if([removedHashStr length] == 6)
        removedHashStr = [removedHashStr stringByAppendingString:@"ff"];
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:removedHashStr] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (CAGradientLayer *)colorWithGradientForArrayOfColors:(NSArray *)colors frame:(CGRect)frame
{
    CAGradientLayer *layer = [CAGradientLayer layer];
    [layer setFrame:frame];
    NSMutableArray *refreshColors = [[NSMutableArray alloc] initWithCapacity:[colors count]];
    for(id color in colors) {
        if([color isKindOfClass:[UIColor class]]) {
            [refreshColors addObject:(id)[color CGColor]];
        }
    }
    [layer setColors:refreshColors];
    [layer setStartPoint:CGPointMake(0.5f, 0.5f)];
    [layer setEndPoint:CGPointMake(0.5f, 1.0f)];
    return layer;
}

+ (CAGradientLayer *)colorWithGradientForTop:(id)topClr bottom:(id)bottomClr frame:(CGRect)frame
{
    CAGradientLayer *layer = [CAGradientLayer layer];
    [layer setFrame:frame];
    [layer setColors:[NSArray arrayWithObjects:
                        (id)[topClr CGColor],
                        (id)[bottomClr CGColor], nil]];
    [layer setStartPoint:CGPointMake(0.5f, 0.0f)];
    [layer setEndPoint:CGPointMake(0.5f, 1.0f)];
    return layer;
}


+ (UIColor *)colorWithGradientWithArrayOfColors:(NSArray *)colors frame:(CGRect)frame
{
    CAGradientLayer *layer = [self colorWithGradientForArrayOfColors:colors frame:frame];
    UIGraphicsBeginImageContext([layer frame].size);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [self colorWithPatternImage:image];
}

+ (UIImage *)colorWithGradientImageForTop:(id)topClr bottom:(id)bottomClr frame:(CGRect)frame
{
    CAGradientLayer *layer = [self colorWithGradientForTop:topClr bottom:bottomClr frame:frame];
    UIGraphicsBeginImageContext([layer frame].size);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIColor *)colorWithGradientColorForTop:(id)topClr bottom:(id)bottomClr frame:(CGRect)frame
{
    CAGradientLayer *layer = [self colorWithGradientForTop:topClr bottom:bottomClr frame:frame];
    UIGraphicsBeginImageContext([layer frame].size);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [self colorWithPatternImage:image];
}

+ (UIColor *)randomColor
{
    return [self randomColorWithAlpha:1.0f];
}

+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha
{
    float red = ((float)arc4random_uniform(ARC4RANDOM_MAX)/255.0);
    float green = ((float)arc4random_uniform(ARC4RANDOM_MAX)/255.0);
    float blue = ((float)arc4random_uniform(ARC4RANDOM_MAX)/255.0);
    
    return [UIColor colorWithRed:red
                           green:green
                            blue:blue
                           alpha:alpha];
}

+ (NSString *)hexFromUIColor:(UIColor *)color
{
    const CGFloat *components = CGColorGetComponents(color.CGColor);

    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];

    return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
            lroundf(r * 255),
            lroundf(g * 255),
            lroundf(b * 255)];
}

+ (CGFloat)randomAlpha
{
    return ((float)arc4random_uniform(ARC4RANDOM_MAX)/255.0);
}

+ (UIColor *)auburnColor
{
    return [self colorWithHex:@"a52a2a"];
}

+ (UIColor *)awesomeColor
{
    return [self colorWithHex:@"ff2052"];
}

+ (UIColor *)ashColor
{
    return [self colorWithHex:@"#b2beb5"];
}

+ (UIColor *)beigeColor
{
    return [self colorWithHex:@"#f5f5dc"];
}

+ (UIColor *)blondColor
{
    return [self colorWithHex:@"#faf0be"];
}

+ (UIColor *)blushColor
{
    return [self colorWithHex:@"#de5d83"];
}

+ (UIColor *)boneColor
{
    return [self colorWithHex:@"#e3dac9"];
}

+ (UIColor *)bubbleGumColor
{
    return [self colorWithHex:@"#ffc1cc"];
}

+ (UIColor *)chocolateColor
{
    return [self colorWithHex:@"#d2691e"];
}

+ (UIColor *)champagneColor
{
    return [self colorWithHex:@"#fad6a5"];
}

+ (UIColor *)coffeeColor
{
    return [self colorWithHex:@"#6f4e37"];
}

+ (UIColor *)copperColor
{
    return [self colorWithHex:@"#b87333"];
}

@end
