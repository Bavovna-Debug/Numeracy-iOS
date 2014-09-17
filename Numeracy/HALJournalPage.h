//
//  Numeracy
//
//  Copyright (c) 2014 Meine Werke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HALJournalPage : NSObject

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSMutableArray *records;

- (id)init;

- (id)initWithCoder:(NSCoder *)decoder;

- (void)encodeWithCoder:(NSCoder *)encoder;

@end
