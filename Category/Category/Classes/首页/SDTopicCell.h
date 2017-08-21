//
//  SDTopicCell.h
//  Category
//
//  Created by fqq3 on 17/4/20.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SDTopic;

@protocol ShareButtonDelegate <NSObject>

@optional
- (void)didClickShareButton;

@end

@interface SDTopicCell : UITableViewCell
@property (nonatomic, strong) SDTopic *topics;
@property (nonatomic, weak) id<ShareButtonDelegate> delegate;
@end
