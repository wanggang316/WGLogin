//
//  WGTextCell.h
//  WGLogin
//
//  Created by 王刚 on 14/8/9.
//  Copyright (c) 2014年 wwwlife. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WGTextCellSetting.h"


@protocol WGTextCellDelegate;

@interface WGTextCell : UITableViewCell <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIButton *editCancelBtn;

@property (nonatomic) TextFieldType textFieldType;

@property (weak, nonatomic) id<WGTextCellDelegate> textCellDelegate;


+ (UINib *)nib;

- (void)configureCell:(WGTextCellSetting *)setting;

- (void)setCancelImageHidden:(BOOL)hidden;
@end


@protocol WGTextCellDelegate <NSObject>

- (BOOL)setButtonEnabled;
- (void)currEditTextField:(UITextField *)textField;
- (void)returnKeyTypeEvent:(WGTextCell *)cell;

@end

