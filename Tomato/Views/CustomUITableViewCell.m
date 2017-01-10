//
//  CustomUITableViewCell.m
//  UTeam
//
//  Created by qingshan on 15/4/5.
//  Copyright (c) 2015年 GaryOu. All rights reserved.
//

#import "CustomUITableViewCell.h"

@implementation CustomUITableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews {
    [super layoutSubviews];
    if (IOS7_LATER) {
        if (!CGRectEqualToRect(self.imageRect, CGRectZero)) {
            self.imageView.frame = self.imageRect;
            self.textLabel.left = self.imageView.right + self.imageView.left;
            self.detailTextLabel.left = self.textLabel.left;
        }
    }
}

@end
