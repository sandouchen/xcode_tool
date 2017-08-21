//
//  SDTopic.m
//  Category
//
//  Created by fqq3 on 17/4/20.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDTopic.h"
#import "SDComment.h"
#import "SDUser.h"

@implementation SDTopic
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

- (CGFloat)cellHeight {
    // 如果cell的高度已经计算过, 就直接返回
    if (_cellHeight) return _cellHeight;
    
    // 1.头像Y值
    _cellHeight = 35 + SDLayoutMargin_10 * 2;
    
    // 2.文字Y值
    CGFloat textMaxW = SDScreenW - 2 * SDLayoutMargin_10;
    CGSize maxSize = CGSizeMake(textMaxW, MAXFLOAT);
    
    // 计算文字的高度
    CGFloat textH = [self.text boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]} context:nil].size.height;
    
    _cellHeight += textH + SDLayoutMargin_10;

    // 3.中间的内容
    if (self.type != SDWordView) {
        // 中间内容的高度 == 中间内容的宽度 * 图片的真实高度 / 图片的真实宽度
        CGFloat contentH = textMaxW * self.height / self.width;
        
        if (contentH >= SDScreenH) {
            contentH = SDPictureSmallH;
            self.bigPicture = YES;
        }
        
        self.contentF = CGRectMake(SDLayoutMargin_10, _cellHeight, textMaxW, contentH);
        
        // 累加中间内容的高度
        _cellHeight += contentH + SDLayoutMargin_10;
    }
    
    // 4.最热评论
    if (self.top_cmt) {
        _cellHeight += 17;
        
        NSString *content = self.top_cmt.content;
        
        if (self.top_cmt.voiceuri.length) {
            content = @"[语音评论]";
        }
        
        NSString *topCmtContent = [NSString stringWithFormat:@"%@ : %@", self.top_cmt.user.username, content];
        
        CGFloat topCmtH = [topCmtContent boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
        
        _cellHeight += topCmtH + SDLayoutMargin_10;
    }
    
    _cellHeight += 40 + SDLayoutMargin_10;
    
    return _cellHeight;
}











@end
