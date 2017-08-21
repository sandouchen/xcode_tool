//
//  NSObject+SDProperty.m
//  SD_Notes
//
//  Created by fqq3 on 16/6/29.
//  Copyright © 2016年 sandouchan. All rights reserved.
//

#import "NSObject+SDProperty.h"

@implementation NSObject (SDProperty)
+ (void)createPropertyCodeWithDict:(NSDictionary *)dict {
    // 创建一个可变字符串，add字典每一个key所对应的模型数据
    NSMutableString *strM = [NSMutableString string];
    
    // 遍历字典
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull propertyName, id  _Nonnull value, BOOL * _Nonnull stop) {
        
        SDLog(@"%@ - %@", propertyName, [value class]);
        
        NSString *code;
        
        if ([value isKindOfClass:NSClassFromString(@"__NSCFString")]) {
            
            code = [NSString stringWithFormat:@"@property (copy, nonatomic) NSString *%@;",propertyName];
            
        }else if ([value isKindOfClass:NSClassFromString(@"__NSCFNumber")]){
            
            code = [NSString stringWithFormat:@"@property (assign, nonatomic) NSInteger %@;",propertyName];
            
        }else if ([value isKindOfClass:NSClassFromString(@"__NSCFArray")] || [value isKindOfClass:NSClassFromString(@"JKArray")] || [value isKindOfClass:NSClassFromString(@"__NSArrayI")] || [value isKindOfClass:NSClassFromString(@"__NSArray0")]){
            
            code = [NSString stringWithFormat:@"@property (strong, nonatomic) NSArray *%@;",propertyName];
            
        }else if ([value isKindOfClass:NSClassFromString(@"__NSCFDictionary")] || [value isKindOfClass:NSClassFromString(@"JKDictionary")] || [value isKindOfClass:NSClassFromString(@"__NSDictionaryI")]){
            
            code = [NSString stringWithFormat:@"@property (strong, nonatomic) NSDictionary *%@;",propertyName];
            
        }else if ([value isKindOfClass:NSClassFromString(@"__NSCFBoolean")]){
            
            code = [NSString stringWithFormat:@"@property (assign, nonatomic) BOOL %@;",propertyName];
            
        }else {
            
            code = [NSString stringWithFormat:@"@property (copy, nonatomic) NSString *%@;",propertyName];
            
        }
        
        [strM appendFormat:@"\n%@\n",code];
    }];
    
    SDLog(@"%@",strM);
}

@end
