//
//  WGUser.m
//  WGLogin
//
//  Created by 王刚 on 14/8/9.
//  Copyright (c) 2014年 wwwlife. All rights reserved.
//

#import "WGUser.h"

@interface WGUser()

@property (nonatomic, readwrite, copy) NSString *username;
@property (nonatomic, readwrite, copy) NSString *password;
@property (nonatomic, readwrite, copy) NSString *email;

@end

@implementation WGUser

- (id)initWithUsername:(NSString *)username password:(NSString *)passwrod email:(NSString *)email {
    if (self = [super init]) {
        self.username = [username copy];
        self.password = [passwrod copy];
        self.email = [passwrod copy];
    }
    return self;
}


- (id)initWithEmail:(NSString *)email passwrod:(NSString *)password {
    return [self initWithUsername:nil password:password email:email];
}

@end
