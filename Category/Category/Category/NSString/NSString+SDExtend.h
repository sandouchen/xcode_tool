//
//  NSString+SDExtend.h
//  Category
//
//  Created by fqq3 on 17/6/27.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SDExtend)
/** 获取字符串(或汉字)首字母 */
+ (NSString *)firstCharacterWithString:(NSString *)string;

/** 获取汉字的拼音 */
+ (NSString *)transform:(NSString *)chinese withMark:(BOOL)mark;
@end
