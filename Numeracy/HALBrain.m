//
//  Numeracy
//
//  Copyright (c) 2014 Meine Werke. All rights reserved.
//

#import "HALBrain.h"
#import "HALJournal.h"

@implementation HALBrain

@synthesize currentValue = _currentValue;
@synthesize noticedValue = _noticedValue;
@synthesize arithmetic = _arithmetic;

+ (HALBrain *)sharedBrain
{
    static dispatch_once_t onceToken;
    static HALBrain *brain;
    
    dispatch_once(&onceToken, ^{
        brain = [[HALBrain alloc] init];
    });
    
    return brain;
}

- (id)init
{
    self = [super init];
    if (self == nil)
        return nil;
    
    [self setCurrentValue:0];
    [self setNoticedValue:0];
    [self setArithmetic:HALArithmeticNone];
    [self setPrimusNumeralSystem:HALNumeralSystemHEX];
    [self setCordusNumeralSystem:HALNumeralSystemDEC];
    
    return self;
}

- (void)saveData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *valueString;
    
    valueString = [NSString stringWithFormat:@"%llu", [self currentValue]];
    [defaults setObject:valueString forKey:@"CurrentValue"];

    valueString = [NSString stringWithFormat:@"%llu", [self noticedValue]];
    [defaults setObject:valueString forKey:@"NoticedValue"];

    [defaults setInteger:[self arithmetic] forKey:@"Arithmetic"];
    [defaults setInteger:[self primusNumeralSystem] forKey:@"PrimusNumeralSystem"];
    [defaults setInteger:[self cordusNumeralSystem] forKey:@"CordusNumeralSystem"];
}

- (void)loadData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    NSString *valueString;
    
    valueString = [defaults objectForKey:@"CurrentValue"];
    [self setCurrentValue:[valueString longLongValue]];

    valueString = [defaults objectForKey:@"NoticedValue"];
    [self setNoticedValue:[valueString longLongValue]];

    [self setArithmetic:(HALArithmetic)[defaults integerForKey:@"Arithmetic"]];
    [self setPrimusNumeralSystem:(HALNumeralSystem)[defaults integerForKey:@"PrimusNumeralSystem"]];
    [self setCordusNumeralSystem:(HALNumeralSystem)[defaults integerForKey:@"CordusNumeralSystem"]];
}

- (void)setCurrentValue:(UInt64)currentValue
{
    if (currentValue != _currentValue) {
        _currentValue = currentValue;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ValueChanged"
                                                            object:self];
    }
}

- (void)setArithmetic:(HALArithmetic)arithmetic
{
    if (arithmetic != _arithmetic) {
        _arithmetic = arithmetic;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ArithmeticChanged"
                                                            object:self];
    }
}

- (void)setPrimusNumeralSystem:(HALNumeralSystem)primusNumeralSystem
{
    if (primusNumeralSystem != _primusNumeralSystem) {
        _primusNumeralSystem = primusNumeralSystem;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NumeralSystemChanged"
                                                            object:self];
    }
}

- (void)setCordusNumeralSystem:(HALNumeralSystem)cordusNumeralSystem
{
    if (cordusNumeralSystem != _cordusNumeralSystem) {
        _cordusNumeralSystem = cordusNumeralSystem;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NumeralSystemChanged"
                                                            object:self];
    }
}

- (void)digitPressed:(short)digit
{
    
    switch ([self arithmetic])
    {
        case HALArithmeticAddBegun:
            [self setCurrentValue:0];
            [self setArithmetic:HALArithmeticAdd];
            break;
            
        case HALArithmeticSubstractBegun:
            [self setCurrentValue:0];
            [self setArithmetic:HALArithmeticSubstract];
            break;
            
        default:
            break;
    }
    
    switch ([self primusNumeralSystem])
    {
        case HALNumeralSystemOCT:
            [self setCurrentValue:[self currentValue] * 8 + digit];
            break;
            
        case HALNumeralSystemDEC:
            [self setCurrentValue:[self currentValue] * 10 + digit];
            break;
            
        case HALNumeralSystemHEX:
            [self setCurrentValue:[self currentValue] * 16 + digit];
            break;
    }
}

