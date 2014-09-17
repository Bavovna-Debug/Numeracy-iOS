//
//  Numeracy
//
//  Copyright (c) 2014 Meine Werke. All rights reserved.
//

#import "HALJournal.h"
#import "HALJournalPage.h"
#import "HALJournalRecord.h"

@implementation HALJournalPage

- (id)init
{
    self = [super init];
    if (self == nil)
        return nil;
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
                                               fromDate:[NSDate date]];

    self.date = [calendar dateFromComponents:components];
    self.records = [NSMutableArray array];

    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self == nil)
        return nil;
    
    HALJournal *journal = [HALJournal sharedJournal];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [self setDate:[decoder decodeObjectForKey:@"Date"]];

    self.records = [NSMutableArray array];

    NSString *pageKey = [NSString stringWithFormat:@"NumberOfRecordsInPage-%ld",
                         (long)[journal globalPageId]];
    NSInteger numberOfRecords = [defaults integerForKey:pageKey];
    
    for (NSInteger recordId = 0; recordId < numberOfRecords; recordId++)
    {
        NSString *recordKey = [NSString stringWithFormat:@"Page-%ld-Record-%ld",
                               (long)[journal globalPageId],
                               (long)[journal globalRecordId]];
        NSData *encodedRecord = [defaults objectForKey:recordKey];
        HALJournalRecord *record = [NSKeyedUnarchiver unarchiveObjectWithData:encodedRecord];
        [self.records addObject:record];
    }

    [journal setGlobalPageId:[journal globalPageId] + 1];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    HALJournal *journal = [HALJournal sharedJournal];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [encoder encodeObject:[self date] forKey:@"Date"];

    NSInteger numberOfRecords = [self.records count];

    NSString *pageKey = [NSString stringWithFormat:@"NumberOfRecordsInPage-%ld",
                         (long)[journal globalPageId]];
    [defaults setInteger:numberOfRecords forKey:pageKey];

    for (NSInteger recordId = 0; recordId < numberOfRecords; recordId++)
    {
        HALJournalRecord *record = [self.records objectAtIndex:recordId];
        NSString *recordKey = [NSString stringWithFormat:@"Page-%ld-Record-%ld",
                               (long)[journal globalPageId],
                               (long)[journal globalRecordId]];
        NSData *encodedRecord = [NSKeyedArchiver archivedDataWithRootObject:record];
        [defaults setObject:encodedRecord forKey:recordKey];
        [defaults synchronize];
    }

    [journal setGlobalPageId:[journal globalPageId] + 1];
}

@end
