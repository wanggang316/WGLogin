//
//  WGTextFieldSetting.m
//  WGLogin
//
//  Created by 王刚 on 14/8/9.
//  Copyright (c) 2014年 wwwlife. All rights reserved.
//

#import "WGTextCellSetting.h"

@implementation WGTextCellSetting

- (id)initWithIcon:(NSString *)icon textPlaceHolder:(NSString *)textPlaceHolder textFieldType:(TextFieldType)textFieldType {
    if (self = [super init]) {
        self.icon = [icon copy];
        self.textPlaceHolder = [textPlaceHolder copy];
        self.textFieldType = textFieldType;
    }
    return self;
}


@end



@implementation WGSettingStore

+ (NSArray *)loginTableSettings {
    WGTextCellSetting *cell1 = [[WGTextCellSetting alloc]initWithIcon:@"email.png" textPlaceHolder:@"请输入邮箱" textFieldType:EmailType];
    WGTextCellSetting *cell2 = [[WGTextCellSetting alloc]initWithIcon:@"password.png" textPlaceHolder:@"请输入密码" textFieldType:PasswordType];
    return [NSArray arrayWithObjects:cell1,cell2, nil];
}

+ (NSArray *)registerTableSetting {
    WGTextCellSetting *cell1 = [[WGTextCellSetting alloc]initWithIcon:@"username.png" textPlaceHolder:@"请输入用户名" textFieldType:UsernameType];
    WGTextCellSetting *cell2 = [[WGTextCellSetting alloc]initWithIcon:@"email.png" textPlaceHolder:@"请输入邮箱" textFieldType:EmailType];
    WGTextCellSetting *cell3 = [[WGTextCellSetting alloc]initWithIcon:@"password.png" textPlaceHolder:@"请输入密码" textFieldType:PasswordType];
    return [NSArray arrayWithObjects:cell1,cell2,cell3, nil];
}

@end
