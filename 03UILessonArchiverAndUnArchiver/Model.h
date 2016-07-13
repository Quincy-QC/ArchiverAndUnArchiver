//
//  Model.h
//  03UILessonArchiverAndUnArchiver
//
//  Created by UntilYou-QC on 16/5/25.
//  Copyright © 2016年 UntilYou-QC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject <NSCoding>

@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong, readwrite) NSString *gender;
@property (nonatomic, assign, readwrite) NSInteger age;



@end
