//
//  AddressCell.h
//  TaoliWang
//
//  Created by Mac OS X on 14-2-18.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewAddressModel.h"

@protocol AddressDelegate <NSObject>

- (void)setCurrentCellToDefaultModel:(NewAddressModel *)userAddressModel;

@end

@interface AddressCell : UITableViewCell{
    NewAddressModel *userAddressModel;
}

@property (weak, nonatomic) id       addressDelegate;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIButton *editorBtn;
@property (strong, nonatomic) IBOutlet UIImageView *addressBackGroundView;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *phoneNum;
@property (strong, nonatomic) IBOutlet UILabel *detailAddress;
@property (strong, nonatomic) NSIndexPath *indexPath;
- (void)setObject:(NSDictionary *)dict;

@end
