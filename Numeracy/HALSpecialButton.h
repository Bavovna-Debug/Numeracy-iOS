//
//  Numeracy
//
//  Copyright (c) 2014 Meine Werke. All rights reserved.
//

#import "HALButton.h"

@interface HALSpecialButton : HALButton

typedef enum
{
    NumeracySpecialButtonSign,
    NumeracySpecialButtonBackspace,
    NumeracySpecialButtonClear,
    NumeracySpecialButtonReset,
    NumeracySpecialButtonShiftLeft,
    NumeracySpecialButtonShiftRight,
    NumeracySpecialButtonPlus,
    NumeracySpecialButtonMinus,
    NumeracySpecialButtonEquation,
    NumeracySpecialButtonPoke,
    NumeracySpecialButtonPeek
} NumeracySpecialButtonType;

- (id)init:(NumeracySpecialButtonType)buttonType;

@end
