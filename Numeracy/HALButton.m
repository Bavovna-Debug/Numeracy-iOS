//
//  Numeracy
//
//  Copyright (c) 2014 Meine Werke. All rights reserved.
//

#import "HALButton.h"

@interface HALButton ()

@property (strong, nonatomic) UIView *lightningView;

@end

@implementation HALButton

@synthesize lightningView = _lightningView;

- (id)init
{
    self = [super init];
    if (self == nil)
        return nil;
    
    [self setTitleColor:[UIColor whiteColor]
               forState:UIControlStateNormal];

    self.lightningView = [[UIView alloc] init];
    [self.lightningView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self.lightningView setAlpha:0.0f];

    [self addSubview:self.lightningView];

    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self setNeedsDisplay];
}

- (void)setLabel:(NSString *)label
        fontSize:(CGFloat)fontSize
{
    [self setTitle:label forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
}

- (void)setColor:(UIColor *)buttonColor
{
    [self setBackgroundColor:buttonColor];
    [self.lightningView setBackgroundColor:[UIColor whiteColor]];
    [self setNeedsDisplay];
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    
    [UIView beginAnimations:nil
                    context:nil];
    [UIView setAnimationDuration:0.4f];
    
    [self.titleLabel setAlpha:(enabled) ? 1.0f : 0.4f];
    
    [UIView commitAnimations];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.lightningView setAlpha:0.4f];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];

    [UIView beginAnimations:nil
                    context:nil];
    [UIView setAnimationDuration:0.4f];
    
    [self.lightningView setAlpha:0.0f];
    
    [UIView commitAnimations];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];

    [UIView beginAnimations:nil
                    context:nil];
    [UIView setAnimationDuration:0.4f];
    
    [self.lightningView setAlpha:0.0f];
    
    [UIView commitAnimations];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
 
    [UIView beginAnimations:nil
                    context:nil];
    [UIView setAnimationDuration:0.8f];
    
    [self.lightningView setAlpha:0.0f];
    
    [UIView commitAnimations];
}

- (void)drawRect:(CGRect)rect
{
    UIColor *backgroundColor = [self backgroundColor];
    
    CGColorRef colorRef = [backgroundColor CGColor];
    const CGFloat *components = CGColorGetComponents(colorRef);

    UIColor *lightColor = [UIColor colorWithRed:components[0] * 1.2f
                                          green:components[1] * 1.2f
                                           blue:components[2] * 1.2f
                                          alpha:1.0];
    UIColor *darkColor = [UIColor colorWithRed:components[0] * 0.6f
                                         green:components[1] * 0.6f
                                          blue:components[2] * 0.6f
                                         alpha:1.0];
    
    CGRect drawRect = [self bounds];
    
    drawRect.size.width--;
    drawRect.size.height--;
    
    [lightColor setFill];
    UIRectFill(drawRect);
    
    drawRect.origin.x++;
    drawRect.origin.y++;

    [darkColor setFill];
    UIRectFill(drawRect);

    drawRect.size.width--;
    drawRect.size.height--;

    [backgroundColor setFill];
    UIRectFill(drawRect);
}

@end
