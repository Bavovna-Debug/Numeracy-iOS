//
//  Numeracy
//
//  Copyright (c) 2014 Meine Werke. All rights reserved.
//

#import "HALBrain.h"
#import "HALSpecialButton.h"

@interface HALSpecialButton ()

@property (assign, nonatomic) NumeracySpecialButtonType buttonType;

@end

@implementation HALSpecialButton

@synthesize buttonType = _buttonType;

- (id)init:(NumeracySpecialButtonType)buttonType
{
    self = [super init];
    if (self == nil)
        return nil;
    
    self.buttonType = buttonType;

    switch (self.buttonType)
    {
        case NumeracySpecialButtonSign:
            [self setLabel:@"+/-" fontSize:20];
            break;

        case NumeracySpecialButtonBackspace:
            [self setLabel:@"DEL" fontSize:20];
            break;
            
        case NumeracySpecialButtonPlus:
            [self setLabel:@"+" fontSize:28];
            break;

        case NumeracySpecialButtonShiftLeft:
            [self setLabel:@"<<" fontSize:20];
            break;

        case NumeracySpecialButtonShiftRight:
            [self setLabel:@">>" fontSize:20];
            break;

        case NumeracySpecialButtonMinus:
            [self setLabel:@"-" fontSize:28];
            break;

        case NumeracySpecialButtonEquation:
            [self setLabel:@"=" fontSize:28];
            break;

        case NumeracySpecialButtonClear:
            [self setLabel:@"C" fontSize:20];
            break;

        case NumeracySpecialButtonReset:
            [self setLabel:@"AC" fontSize:20];
            break;

        case NumeracySpecialButtonPoke:
            [self setLabel:@"POKE" fontSize:20];
            break;
            
        case NumeracySpecialButtonPeek:
            [self setLabel:@"PEEK" fontSize:20];
            break;
    }

    [self addTarget:self action:@selector(didTouchButton) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

- (void)didTouchButton
{
    HALBrain *brain = [HALBrain sharedBrain];

    switch (self.buttonType)
    {
        case NumeracySpecialButtonSign:
            //[brain signPressed];
            break;

        case NumeracySpecialButtonBackspace:
            [brain backspacePressed];
            break;

        case NumeracySpecialButtonShiftLeft:
            [brain shiftLeftPressed];
            break;

        case NumeracySpecialButtonShiftRight:
            [brain shiftRightPressed];
            break;

        case NumeracySpecialButtonPlus:
            [brain plusPressed];
            break;
            
        case NumeracySpecialButtonMinus:
            [brain minusPressed];
            break;
            
        case NumeracySpecialButtonEquation:
            [brain equationPressed];
            break;

        case NumeracySpecialButtonClear:
            [brain clearPressed];
            break;

        case NumeracySpecialButtonReset:
            [brain resetPressed];
            break;
            
        case NumeracySpecialButtonPoke:
            [brain pokePressed];
            break;
            
        case NumeracySpecialButtonPeek:
            [brain peekPressed];
            break;
    }
}

@end
