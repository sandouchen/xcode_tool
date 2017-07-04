//
//  NSString+SDExtend.m
//  Category
//
//  Created by fqq3 on 17/6/27.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "NSString+SDExtend.h"

@implementation NSString (SDExtend)
/** 获取字符串(或汉字)首字母 */
+ (NSString *)firstCharacterWithString:(NSString *)string {
    NSMutableString *str = [NSMutableString stringWithString:string];
    
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    
    NSString *pingyin = [str capitalizedString];
    
    return [pingyin substringToIndex:1];
}

/** 获取汉字的拼音 */
+ (NSString *)transform:(NSString *)chinese withMark:(BOOL)mark {
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [chinese mutableCopy];
    
    // 将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);

    if (!mark) {
        // 去掉拼音的音标
        CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    }
    
    // 返回最近结果
    return pinyin;
}
@end
