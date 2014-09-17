//
//  Numeracy
//
//  Copyright (c) 2014 Meine Werke. All rights reserved.
//

#import "HALBrain.h"
#import "HALDigitButton.h"
#import "HALDisplay.h"
#import "HALDisplayLED.h"
#import "HALJournalView.h"
#import "HALMainViewController.h"
#import "HALSpecialButton.h"

@interface HALMainViewController ()

@property (strong, nonatomic) UIView *calcPanel;
@property (strong, nonatomic) HALJournalView *journalView;

@property (strong, nonatomic) HALDisplay *primusDisplay;
@property (strong, nonatomic) HALDisplay *cordusDisplay;
@property (strong, nonatomic) HALDisplayLED *binaryDisplay;

@property (strong, nonatomic) HALDigitButton *digitButton0;
@property (strong, nonatomic) HALDigitButton *digitButton1;
@property (strong, nonatomic) HALDigitButton *digitButton2;
@property (strong, nonatomic) HALDigitButton *digitButton3;
@property (strong, nonatomic) HALDigitButton *digitButton4;
@property (strong, nonatomic) HALDigitButton *digitButton5;
@property (strong, nonatomic) HALDigitButton *digitButton6;
@property (strong, nonatomic) HALDigitButton *digitButton7;
@property (strong, nonatomic) HALDigitButton *digitButton8;
@property (strong, nonatomic) HALDigitButton *digitButton9;
@property (strong, nonatomic) HALDigitButton *digitButtonA;
@property (strong, nonatomic) HALDigitButton *digitButtonB;
@property (strong, nonatomic) HALDigitButton *digitButtonC;
@property (strong, nonatomic) HALDigitButton *digitButtonD;
@property (strong, nonatomic) HALDigitButton *digitButtonE;
@property (strong, nonatomic) HALDigitButton *digitButtonF;

@property (strong, nonatomic) HALSpecialButton *signButton;
@property (strong, nonatomic) HALSpecialButton *backspaceButton;

@property (strong, nonatomic) HALSpecialButton *shiftLeftButton;
@property (strong, nonatomic) HALSpecialButton *shiftRightButton;

@property (strong, nonatomic) HALSpecialButton *plusButton;
@property (strong, nonatomic) HALSpecialButton *minusButton;
@property (strong, nonatomic) HALSpecialButton *equationButton;

@property (strong, nonatomic) HALSpecialButton *clearButton;
@property (strong, nonatomic) HALSpecialButton *resetButton;

@property (strong, nonatomic) HALSpecialButton *pokeButton;
@property (strong, nonatomic) HALSpecialButton *peekButton;

@end

