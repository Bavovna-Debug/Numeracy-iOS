//
//  Numeracy
//
//  Copyright (c) 2014 Meine Werke. All rights reserved.
//

#import "HALBrain.h"
#import "HALDisplayLED.h"

@implementation HALDisplayLED

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self == nil)
        return nil;

    self.backgroundColor = [UIColor clearColor];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(valueChanged:)
                                                 name:@"ValueChanged"
                                               object:nil];

    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self setNeedsDisplay];
}

- (void)valueChanged:(NSNotification *)note
{
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)frame
{
    HALBrain *brain = [HALBrain sharedBrain];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        UIImage *backgroundImage = [UIImage imageNamed:@"LED-panel"];
        [backgroundImage drawInRect:frame];
    }

    UIImage *ledOffImage = [UIImage imageNamed:@"LED-off"];
    UIImage *ledOnImage = [UIImage imageNamed:@"LED-on"];
    
    UInt64 value = [brain currentValue];
    long long bitty = 1;

    UIColor *labelColor = [UIColor darkGrayColor];
    
    float numberOfBits = 64;
    float numberOfRows = (frame.size.width < frame.size.height) ? 8 : 4;
    float numberOfBitsPerRow = numberOfBits / numberOfRows;
    float labelWidth = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 48 : 20;

    frame = CGRectInset(frame, labelWidth + 4, 8);

    //float distanceBetweenBits = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 8 : 4;
    float distanceBetweenBytes = 8;
    //float bitSize = ((frame.size.width - distanceBetweenBytes) / numberOfBitsPerRow) - distanceBetweenBits;
    float bitSize = (frame.size.width - distanceBetweenBytes) / numberOfBitsPerRow;
    float distanceBetweenRows = (frame.size.height - (numberOfRows * bitSize)) / (numberOfRows - 1);
    
    bitSize = floorf(bitSize);
    distanceBetweenRows = floorf(distanceBetweenRows);

    UIFont *labelFont = [UIFont systemFontOfSize:bitSize * 0.8f];

    //CGRect rect = CGRectMake(frame.origin.x + frame.size.width - bitSize - (distanceBetweenBits / 2),
    CGRect rect = CGRectMake(frame.origin.x + frame.size.width - bitSize,
                             frame.origin.y + frame.size.height - bitSize,
                             bitSize,
                             bitSize);
    CGRect firstBitRect = rect;
    int bitNumber = 0;
    for (short row = 0; row < numberOfRows; row++)
    {
        CGRect bitRect = firstBitRect;

        CGRect labelRect;
        NSString *labelText;

        labelRect = CGRectMake(bitRect.origin.x + bitRect.size.width,
                               bitRect.origin.y,
                               labelWidth,
                               bitSize);
        labelText = [NSString stringWithFormat:@"%02d", bitNumber];
        [labelColor setFill];
        [labelText drawInRect:labelRect
                     withFont:labelFont
                lineBreakMode:NSLineBreakByWordWrapping
                    alignment:NSTextAlignmentCenter];
        
        for (int bit = 0; bit < numberOfBitsPerRow; bit++)
        {
            if (bit == 8)
                bitRect = CGRectOffset(bitRect, -distanceBetweenBytes, 0);

            if (value & bitty) {
                [ledOnImage drawInRect:bitRect];
            } else {
                [ledOffImage drawInRect:bitRect];
            }
            
            if (bit < (numberOfBitsPerRow - 1)) {
                //bitRect = CGRectOffset(bitRect, -(bitSize + distanceBetweenBits), 0);
                bitRect = CGRectOffset(bitRect, -bitSize, 0);
            }
            
            bitty <<= 1;
            bitNumber++;
        }

        labelRect = CGRectMake(bitRect.origin.x - labelWidth,
                               bitRect.origin.y,
                               labelWidth,
                               bitSize);
        labelText = [NSString stringWithFormat:@"%02d", bitNumber - 1];
        [labelColor setFill];
        [labelText drawInRect:labelRect
                     withFont:labelFont
                lineBreakMode:NSLineBreakByWordWrapping
                    alignment:NSTextAlignmentCenter];
        
        firstBitRect = CGRectOffset(firstBitRect, 0, -(bitSize + distanceBetweenRows));
    }
}

@end
