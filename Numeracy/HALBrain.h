//
//  Numeracy
//
//  Copyright (c) 2014 Meine Werke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HALBrain : NSObject

typedef enum
{
    HALNumeralSystemOCT = 0,
    HALNumeralSystemDEC = 1,
    HALNumeralSystemHEX = 2
} HALNumeralSystem;

typedef enum
{
    HALArithmeticNone,
    HALArithmeticAddBegun,
    HALArithmeticAdd,
    HALArithmeticSubstractBegun,
    HALArithmeticSubstract
} HALArithmetic;

@property (assign, nonatomic) UInt64 currentValue;
@property (assign, nonatomic) UInt64 noticedValue;
@property (assign, nonatomic) HALArithmetic arithmetic;
@property (assign, nonatomic) HALNumeralSystem primusNumeralSystem;
@property (assign, nonatomic) HALNumeralSystem cordusNumeralSystem;

+ (HALBrain *)sharedBrain;

- (void)saveData;

- (void)loadData;

- (void)digitPressed:(short)digit;

- (void)backspacePressed;

- (void)shiftLeftPressed;

- (void)shiftRightPressed;

- (void)clearPressed;

- (void)resetPressed;

- (void)plusPressed;

- (void)minusPressed;

- (void)equationPressed;

- (void)pokePressed;

- (void)peekPressed;

- (NSString *)textForValue:(UInt64)value
             numeralSystem:(HALNumeralSystem)numeralSystem;

@end
