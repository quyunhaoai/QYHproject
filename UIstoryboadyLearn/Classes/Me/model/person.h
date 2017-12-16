//
//  person.h
//  UIwebview
//
//  Created by hao on 2017/12/15.
//  Copyright © 2017年 hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface person : NSObject<NSCoding,NSCopying>
@property (nonatomic,strong) NSString *name;
@property (nonatomic,assign) int age;
@property (nonatomic,strong) NSString *iconUrl;
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;


@end
