//
//  JANestCell.m
//  JATableCellNestTableDemo
//
//  Created by JasoneIo on 16/6/27.
//  Copyright © 2016年 littleBoy. All rights reserved.
//

#import "JANestCell.h"
#import "JALablelCell.h"
#import "JAPictureCell.h"
#import "JADataModel.h"

@interface JANestCell ()
<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblTheme;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;

@property (weak, nonatomic) IBOutlet UITableView *nestTableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeightConstraint;

@property (strong, nonatomic) JALablelCell *lblCell;
@end

@implementation JANestCell

- (JALablelCell *)lblCell
{
    if (!_lblCell) {
        _lblCell = [[NSBundle mainBundle] loadNibNamed:JALablelCellIdentifier owner:self options:nil].firstObject;
    }
    return _lblCell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.lblTheme.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 83.0f;
    
    [self.nestTableView registerNib:[UINib nibWithNibName:JALablelCellIdentifier bundle:nil] forCellReuseIdentifier:JALablelCellIdentifier];
    [self.nestTableView registerNib:[UINib nibWithNibName:JAPictureCellIdentifier bundle:nil] forCellReuseIdentifier:JAPictureCellIdentifier];
    
}

- (void)setDayModel:(dayjourney *)dayModel
{
    _dayModel = dayModel;
    
    self.lblTheme.text = dayModel.theme;
    self.lblContent.text = dayModel.content;
    
    [self.nestTableView reloadData];
    
    self.tableHeightConstraint.constant = self.nestTableView.contentSize.height;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.dayModel.journeyrange.count;
    }else if(section == 1){
        return self.dayModel.picurls.count;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        JALablelCell *lblCell = [tableView dequeueReusableCellWithIdentifier:JALablelCellIdentifier forIndexPath:indexPath];
        lblCell.title = self.dayModel.journeyrange[indexPath.row];
        return lblCell;
    }else{
        JAPictureCell *picCell = [tableView dequeueReusableCellWithIdentifier:JAPictureCellIdentifier forIndexPath:indexPath];
        picCell.pics = self.dayModel.picurls[indexPath.row];
        return picCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        self.lblCell.title = self.dayModel.journeyrange[indexPath.row];
        return [self.lblCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
    }else{
        if (self.dayModel.picurls[indexPath.row].img.length > 0) {
            return ([UIScreen mainScreen].bounds.size.width - 60.0f)/ 2.0f;
        }else{
            return CGFLOAT_MIN;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 0.0f;
    }else{
        return 10.0f;
    }
    
}

@end
