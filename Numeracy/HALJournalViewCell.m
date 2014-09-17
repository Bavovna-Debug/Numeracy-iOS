//
//  Numeracy
//
//  Copyright (c) 2014 Meine Werke. All rights reserved.
//

#import "HALBrain.h"
#import "HALJournalViewCell.h"

@interface HALJournalViewCell ()

@property (weak, nonatomic) HALJournalRecord *record;
//@property (strong, nonatomic) UITextField *label;
@property (strong, nonatomic) UILabel *valueHEX;
@property (strong, nonatomic) UILabel *valueDEC;

@end

@implementation HALJournalViewCell

- (id)initWithIdentifier:(NSString *)cellIdentifier
                  record:(HALJournalRecord *)record
{
    self = [super initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:cellIdentifier];
    if (self == nil)
        return nil;
    
    self.record = record;

    UIButton *accessoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [accessoryButton setFrame:CGRectMake(0, 0, 28, 28)];
    [accessoryButton setBackgroundColor:[UIColor clearColor]];
    [accessoryButton setBackgroundImage:[UIImage imageNamed:@"Journal-DeleteButton"]
                               forState:UIControlStateNormal];
    [accessoryButton addTarget:self
                        action:@selector(didTouchDeleteButton)
              forControlEvents:UIControlEventTouchUpInside];
    
    [self setAccessoryView:accessoryButton];
    [self setAccessoryType:UITableViewCellAccessoryDetailButton];

    CGSize cellSize;
    CGSize margin;
    
    CGFloat nameFontSize;
    CGFloat valueFontSize;
    CGFloat timestampFontSize;

    CGRect nameRect;
    CGRect hexValueRect;
    CGRect decValueRect;

    margin = CGSizeMake(8.0f, 0.0f);
    //nameFontSize = 16.0f;
    valueFontSize = 15.0f;
    timestampFontSize = 15.0f;
    
    //UIFont *nameFont = [UIFont systemFontOfSize:nameFontSize];
    UIFont *valueFont = [UIFont boldSystemFontOfSize:valueFontSize];
    
    //UIColor *nameColor = [UIColor blackColor];
    UIColor *hexValueColor = [UIColor darkTextColor];
    UIColor *decValueColor = [UIColor darkGrayColor];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        cellSize = CGSizeMake(768.0f, 32.0f);
        
        //nameRect = CGRectMake(0, 0, 100, cellSize.height);
        hexValueRect = CGRectMake(100, 0, 100, cellSize.height);
        decValueRect = CGRectMake(200, 0, 100, cellSize.height);
    } else {
        cellSize = CGSizeMake(320.0f, 48.0f);

        //nameRect = CGRectMake(0, 0, 200, cellSize.height * 0.4f);
        hexValueRect = CGRectMake(0, cellSize.height * 0.0f, cellSize.width - 80, cellSize.height * 0.5f);
        decValueRect = CGRectMake(0, cellSize.height * 0.5f, cellSize.width - 80, cellSize.height * 0.5f);
    }

    /*
    self.label = [[UITextField alloc] initWithFrame:nameRect];
    [self.label setBackgroundColor:[UIColor clearColor]];
    [self.label setTextColor:nameColor];
    [self.label setFont:nameFont];
    [self.label setBorderStyle:UITextBorderStyleRoundedRect];
     */

    self.valueHEX = [[UILabel alloc] initWithFrame:hexValueRect];
    [self.valueHEX setBackgroundColor:[UIColor clearColor]];
    [self.valueHEX setTextColor:hexValueColor];
    [self.valueHEX setFont:valueFont];
    [self.valueHEX setTextAlignment:NSTextAlignmentRight];

    self.valueDEC = [[UILabel alloc] initWithFrame:decValueRect];
    [self.valueDEC setBackgroundColor:[UIColor clearColor]];
    [self.valueDEC setTextColor:decValueColor];
    [self.valueDEC setFont:valueFont];
    [self.valueDEC setTextAlignment:NSTextAlignmentRight];

    //[self.contentView addSubview:self.label];
    [self.contentView addSubview:self.valueHEX];
    [self.contentView addSubview:self.valueDEC];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        UILabel *labelHEX = [[UILabel alloc] initWithFrame:hexValueRect];
        [labelHEX setBackgroundColor:[UIColor clearColor]];
        [labelHEX setTextColor:hexValueColor];
        [labelHEX setFont:valueFont];
        [labelHEX setTextAlignment:NSTextAlignmentLeft];
        [labelHEX setText:@"HEX:"];
        
        UILabel *labelDEC = [[UILabel alloc] initWithFrame:decValueRect];
        [labelDEC setBackgroundColor:[UIColor clearColor]];
        [labelDEC setTextColor:decValueColor];
        [labelDEC setFont:valueFont];
        [labelDEC setTextAlignment:NSTextAlignmentLeft];
        [labelDEC setText:@"DEC:"];
        
        [self.contentView addSubview:labelHEX];
        [self.contentView addSubview:labelDEC];
    }

    [self updateValues];

    return self;
}

- (void)updateValues
{
    HALBrain *brain = [HALBrain sharedBrain];

    //[self.label setText:[self.record label]];

    [self.valueHEX setText:[brain textForValue:[self.record value]
                                 numeralSystem:HALNumeralSystemHEX]];
    [self.valueDEC setText:[brain textForValue:[self.record value]
                                 numeralSystem:HALNumeralSystemDEC]];
}

- (void)didTouchDeleteButton
{
}

@end
