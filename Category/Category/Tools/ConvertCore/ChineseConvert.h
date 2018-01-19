//
//  convertGB_BIG.h
//
//  Created by fqq3 on 17/6/2.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChineseConvert : NSObject {
	NSString *_string_GB;
	NSString *_string_BIG5;
}

@property(nonatomic, strong) NSString *string_GB;
@property(nonatomic, strong) NSString *string_BIG5;

/**
 *  简体转繁体 Simple Chinese to Traditional Chinese
 */
- (NSString *)gbToBig5:(NSString *)srcString;


/**
 *  繁体转简体 Traditional Chinese to Simple Chinese
 */
- (NSString *)big5ToGb:(NSString *)srcString;

@end
