//
//  WGTextCell.m
//  WGLogin
//
//  Created by 王刚 on 14/8/9.
//  Copyright (c) 2014年 wwwlife. All rights reserved.
//

#import "WGTextCell.h"


@implementation WGTextCell 

+ (UINib *)nib {
    return [UINib nibWithNibName:@"WGTextCell" bundle:nil];
}

- (void)configureCell:(WGTextCellSetting *)setting {
    
    self.iconImageView.image = [UIImage imageNamed:setting.icon];
    self.textField.placeholder = setting.textPlaceHolder;
    self.textField.delegate = self;
    [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.textFieldType = setting.textFieldType;
    [self setCancelImageHidden:YES];
}

- (void)setCancelImageHidden:(BOOL)hidden {
    [self.editCancelBtn setHidden:hidden];
}

- (void)textFieldDidChange:(UITextField *)textField {
    
    if (textField.text.length > 0) {
        [self setCancelImageHidden:NO];
    } else {
        [self setCancelImageHidden:YES];
    }
    [self.textCellDelegate setButtonEnabled];
}

- (IBAction)editCancel:(id)sender {
    [self.textField setText:nil];
    [self setCancelImageHidden:YES];
    [self.textCellDelegate setButtonEnabled];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    //设定键盘样式
    if (self.textFieldType == EmailType || self.textFieldType == UsernameType) {
        textField.returnKeyType = UIReturnKeyNext;
    }else {
        textField.returnKeyType = UIReturnKeyDone;
    }
    
    
    //设定取消提示按钮
    if (textField.text.length > 0) {
        [self setCancelImageHidden:NO];
    } else {
        [self setCancelImageHidden:YES];
    }
    //设定当前编辑的textfield，供单击手势隐藏键盘使用
    [self.textCellDelegate currEditTextField:textField];
    
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self setCancelImageHidden:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    //设定ReturnKey行为
    [self.textCellDelegate returnKeyTypeEvent:self];
    
    
    return YES;
}







@end
