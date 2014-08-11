//
//  WGLoginTableView.h
//  WGLogin
//
//  Created by 王刚 on 14/8/9.
//  Copyright (c) 2014年 wwwlife. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TableType) {
    LoginType,
    RegisterType,
};


@interface WGLoginTableView : UITableView

@property (nonatomic, strong) UITextField *currEdidTextField;

- (id)initWithType:(TableType)type;


@end
