//
//  TimeUsingCell.h
//  Regular-Timer
//
//  Created by Shuyu on 13-11-13.
//  Copyright (c) 2013年 Shuyu. All rights reserved.
//

#import "SWTableViewCell.h"

@interface TimeUsingCell : SWTableViewCell

@property (strong, nonatomic) UILabel *projectName;
@property (strong, nonatomic) UILabel *continuedTime;

@property (strong, nonatomic) UIImageView *projectIcon;


@end