- (void)backspacePressed
{
    switch ([self primusNumeralSystem])
    {
        case HALNumeralSystemDEC:
        {
            NSString *theString;
            NSScanner *theScanner;
            
            theString = [NSString stringWithFormat:@"%lld", [self currentValue]];
            
            if (theString.length == 1) {
                [self setCurrentValue:0];
            } else {
                theString = [theString substringToIndex:theString.length - 1];
                theScanner = [NSScanner scannerWithString:theString];
                unsigned long long value;
                [theScanner scanUnsignedLongLong:&value];
                [self setCurrentValue:value];
            }
            break;
        }
            
        case HALNumeralSystemHEX:
        {
            NSString *theString;
            NSScanner *theScanner;
            
            theString = [NSString stringWithFormat:@"%llX", [self currentValue]];
            
            if (theString.length == 1) {
                [self setCurrentValue:0];
            } else {
                theString = [theString substringToIndex:theString.length - 1];
                theScanner = [NSScanner scannerWithString:theString];
                unsigned long long value;
                [theScanner scanHexLongLong:&value];
                [self setCurrentValue:value];
            }
            break;
        }
            
        default:
            break;
    }
}

- (void)clearPressed
{
    [self setCurrentValue:0];
    switch (self.arithmetic)
    {
        case HALArithmeticAdd:
            [self setArithmetic:HALArithmeticAddBegun];
            break;
            
        case HALArithmeticSubstract:
            [self setArithmetic:HALArithmeticSubstractBegun];
            break;
            
        default:
            [self setArithmetic:HALArithmeticNone];
            break;
    }
}

- (void)resetPressed
{
    [self setCurrentValue:0];
    [self setNoticedValue:0];
    [self setArithmetic:HALArithmeticNone];
}

- (void)shiftLeftPressed
{
    [self setCurrentValue:[self currentValue] << 1];
}

- (void)shiftRightPressed
{
    [self setCurrentValue:[self currentValue] >> 1];
}

- (void)plusPressed
{
    if ((self.arithmetic == HALArithmeticAdd) || (self.arithmetic == HALArithmeticSubstract))
        [self equationPressed];
    
    [self setNoticedValue:[self currentValue]];
    [self setArithmetic:HALArithmeticAddBegun];
}

- (void)minusPressed
{
    if ((self.arithmetic == HALArithmeticAdd) || (self.arithmetic == HALArithmeticSubstract))
        [self equationPressed];
    
    [self setNoticedValue:[self currentValue]];
    [self setArithmetic:HALArithmeticSubstractBegun];
}

- (void)equationPressed
{
    switch (self.arithmetic)
    {
        case HALArithmeticAdd:
            [self setCurrentValue:[self currentValue] + [self noticedValue]];
            break;
            
        case HALArithmeticSubstract:
            [self setCurrentValue:[self currentValue] - [self noticedValue]];
            break;
            
        default:
            break;
    }
    
    [self setArithmetic:HALArithmeticNone];
}

- (void)pokePressed
{
    [[HALJournal sharedJournal] poke:[self currentValue]];
}

- (void)peekPressed
{
    switch (self.arithmetic)
    {
        case HALArithmeticAddBegun:
            [self setArithmetic:HALArithmeticAdd];
            break;
            
        case HALArithmeticSubstractBegun:
            [self setArithmetic:HALArithmeticSubstract];
            break;
            
        default:
            break;
    }
}

- (NSString *)textForValue:(UInt64)value
             numeralSystem:(HALNumeralSystem)numeralSystem
{
    NSString *displayText;

    switch (numeralSystem)
    {
        case HALNumeralSystemOCT:
            displayText = [NSString stringWithFormat:@"%llO", value];
            break;
            
        case HALNumeralSystemDEC:
        {
            displayText = [NSString stringWithFormat:@"%llu", value];
            NSUInteger numberOfGroups = displayText.length / 3;
            NSUInteger digitsNotInGroup = displayText.length % 3;
            
            NSUInteger position = digitsNotInGroup;
            for (NSUInteger digitsGroup = 0; digitsGroup < numberOfGroups; digitsGroup++)
            {
                if ((digitsGroup == 0) && (digitsNotInGroup == 0))
                {
                    position += 3;
                    continue;
                }
                
                NSString *west = [displayText substringToIndex:position];
                NSString *east = [displayText substringFromIndex:position];
                displayText = [NSString stringWithFormat:@"%@,%@", west, east];
                
                position += 4;
            }
            
            break;
        }
            
        case HALNumeralSystemHEX:
        {
            displayText = [NSString stringWithFormat:@"%llX", value];
            
            while ((displayText.length % 4) > 0)
                displayText = [NSString stringWithFormat:@"0%@", displayText];
            
            NSUInteger numberOfWords = displayText.length / 4;
            
            NSUInteger position = 0;
            for (NSUInteger wordsGroup = 1; wordsGroup < numberOfWords; wordsGroup++)
            {
                position += 4;
                
                NSString *west = [displayText substringToIndex:position];
                NSString *east = [displayText substringFromIndex:position];
                displayText = [NSString stringWithFormat:@"%@:%@", west, east];
                
                position++;
            }
            
            break;
        }
    }
    
    return displayText;
}

@end
