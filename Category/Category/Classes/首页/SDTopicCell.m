//
//  SDTopicCell.m
//  Category
//
//  Created by fqq3 on 17/4/20.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDTopicCell.h"
#import "SDTopic.h"

@interface SDTopicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UILabel *textLb;
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *zhuanBtn;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

@end

@implementation SDTopicCell
- (void)setTopics:(SDTopic *)topics {
    _topics = topics;
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:topics.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.nameLabel.text = topics.name;
    
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:now];
    
    NSLog(@"年:%zd 月:%zd 日:%zd 时:%zd 分:%zd 秒:%zd", cmps.year, cmps.month, cmps.day, cmps.hour, cmps.minute, cmps.second);
    
    
    
    self.timeLabel.text = topics.create_time;
    
    self.textLb.text = topics.text;
    
    [self setupButtonTitle:self.dingBtn count:[topics.ding integerValue] placeholder:@"顶"];
    [self setupButtonTitle:self.caiBtn count:[topics.cai integerValue] placeholder:@"踩"];
    [self setupButtonTitle:self.zhuanBtn count:[topics.repost integerValue] placeholder:@"分享"];
    [self setupButtonTitle:self.moreBtn count:[topics.comment integerValue] placeholder:@"评论"];
}

- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder {
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    
    [button setTitle:placeholder forState:(UIControlStateNormal)];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
