//
//  SDTopic.m
//  Category
//
//  Created by fqq3 on 17/4/20.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDTopic.h"

@implementation SDTopic
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"top_cmt" : @"SDComment"};
}

- (NSString *)create_time {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *creat = [fmt dateFromString:_create_time];
    
    if (creat.isThisYear) { // 今年
        if (creat.isToday) {
            NSDateComponents *cmps = [[NSDate date] deltaFrom:creat];
            
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) {
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else {
                return @"刚刚";
            }
        } else if (creat.isYesterday) {
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:creat];
        } else {
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:creat];
        }
    } else { // 非今年
        return _create_time;
    }
}

- (NSString *)ding {
    return [self setupTitleCount:[_ding integerValue] placeholder:@"顶"];
}

- (NSString *)cai {
    return [self setupTitleCount:[_cai integerValue] placeholder:@"踩"];
}

- (NSString *)repost {
    return [self setupTitleCount:[_repost integerValue] placeholder:@"转发"];
}

- (NSString *)comment {
    return [self setupTitleCount:[_comment integerValue] placeholder:@"评论"];
}

- (NSString *)setupTitleCount:(NSInteger)count placeholder:(NSString *)placeholder {
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    
    return placeholder;
}

- (CGSize)pictureSize {
    CGFloat pictureW = [UIScreen mainScreen].bounds.size.width - 4*8;
    
    CGFloat pictureH = pictureW * [self.height integerValue] / [self.width integerValue];
    
    if (self.type == SDPictureView) {
        if (pictureH >= SDPictureMaxH) { // 图片高度过长
            pictureH = SDPictureSmallH;
            self.bigPicture = YES; // 大图
        }
    }
    
    return _pictureSize = CGSizeMake(pictureW, pictureH);
}












@end
