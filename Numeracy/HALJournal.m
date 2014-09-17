//
//  Numeracy
//
//  Copyright (c) 2014 Meine Werke. All rights reserved.
//

#import "HALJournal.h"
#import "HALJournalPage.h"
#import "HALJournalRecord.h"

@implementation HALJournal

+ (HALJournal *)sharedJournal
{
    static dispatch_once_t onceToken;
    static HALJournal *journal;
    
    dispatch_once(&onceToken, ^{
        journal = [[HALJournal alloc] init];
    });
    
    return journal;
}

- (id)init
{
    self = [super init];
    if (self == nil)
        return nil;

    self.pages = [NSMutableArray array];
    self.changed = NO;

    return self;
}

- (void)loadJournal
{
    self.globalPageId = 0;
    self.globalRecordId = 0;

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger numberOfPages = [defaults integerForKey:@"NumberOfPages"];
   
    for (NSInteger pageId = 0; pageId < numberOfPages; pageId++)
    {
        NSString *pageKey = [NSString stringWithFormat:@"Page-%ld", (long)self.globalPageId];
        NSData *encodedPage = [defaults objectForKey:pageKey];
        HALJournalPage *page = [NSKeyedUnarchiver unarchiveObjectWithData:encodedPage];
        [self.pages addObject:page];
    }
}

- (void)saveJournal
{
    self.globalPageId = 0;
    self.globalRecordId = 0;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger numberOfPages = [self.pages count];
    
    [defaults setInteger:numberOfPages forKey:@"NumberOfPages"];

    for (NSInteger pageId = 0; pageId < numberOfPages; pageId++)
    {
        HALJournalPage *page = [self.pages objectAtIndex:pageId];
        NSString *pageKey = [NSString stringWithFormat:@"Page-%ld", (long)self.globalPageId];
        
        NSData *encodedPage = [NSKeyedArchiver archivedDataWithRootObject:page];
        [defaults setObject:encodedPage forKey:pageKey];
        [defaults synchronize];
    }
}

- (void)saveJournalIfNeeded
{
    if ([self changed])
        [self saveJournal];
}

- (void)poke:(UInt64)value
{
    [self setChanged:YES];

    HALJournalRecord *record = [[HALJournalRecord alloc] initWithValue:value];

    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
                                               fromDate:[NSDate date]];
    NSDate* today = [calendar dateFromComponents:components];

    for (HALJournalPage *page in [self pages])
    {
        if ([[page date] compare:today] == NSOrderedSame) {
            [page.records insertObject:record atIndex:0];
            return;
        }
    }

    HALJournalPage *page = [[HALJournalPage alloc] init];
    [page.records addObject:record];
    [self.pages insertObject:page atIndex:0];
}

@end
