//
//  WGUser.h
//  WGLogin
//
//  Created by 王刚 on 14/8/9.
//  Copyright (c) 2014年 wwwlife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGUser : NSObject

@property (nonatomic, readonly, copy) NSString *username;
@property (nonatomic, readonly, copy) NSString *password;
@property (nonatomic, readonly, copy) NSString *email;

- (id)initWithUsername:(NSString *)username
              password:(NSString *)passwrod
                 email:(NSString *)email;

- (id)initWithEmail:(NSString *)email
           passwrod:(NSString *)password;

@end