@implementation HALMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    CGRect frame = [self.view bounds];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) {
        frame.origin.y += 20;
        frame.size.height -= 20;
    } else {
        frame.size.height -= 20;
    }

    UIColor *backgroundColor = [UIColor colorWithRed:0.792f green:0.792f blue:0.792f alpha:1.0f];
    UIColor *digitButtonColor = [UIColor colorWithRed:1.000f green:0.718f blue:0.396f alpha:1.0f];
    UIColor *arythmeticButtonColor = [UIColor colorWithRed:1.000f green:0.490f blue:0.290f alpha:1.0f];
    UIColor *resetButtonColor = [UIColor colorWithRed:0.792f green:0.184f blue:0.122f alpha:1.0f];
    
    [self.view setBackgroundColor:backgroundColor];

    self.calcPanel = [[UIView alloc] init];

    self.journalView = [[HALJournalView alloc] init];

    self.primusDisplay = [[HALDisplay alloc] init:YES];
    
    self.cordusDisplay = [[HALDisplay alloc] init:NO];
    
    self.binaryDisplay = [[HALDisplayLED alloc] init];
    [self.binaryDisplay setBackgroundColor:backgroundColor];
    
    self.digitButton0 = [[HALDigitButton alloc] init:0x0];
    self.digitButton1 = [[HALDigitButton alloc] init:0x1];
    self.digitButton2 = [[HALDigitButton alloc] init:0x2];
    self.digitButton3 = [[HALDigitButton alloc] init:0x3];
    self.digitButton4 = [[HALDigitButton alloc] init:0x4];
    self.digitButton5 = [[HALDigitButton alloc] init:0x5];
    self.digitButton6 = [[HALDigitButton alloc] init:0x6];
    self.digitButton7 = [[HALDigitButton alloc] init:0x7];
    self.digitButton8 = [[HALDigitButton alloc] init:0x8];
    self.digitButton9 = [[HALDigitButton alloc] init:0x9];
    self.digitButtonA = [[HALDigitButton alloc] init:0xA];
    self.digitButtonB = [[HALDigitButton alloc] init:0xB];
    self.digitButtonC = [[HALDigitButton alloc] init:0xC];
    self.digitButtonD = [[HALDigitButton alloc] init:0xD];
    self.digitButtonE = [[HALDigitButton alloc] init:0xE];
    self.digitButtonF = [[HALDigitButton alloc] init:0xF];
    self.signButton = [[HALSpecialButton alloc] init:NumeracySpecialButtonSign];
    self.backspaceButton = [[HALSpecialButton alloc] init:NumeracySpecialButtonBackspace];
    self.shiftLeftButton = [[HALSpecialButton alloc] init:NumeracySpecialButtonShiftLeft];
    self.shiftRightButton = [[HALSpecialButton alloc] init:NumeracySpecialButtonShiftRight];
    self.plusButton = [[HALSpecialButton alloc] init:NumeracySpecialButtonPlus];
    self.minusButton = [[HALSpecialButton alloc] init:NumeracySpecialButtonMinus];
    self.equationButton = [[HALSpecialButton alloc] init:NumeracySpecialButtonEquation];
    self.clearButton = [[HALSpecialButton alloc] init:NumeracySpecialButtonClear];
    self.resetButton = [[HALSpecialButton alloc] init:NumeracySpecialButtonReset];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        self.pokeButton = [[HALSpecialButton alloc] init:NumeracySpecialButtonPoke];
        self.peekButton = [[HALSpecialButton alloc] init:NumeracySpecialButtonPeek];
    }
    
    [self.calcPanel setBackgroundColor:[UIColor blackColor]];
    [self.journalView setBackgroundColor:[UIColor lightGrayColor]];
    [self.digitButton0 setColor:digitButtonColor];
    [self.digitButton1 setColor:digitButtonColor];
    [self.digitButton2 setColor:digitButtonColor];
    [self.digitButton3 setColor:digitButtonColor];
    [self.digitButton4 setColor:digitButtonColor];
    [self.digitButton5 setColor:digitButtonColor];
    [self.digitButton6 setColor:digitButtonColor];
    [self.digitButton7 setColor:digitButtonColor];
    [self.digitButton8 setColor:digitButtonColor];
    [self.digitButton9 setColor:digitButtonColor];
    [self.digitButtonA setColor:digitButtonColor];
    [self.digitButtonB setColor:digitButtonColor];
    [self.digitButtonC setColor:digitButtonColor];
    [self.digitButtonD setColor:digitButtonColor];
    [self.digitButtonE setColor:digitButtonColor];
    [self.digitButtonF setColor:digitButtonColor];
    [self.signButton setColor:digitButtonColor];
    [self.backspaceButton setColor:digitButtonColor];
    [self.shiftLeftButton setColor:arythmeticButtonColor];
    [self.shiftRightButton setColor:arythmeticButtonColor];
    [self.plusButton setColor:arythmeticButtonColor];
    [self.minusButton setColor:arythmeticButtonColor];
    [self.equationButton setColor:arythmeticButtonColor];
    [self.clearButton setColor:resetButtonColor];
    [self.resetButton setColor:resetButtonColor];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self.pokeButton setColor:arythmeticButtonColor];
        [self.peekButton setColor:arythmeticButtonColor];
    }

    [self reorganize];

    [self.view addSubview:self.calcPanel];
    [self.view addSubview:self.journalView];

    [self.calcPanel addSubview:self.primusDisplay];
    [self.calcPanel addSubview:self.cordusDisplay];
    [self.calcPanel addSubview:self.binaryDisplay];
    [self.calcPanel addSubview:self.digitButton0];
    [self.calcPanel addSubview:self.digitButton1];
    [self.calcPanel addSubview:self.digitButton2];
    [self.calcPanel addSubview:self.digitButton3];
    [self.calcPanel addSubview:self.digitButton4];
    [self.calcPanel addSubview:self.digitButton5];
    [self.calcPanel addSubview:self.digitButton6];
    [self.calcPanel addSubview:self.digitButton7];
    [self.calcPanel addSubview:self.digitButton8];
    [self.calcPanel addSubview:self.digitButton9];
    [self.calcPanel addSubview:self.digitButtonA];
    [self.calcPanel addSubview:self.digitButtonB];
    [self.calcPanel addSubview:self.digitButtonC];
    [self.calcPanel addSubview:self.digitButtonD];
    [self.calcPanel addSubview:self.digitButtonE];
    [self.calcPanel addSubview:self.digitButtonF];
    [self.calcPanel addSubview:self.signButton];
    [self.calcPanel addSubview:self.backspaceButton];
    [self.calcPanel addSubview:self.shiftLeftButton];
    [self.calcPanel addSubview:self.shiftRightButton];
    [self.calcPanel addSubview:self.plusButton];
    [self.calcPanel addSubview:self.minusButton];
    [self.calcPanel addSubview:self.equationButton];
    [self.calcPanel addSubview:self.clearButton];
    [self.calcPanel addSubview:self.resetButton];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self.calcPanel addSubview:self.pokeButton];
        [self.calcPanel addSubview:self.peekButton];
    }

    [self.peekButton addTarget:self
                        action:@selector(didTouchPeekButton)
              forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:@"UIDeviceOrientationDidChangeNotification"
                                               object:nil];
    
    [self.primusDisplay setNeedsDisplay];
    [self.cordusDisplay setNeedsDisplay];
    [self.binaryDisplay setNeedsDisplay];

    [self reorganize];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"UIDeviceOrientationDidChangeNotification"
                                                  object:nil];
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

