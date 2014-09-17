//
//  Numeracy
//
//  Copyright (c) 2014 Meine Werke. All rights reserved.
//

#import "HALBrain.h"
#import "HALDigitButton.h"

@interface HALDigitButton ()

@property (assign, nonatomic) short digit;

@end

@implementation HALDigitButton

@synthesize digit = _digit;

- (id)init:(short)digit
{
    self = [super init];
    if (self == nil)
        return nil;
    
    self.digit = digit;

    NSString *label = [NSString stringWithFormat:@"%X", digit];
    [self setLabel:label
          fontSize:28];
    
    [self addTarget:self
             action:@selector(didTouchButton)
   forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

- (void)didTouchButton
{
    HALBrain *brain = [HALBrain sharedBrain];
    [brain digitPressed:[self digit]];
}

@end
