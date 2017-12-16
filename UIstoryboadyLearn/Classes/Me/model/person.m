//
//  person.m
//  UIwebview
//
//  Created by hao on 2017/12/15.
//  Copyright © 2017年 hao. All rights reserved.
//

#import "person.h"
NSString *const personName = @"name";
NSString *const personAge = @"age";
NSString *const personIconUrl = @"iconurl";
@interface person()

-(id)objectOrNilForKey:(id)key fromDictionary:(NSDictionary *)dict;

@end
@implementation person

@synthesize name =_name;
@synthesize age = _age;
@synthesize iconUrl = _iconUrl;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.name = [self objectOrNilForKey:personName fromDictionary:dict];
        self.age = [[self objectOrNilForKey:personAge fromDictionary:dict] intValue];
        self.iconUrl = [self objectOrNilForKey:personIconUrl fromDictionary:dict];
        
    }
    
    return self;
    
}
#pragma mark Help Method
-(id)objectOrNilForKey:(id)key fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:key];
    return [object isEqual:[NSNull null]] ? nil:object;
}
#pragma description Method
-(NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithInt:_age] forKey:personAge];
    [mutableDict setValue:_name forKey:personName];
    [mutableDict setValue:_iconUrl forKey:personIconUrl];
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}
-(NSString *)description
{
    return [NSString stringWithFormat:@"%@",[self dictionaryRepresentation]];
}
#pragma nscode Method
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_name forKey:personName];
    [aCoder encodeInt:_age forKey:personAge];
    [aCoder encodeObject:_iconUrl forKey:personIconUrl];
    
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:personName];
        self.age = [aDecoder decodeIntForKey:personAge];
        self.iconUrl = [aDecoder decodeObjectForKey:personIconUrl];
    }
    return self;
}
#pragma nscopy Method
-(id)copyWithZone:(NSZone *)zone
{
    person *per = [[person alloc]init];
    per.name = self.name;
    per.age = self.age;
    per.iconUrl = self.iconUrl;
    return per;
}
@end
