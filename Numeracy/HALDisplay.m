//
//  Numeracy
//
//  Copyright (c) 2014 Meine Werke. All rights reserved.
//

#import "HALBrain.h"
#import "HALDisplay.h"

@interface HALDisplay ()

@property (assign, nonatomic) Boolean input;

@property (strong, nonatomic) UILabel *arithmeticLabel;
@property (strong, nonatomic) UILabel *systemLabel;
@property (strong, nonatomic) UILabel *valueLabel;

@end

@implementation HALDisplay

- (id)init:(Boolean)input
{
    self = [super init];
    if (self == nil)
        return nil;

    self.input = input;

    self.backgroundColor = (input)
        ? [UIColor whiteColor]
        : [UIColor colorWithRed:1.000f green:0.945f blue:0.922f alpha:1.0f];

    if (input == YES) {
        self.arithmeticLabel = [[UILabel alloc] init];
        self.arithmeticLabel.text = @"";
        self.arithmeticLabel.backgroundColor = [UIColor clearColor];
        self.arithmeticLabel.textColor = [UIColor blackColor];
        self.arithmeticLabel.textAlignment = NSTextAlignmentLeft;
        self.arithmeticLabel.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:self.arithmeticLabel];
    }
    
    self.systemLabel = [[UILabel alloc] init];
    self.systemLabel.text = @"";
    self.systemLabel.backgroundColor = [UIColor clearColor];
    self.systemLabel.textColor = (input) ? [UIColor blackColor] : [UIColor darkGrayColor];
    self.systemLabel.textAlignment = NSTextAlignmentLeft;
    self.systemLabel.font = [UIFont systemFontOfSize:12.0];
    [self addSubview:self.systemLabel];

    self.valueLabel = [[UILabel alloc] init];
    self.valueLabel.text = @"";
    self.valueLabel.backgroundColor = [UIColor clearColor];
    self.valueLabel.textColor = (input) ? [UIColor blackColor] : [UIColor darkGrayColor];
    self.valueLabel.textAlignment = NSTextAlignmentRight;
    self.valueLabel.font = [UIFont systemFontOfSize:28.0];
    self.valueLabel.numberOfLines = 0;
    [self.valueLabel setAdjustsFontSizeToFitWidth:YES];
    [self addSubview:self.valueLabel];

    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(fingerTap:)];
    [self addGestureRecognizer:recognizer];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(valueChanged:)
                                                 name:@"ValueChanged"
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(arithmeticChanged:)
                                                 name:@"ArithmeticChanged"
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(valueChanged:)
                                                 name:@"NumeralSystemChanged"
                                               object:nil];

    return self;
}

- (void)valueChanged:(NSNotification *)note
{
    HALBrain *brain = [HALBrain sharedBrain];
    
    HALNumeralSystem numeralSystem;
    
    if (self.input) {
        numeralSystem = [brain primusNumeralSystem];
    } else {
        numeralSystem = [brain cordusNumeralSystem];
    }

    switch (numeralSystem)
    {
        case HALNumeralSystemOCT:
            [self.systemLabel setText:@"OCT"];
            break;
            
        case HALNumeralSystemDEC:
            [self.systemLabel setText:@"DEC"];
            break;
            
        case HALNumeralSystemHEX:
            [self.systemLabel setText:@"HEX"];
            break;
    }

    NSString *displayText = [brain textForValue:[brain currentValue]
                                  numeralSystem:numeralSystem];

    [self.valueLabel setText:displayText];
}

- (void)arithmeticChanged:(NSNotification *)note
{
    HALBrain *brain = [HALBrain sharedBrain];
    
    if (self.arithmeticLabel != nil)
    {
        switch ([brain arithmetic])
        {
            case HALArithmeticAddBegun:
            case HALArithmeticAdd:
                [self.arithmeticLabel setText:@"ADD"];
                break;
                
            case HALArithmeticSubstractBegun:
            case HALArithmeticSubstract:
                [self.arithmeticLabel setText:@"SUB"];
                break;
                
            default:
                [self.arithmeticLabel setText:@""];
                break;
        }
    }
}

- (void)fingerTap:(UITapGestureRecognizer *)recognizer
{
    [self setAlpha:0.2f];
    
    [UIView beginAnimations:nil
                    context:nil];
    [UIView setAnimationDuration:0.4f];
    
    [self setAlpha:1.0f];
    
    [UIView commitAnimations];

    HALBrain *brain = [HALBrain sharedBrain];

    HALNumeralSystem numeralSystem;
    
    if (self.input) {
        numeralSystem = [brain primusNumeralSystem];
    } else {
        numeralSystem = [brain cordusNumeralSystem];
    }

    switch (numeralSystem)
    {
        case HALNumeralSystemOCT:
            numeralSystem = HALNumeralSystemDEC;
            break;
            
        case HALNumeralSystemDEC:
            numeralSystem = HALNumeralSystemHEX;
            break;
            
        case HALNumeralSystemHEX:
            numeralSystem = HALNumeralSystemOCT;
            break;
    }

    if (self.input) {
        [brain setPrimusNumeralSystem:numeralSystem];
    } else {
        [brain setCordusNumeralSystem:numeralSystem];
    }
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];

    CGRect rect;
    
    if (self.arithmeticLabel != nil) {
        rect = CGRectMake(4, 6, 40, 12);
        [self.arithmeticLabel setFrame:rect];
    }

    rect = CGRectMake(4, frame.size.height - 16, 40, 12);
    [self.systemLabel setFrame:rect];

    rect = CGRectMake(32, 2, frame.size.width - 42, frame.size.height - 4);
    [self.valueLabel setFrame:rect];
}

- (void)drawRect:(CGRect)rect
{
    NSString *imageName = (self.arithmeticLabel != nil) ? @"DisplayPrimus" : @"DisplayCordus";
    UIImage *backgroundImage = [UIImage imageNamed:imageName];
    [backgroundImage drawInRect:rect];
}

@end
