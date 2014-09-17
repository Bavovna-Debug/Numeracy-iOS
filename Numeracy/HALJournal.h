//
//  Numeracy
//
//  Copyright (c) 2014 Meine Werke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HALJournal : NSObject

@property (strong, nonatomic) NSMutableArray *pages;
@property (assign, nonatomic) Boolean changed;
@property (assign, nonatomic) NSInteger globalPageId;
@property (assign, nonatomic) NSInteger globalRecordId;

+ (HALJournal *)sharedJournal;

- (void)loadJournal;

- (void)saveJournal;

- (void)saveJournalIfNeeded;

- (void)poke:(UInt64)value;

@end