/*
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
	    return (toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	} else {
	    return YES;
	}
}
*/

- (void)orientationChanged:(NSNotification *)notification
{
    UIDeviceOrientation deviceOrientation = [[UIDevice currentDevice] orientation];
    if (deviceOrientation == UIDeviceOrientationFaceDown)
        return;

    [self reorganize];
}

- (void)reorganize
{
    UIDevice *device = [UIDevice currentDevice];
    UIDeviceOrientation deviceOrientation = device.orientation;
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    if ((screenSize.width == 320) && (screenSize.height == 480))
    {
        if (UIInterfaceOrientationIsPortrait(deviceOrientation)) {
            CGRect rect;

            rect = CGRectMake(0, 0, 320, 460);
            [self.calcPanel setAlpha:1.0f];
            [self.calcPanel setFrame:rect];
            [self.journalView setFrame:CGRectOffset(rect, rect.size.width, 0)];

            rect = CGRectMake(0, 0, 320, 42);
            [self.primusDisplay setFrame:rect];
            
            rect = CGRectOffset(rect, 0, rect.size.height);
            [self.cordusDisplay setFrame:rect];
            
            [self.binaryDisplay setHidden:YES];
            
            rect = CGRectMake(0, 408, 80, 54);
            [self.signButton setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButton0 setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.backspaceButton setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.digitButton1 setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButton2 setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.digitButton3 setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.digitButton4 setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButton5 setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.digitButton6 setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.digitButton7 setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButton8 setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.digitButton9 setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.digitButtonA setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButtonB setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.digitButtonC setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.digitButtonD setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButtonE setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.digitButtonF setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.shiftLeftButton setFrame:CGRectOffset(rect, 0, 0)];
            [self.shiftRightButton setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.pokeButton setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            [self.peekButton setFrame:CGRectOffset(rect, rect.size.width * 3, 0)];
            
            rect = CGRectMake(240, 408, 80, 54);
            [self.resetButton setFrame:rect];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.clearButton setFrame:rect];
            rect = CGRectOffset(rect, 0, -rect.size.height * 2);
            [self.equationButton setFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height * 2)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.minusButton setFrame:rect];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.plusButton setFrame:rect];
        } else if (UIInterfaceOrientationIsLandscape(deviceOrientation)) {
            CGRect rect;

            rect = CGRectMake(0, 0, 480, 300);
            [self.calcPanel setAlpha:1.0f];
            [self.calcPanel setFrame:rect];
            [self.journalView setFrame:CGRectOffset(rect, 0, rect.size.height)];

            rect = CGRectMake(0, 0, 264, 50);
            [self.primusDisplay setFrame:rect];
            
            rect = CGRectOffset(rect, 0, rect.size.height);
            [self.cordusDisplay setFrame:rect];
            
            rect = CGRectMake(0, 100, 264, 100);
            [self.binaryDisplay setFrame:rect];
            [self.binaryDisplay setHidden:NO];
            
            rect = CGRectMake(264, 250, 72, 50);
            [self.signButton setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButton0 setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.backspaceButton setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.digitButton1 setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButton2 setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.digitButton3 setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.digitButton4 setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButton5 setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.digitButton6 setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.digitButton7 setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButton8 setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.digitButton9 setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.digitButtonA setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButtonB setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.digitButtonC setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.digitButtonD setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButtonE setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.digitButtonF setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            
            rect = CGRectMake(0, 200, 40, 50);
            [self.clearButton setFrame:rect];
            rect = CGRectOffset(rect, 0, rect.size.height);
            [self.resetButton setFrame:rect];
            
            rect = CGRectMake(40, 200, 62, 50);
            [self.pokeButton setFrame:CGRectOffset(rect, 0, 0)];
            [self.peekButton setFrame:CGRectOffset(rect, 0, rect.size.height)];
            rect = CGRectOffset(rect, rect.size.width, 0);
            rect.size.width = 54;
            [self.shiftLeftButton setFrame:CGRectOffset(rect, 0, 0)];
            [self.shiftRightButton setFrame:CGRectOffset(rect, 0, rect.size.height)];
            rect = CGRectOffset(rect, rect.size.width, 0);
            [self.plusButton setFrame:CGRectOffset(rect, 0, 0)];
            [self.minusButton setFrame:CGRectOffset(rect, 0, rect.size.height)];
            rect = CGRectOffset(rect, rect.size.width, 0);
            rect.size.height *= 2;
            [self.equationButton setFrame:rect];
        }
    }
    else if ((screenSize.width == 320) && (screenSize.height == 568))
    {
        if (UIInterfaceOrientationIsPortrait(deviceOrientation)) {
            CGRect rect;

            rect = CGRectMake(0, 20, 320, 548);
            [self.calcPanel setAlpha:1.0f];
            [self.calcPanel setFrame:rect];
            [self.journalView setFrame:CGRectOffset(rect, rect.size.width, 0)];

            rect = CGRectMake(0, 0, 320, 42);
            [self.primusDisplay setFrame:rect];
            
            rect = CGRectOffset(rect, 0, rect.size.height);
            [self.cordusDisplay setFrame:rect];
            
            rect = CGRectMake(0, 84, 320, 102);
            [self.binaryDisplay setFrame:rect];
            
            rect = CGRectMake(0, 498, 80, 52);
            [self.signButton setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButton0 setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.backspaceButton setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.digitButton1 setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButton2 setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.digitButton3 setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.digitButton4 setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButton5 setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.digitButton6 setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.digitButton7 setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButton8 setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.digitButton9 setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.digitButtonA setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButtonB setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.digitButtonC setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.digitButtonD setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButtonE setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.digitButtonF setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.shiftLeftButton setFrame:CGRectOffset(rect, 0, 0)];
            [self.shiftRightButton setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.pokeButton setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            [self.peekButton setFrame:CGRectOffset(rect, rect.size.width * 3, 0)];
            
            rect = CGRectMake(240, 498, 80, 52);
            [self.resetButton setFrame:rect];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.clearButton setFrame:rect];
            rect = CGRectOffset(rect, 0, -rect.size.height * 2);
            [self.equationButton setFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height * 2)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.minusButton setFrame:rect];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.plusButton setFrame:rect];
        } else if (UIInterfaceOrientationIsLandscape(deviceOrientation)) {
            CGRect rect;

            rect = CGRectMake(0, 20, 568, 300);
            [self.calcPanel setAlpha:1.0f];
            [self.calcPanel setFrame:rect];
            [self.journalView setFrame:CGRectOffset(rect, 0, rect.size.height)];

            rect = CGRectMake(0, 0, 328, 50);
            [self.primusDisplay setFrame:rect];
            
            rect = CGRectOffset(rect, 0, rect.size.height);
            [self.cordusDisplay setFrame:rect];
            
            rect = CGRectMake(0, 100, 328, 100);
            [self.binaryDisplay setFrame:rect];
            
            rect = CGRectMake(328, 250, 80, 50);
            [self.signButton setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButton0 setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.backspaceButton setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.digitButton1 setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButton2 setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.digitButton3 setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.digitButton4 setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButton5 setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.digitButton6 setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.digitButton7 setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButton8 setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.digitButton9 setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.digitButtonA setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButtonB setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.digitButtonC setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.digitButtonD setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButtonE setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.digitButtonF setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            
            rect = CGRectMake(0, 200, 48, 50);
            [self.clearButton setFrame:rect];
            rect = CGRectOffset(rect, 0, rect.size.height);
            [self.resetButton setFrame:rect];
            
            rect = CGRectMake(48, 200, 88, 50);
            [self.pokeButton setFrame:CGRectOffset(rect, 0, 0)];
            [self.peekButton setFrame:CGRectOffset(rect, 0, rect.size.height)];
            rect = CGRectOffset(rect, rect.size.width, 0);
            rect.size.width = 64;
            [self.shiftLeftButton setFrame:CGRectOffset(rect, 0, 0)];
            [self.shiftRightButton setFrame:CGRectOffset(rect, 0, rect.size.height)];
            rect = CGRectOffset(rect, rect.size.width, 0);
            [self.plusButton setFrame:CGRectOffset(rect, 0, 0)];
            [self.minusButton setFrame:CGRectOffset(rect, 0, rect.size.height)];
            rect = CGRectOffset(rect, rect.size.width, 0);
            rect.size.height *= 2;
            [self.equationButton setFrame:rect];
        }
    }
    else if ((screenSize.width == 768) && (screenSize.height == 1024))
    {
        if (UIInterfaceOrientationIsPortrait(deviceOrientation)) {
            CGRect rect;
            
            rect = CGRectMake(128, 48, 512, 192);
            [self.binaryDisplay setFrame:rect];
            
            rect = CGRectMake(160, 272, 448, 60);
            [self.primusDisplay setFrame:rect];
            
            rect = CGRectOffset(rect, 0, rect.size.height);
            [self.cordusDisplay setFrame:rect];
            
            rect = CGRectMake(160, 880, 112, 80);
            [self.signButton setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButton0 setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.backspaceButton setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.digitButton1 setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButton2 setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.digitButton3 setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.digitButton4 setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButton5 setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.digitButton6 setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.digitButton7 setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButton8 setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.digitButton9 setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.digitButtonA setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButtonB setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.digitButtonC setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.digitButtonD setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButtonE setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.digitButtonF setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.shiftLeftButton setFrame:CGRectOffset(rect, 0, 0)];
            [self.shiftRightButton setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.pokeButton setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            [self.peekButton setFrame:CGRectOffset(rect, rect.size.width * 3, 0)];
            
            rect = CGRectMake(496, 880, 112, 80);
            [self.resetButton setFrame:rect];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.clearButton setFrame:rect];
            rect = CGRectOffset(rect, 0, -rect.size.height * 2);
            [self.equationButton setFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height * 2)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.minusButton setFrame:rect];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.plusButton setFrame:rect];
        } else if (UIInterfaceOrientationIsLandscape(deviceOrientation)) {
            CGRect rect;
            
            rect = CGRectMake(48, 64, 420, 640);
            [self.binaryDisplay setFrame:rect];
            
            rect = CGRectMake(528, 48, 448, 60);
            [self.primusDisplay setFrame:rect];
            
            rect = CGRectOffset(rect, 0, rect.size.height);
            [self.cordusDisplay setFrame:rect];
            
            rect = CGRectMake(528, 648, 112, 80);
            [self.signButton setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButton0 setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.backspaceButton setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.digitButton1 setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButton2 setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.digitButton3 setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.digitButton4 setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButton5 setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.digitButton6 setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.digitButton7 setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButton8 setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.digitButton9 setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.digitButtonA setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButtonB setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.digitButtonC setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.digitButtonD setFrame:CGRectOffset(rect, 0, 0)];
            [self.digitButtonE setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.digitButtonF setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.shiftLeftButton setFrame:CGRectOffset(rect, 0, 0)];
            [self.shiftRightButton setFrame:CGRectOffset(rect, rect.size.width, 0)];
            [self.pokeButton setFrame:CGRectOffset(rect, rect.size.width * 2, 0)];
            [self.peekButton setFrame:CGRectOffset(rect, rect.size.width * 3, 0)];
            
            rect = CGRectMake(864, 648, 112, 80);
            [self.resetButton setFrame:rect];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.clearButton setFrame:rect];
            rect = CGRectOffset(rect, 0, -rect.size.height * 2);
            [self.equationButton setFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height * 2)];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.minusButton setFrame:rect];
            rect = CGRectOffset(rect, 0, -rect.size.height);
            [self.plusButton setFrame:rect];
            
        }
    }
    else
    {
        NSLog(@"Unknown screen resolution %f x %f", screenSize.width, screenSize.height);
    }
}

