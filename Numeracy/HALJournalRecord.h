//
//  Numeracy
//
//  Copyright (c) 2014 Meine Werke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HALJournalRecord : NSObject

@property (assign, nonatomic) UInt64 value;
@property (strong, nonatomic) NSDate *stamp;
@property (strong, nonatomic) NSString *label;

- (id)initWithValue:(UInt64)value;

- (id)initWithCoder:(NSCoder *)decoder;

- (void)encodeWithCoder:(NSCoder *)encoder;

@end
