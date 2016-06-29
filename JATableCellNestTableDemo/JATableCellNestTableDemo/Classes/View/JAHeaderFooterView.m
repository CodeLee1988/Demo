//
//  JAHeaderFooterView.m
//  JATableCellNestTableDemo
//
//  Created by JasoneIo on 16/6/29.
//  Copyright © 2016年 littleBoy. All rights reserved.
//

#import "JAHeaderFooterView.h"

@interface JAHeaderFooterView ()

@property (weak, nonatomic) IBOutlet UILabel *lblDay;

@property (weak, nonatomic) IBOutlet UILabel *lblSectionTitle;

@end

@implementation JAHeaderFooterView


- (void)awakeFromNib
{
    self.lblSectionTitle.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 30.0f;
}

- (void)configureTitleDay:(NSString *)title subTitle:(NSString *)subTitle
{
    self.lblDay.text = title;
    self.lblSectionTitle.text = subTitle;
}

@end
