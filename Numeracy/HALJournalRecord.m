//
//  Numeracy
//
//  Copyright (c) 2014 Meine Werke. All rights reserved.
//

#import "HALJournal.h"
#import "HALJournalRecord.h"

@implementation HALJournalRecord

- (id)initWithValue:(UInt64)value
{
    self = [super init];
    if (self == nil)
        return nil;
    
    self.value = value;
    self.stamp = [NSDate date];
    self.label = @"";

    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self == nil)
        return nil;

    HALJournal *journal = [HALJournal sharedJournal];

    NSString *key;

    key = [NSString stringWithFormat:@"Record-%ld-Value", (long)[journal globalRecordId]];
    NSString *valueString = [decoder decodeObjectForKey:key];
    [self setValue:[valueString longLongValue]];

    key = [NSString stringWithFormat:@"Record-%ld-Stamp", (long)[journal globalRecordId]];
    [self setStamp:[decoder decodeObjectForKey:key]];

    key = [NSString stringWithFormat:@"Record-%ld-Label", (long)[journal globalRecordId]];
    [self setLabel:[decoder decodeObjectForKey:key]];

    [journal setGlobalRecordId:[journal globalRecordId] + 1];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    HALJournal *journal = [HALJournal sharedJournal];

    NSString *key;
    
    key = [NSString stringWithFormat:@"Record-%ld-Value", (long)[journal globalRecordId]];
    NSString *valueString = [NSString stringWithFormat:@"%llu", [self value]];
    [encoder encodeObject:valueString forKey:key];

    key = [NSString stringWithFormat:@"Record-%ld-Stamp", (long)[journal globalRecordId]];
    [encoder encodeObject:[self stamp] forKey:key];

    key = [NSString stringWithFormat:@"Record-%ld-Label", (long)[journal globalRecordId]];
    [encoder encodeObject:[self label] forKey:key];

    [journal setGlobalRecordId:[journal globalRecordId] + 1];
}

@end
