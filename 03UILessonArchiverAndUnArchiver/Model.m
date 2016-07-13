//
//  Model.m
//  03UILessonArchiverAndUnArchiver
//
//  Created by UntilYou-QC on 16/5/25.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import "Model.h"

@implementation Model

- (void)encodeWithCoder:(NSCoder *)aCoder {
    // 存储model的name gender age
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
    [aCoder encodeInteger:self.age forKey:@"age"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.gender = [aDecoder decodeObjectForKey:@"gender"];
        self.age = [aDecoder decodeIntegerForKey:@"age"];
    }
    return self;
}

@end