- (void)numeralSystemChanged
{
    HALBrain *brain = [HALBrain sharedBrain];

    switch ([brain primusNumeralSystem])
    {
        case HALNumeralSystemOCT:
            self.digitButton0.enabled = YES;
            self.digitButton1.enabled = YES;
            self.digitButton2.enabled = YES;
            self.digitButton3.enabled = YES;
            self.digitButton4.enabled = YES;
            self.digitButton5.enabled = YES;
            self.digitButton6.enabled = YES;
            self.digitButton7.enabled = YES;
            self.digitButton8.enabled = NO;
            self.digitButton9.enabled = NO;
            self.digitButtonA.enabled = NO;
            self.digitButtonB.enabled = NO;
            self.digitButtonC.enabled = NO;
            self.digitButtonD.enabled = NO;
            self.digitButtonE.enabled = NO;
            self.digitButtonF.enabled = NO;
            break;
            
        case HALNumeralSystemDEC:
            self.digitButton0.enabled = YES;
            self.digitButton1.enabled = YES;
            self.digitButton2.enabled = YES;
            self.digitButton3.enabled = YES;
            self.digitButton4.enabled = YES;
            self.digitButton5.enabled = YES;
            self.digitButton6.enabled = YES;
            self.digitButton7.enabled = YES;
            self.digitButton8.enabled = YES;
            self.digitButton9.enabled = YES;
            self.digitButtonA.enabled = NO;
            self.digitButtonB.enabled = NO;
            self.digitButtonC.enabled = NO;
            self.digitButtonD.enabled = NO;
            self.digitButtonE.enabled = NO;
            self.digitButtonF.enabled = NO;
            break;
            
        case HALNumeralSystemHEX:
            self.digitButton0.enabled = YES;
            self.digitButton1.enabled = YES;
            self.digitButton2.enabled = YES;
            self.digitButton3.enabled = YES;
            self.digitButton4.enabled = YES;
            self.digitButton5.enabled = YES;
            self.digitButton6.enabled = YES;
            self.digitButton7.enabled = YES;
            self.digitButton8.enabled = YES;
            self.digitButton9.enabled = YES;
            self.digitButtonA.enabled = YES;
            self.digitButtonB.enabled = YES;
            self.digitButtonC.enabled = YES;
            self.digitButtonD.enabled = YES;
            self.digitButtonE.enabled = YES;
            self.digitButtonF.enabled = YES;
            break;
            
        default:
            break;
    }
}

- (void)didTouchPeekButton
{
    [self.journalView refresh];

    [UIView beginAnimations:nil
                    context:nil];
    [UIView setAnimationDuration:0.4f];
    
    [self.calcPanel setAlpha:0.0f];
    [self.journalView setFrame:[self.calcPanel frame]];

    [UIView commitAnimations];
}

@end
