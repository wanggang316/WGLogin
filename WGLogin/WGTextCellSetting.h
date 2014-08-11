//
//  WGTextFieldSetting.h
//  WGLogin
//
//  Created by 王刚 on 14/8/9.
//  Copyright (c) 2014年 wwwlife. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, TextFieldType) {
    UsernameType,
    EmailType,
    PasswordType,
};

@interface WGTextCellSetting : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *textPlaceHolder;
@property (nonatomic) TextFieldType textFieldType;

- (id)initWithIcon:(NSString *)icon
   textPlaceHolder:(NSString *)textPlaceHolder
     textFieldType:(TextFieldType)textFieldType;

@end


@interface WGSettingStore : NSObject

+ (NSArray *)loginTableSettings;
+ (NSArray *)registerTableSetting;

@end

