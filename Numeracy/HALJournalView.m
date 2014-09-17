//
//  Numeracy
//
//  Copyright (c) 2014 Meine Werke. All rights reserved.
//

#import "HALJournal.h"
#import "HALJournalPage.h"
#import "HALJournalRecord.h"
#import "HALJournalView.h"
#import "HALJournalViewCell.h"

@interface HALJournalView ()

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation HALJournalView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self == nil)
        return nil;
    
    frame = [self bounds];

    self.tableView = [[UITableView alloc] initWithFrame:frame
                                                  style:UITableViewStylePlain];
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];

    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f)
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    [self.tableView setSeparatorColor:[UIColor colorWithRed:1.000f green:0.502f blue:0.000f alpha:1.0f]];
    
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    
    [self addSubview:self.tableView];

    return self;
}

- (void)refresh
{
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    HALJournal *journal = [HALJournal sharedJournal];
    return [[journal pages] count];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    HALJournal *journal = [HALJournal sharedJournal];
    HALJournalPage *page = [[journal pages] objectAtIndex:section];
    return [[page records] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    HALJournal *journal = [HALJournal sharedJournal];
    HALJournalPage *page = [[journal pages] objectAtIndex:section];

    return [NSDateFormatter localizedStringFromDate:[page date]
                                          dateStyle:NSDateFormatterMediumStyle
                                          timeStyle:NSDateFormatterNoStyle];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"%lux%lu",
                                (long)indexPath.section,
                                (long)indexPath.row];

    HALJournalViewCell *cell;
    cell = (HALJournalViewCell *)[self.tableView dequeueReusableCellWithIdentifier:nil/*cellIdentifier*/];
    if (cell == nil) {
        HALJournal *journal = [HALJournal sharedJournal];
        HALJournalPage *page = [[journal pages] objectAtIndex:indexPath.section];
        HALJournalRecord *record = [[page records] objectAtIndex:indexPath.row];
        cell = [[HALJournalViewCell alloc] initWithIdentifier:cellIdentifier
                                                       record:record];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 32 : 48;
}

- (BOOL)tableView:(UITableView *)tableView
shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)tableView:(UITableView *)tableView
accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d %d", indexPath.section, indexPath.row);
}

@end
