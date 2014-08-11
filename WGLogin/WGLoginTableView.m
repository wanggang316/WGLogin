//
//  WGLoginTableView.m
//  WGLogin
//
//  Created by 王刚 on 14/8/9.
//  Copyright (c) 2014年 wwwlife. All rights reserved.
//

#import "WGLoginTableView.h"
#import "WGTextCell.h"
#import "WGTextCellSetting.h"

static  NSString* const TextCellIdentifier = @"TextCellIdentifier";

@interface WGLoginTableView() <UITableViewDelegate, UITableViewDataSource, WGTextCellDelegate>

@property (nonatomic) TableType tableType;

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, strong) UIButton *btn;

@end

@implementation WGLoginTableView


- (id)initWithType:(TableType)type {
    if (self = [super init]) {
        switch (type) {
            case LoginType: {
                self.items = [WGSettingStore loginTableSettings];
                break;
            }
            case RegisterType: {
                self.items = [WGSettingStore registerTableSetting];
                break;
            }
            default:
                break;
        }
        self.tableType = type;
        self.dataSource = self;
        self.delegate = self;
        [self registerNib:[WGTextCell nib] forCellReuseIdentifier:TextCellIdentifier];
        self.separatorInset = UIEdgeInsetsMake(0, 55, 0, 0);
        
        self.tableFooterView = [self tableFooterView];
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        self.scrollEnabled = NO;
        
        //add border
        CALayer *topBorder = [CALayer layer];
        topBorder.frame = CGRectMake(0.0f, 0.0f, 320, 0.6f);
        topBorder.backgroundColor = [UIColor colorWithWhite:0.8f alpha:1.0f].CGColor;
        [self.layer addSublayer:topBorder];
        CALayer *bottomBorder = [CALayer layer];
        bottomBorder.frame = CGRectMake(0.0f, 44.0*self.items.count, 320, 0.6);
        bottomBorder.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0f].CGColor;
        [self.layer addSublayer:bottomBorder];
        
    }
    
    return self;
}

#pragma mark - super methods

- (void)reloadData {
    [super reloadData];
    for (int i = 0; i < self.items.count; i++) {
        UITextField *textField = [self textFieldWithRow:i];
        [textField setText:nil];
    }
    [self.btn setEnabled:NO];
}

- (UIView *)tableFooterView {
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, self.frame.size.width, 100)];
    
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _btn.frame = CGRectMake(30, 20, 260, 35);
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn.titleLabel.font = [UIFont systemFontOfSize:16];
        _btn.backgroundColor = [UIColor orangeColor];
        _btn.layer.cornerRadius = 5;
        [_btn setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.3] forState:UIControlStateDisabled];
        
        switch (self.tableType) {
            case LoginType: {
                [_btn setTitle:@"登陆" forState:UIControlStateNormal];
                [_btn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
                break;
            }
            case RegisterType: {
                [_btn setTitle:@"注册" forState:UIControlStateNormal];
                [_btn addTarget:self action:@selector(registe:) forControlEvents:UIControlEventTouchUpInside];
                break;
            }
                
            default:
                break;
        }
        
        [_btn setEnabled:NO];
        [footView addSubview:_btn];
    }
    
   
    
    footView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    return footView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WGTextCell *cell = [tableView dequeueReusableCellWithIdentifier:TextCellIdentifier forIndexPath:indexPath];
    cell.textCellDelegate = self;
    WGTextCellSetting *setting = [self.items objectAtIndex:indexPath.row];
    [cell configureCell:setting];
    
    if (indexPath.row == (self.items.count - 1)) {
        [cell.textField setSecureTextEntry:YES];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark - WGTextCellDelegate
- (BOOL)setButtonEnabled {
    BOOL isEnabled = YES;
    for (int i = 0; i < self.items.count; i++) {
        UITextField *textField = [self textFieldWithRow:i];
        if(!textField.text.length > 0) {
            isEnabled = NO;
            break;
        }
    }
//    UITextField *passwordTextField = [self textFieldWithRow:(self.items.count - 1)];
//    passwordTextField.enablesReturnKeyAutomatically = !isEnabled;
    [self.btn setEnabled:isEnabled];
    return isEnabled;
}

- (void)currEditTextField:(UITextField *)textField {
    self.currEdidTextField = textField;
}

- (void)returnKeyTypeEvent:(WGTextCell *)cell {
    if (self.tableType == LoginType) {
        UITextField *passwordTextField = [self textFieldWithRow:1];
        if (cell.textFieldType == EmailType) {
            [passwordTextField becomeFirstResponder];
        } else if (cell.textFieldType == PasswordType) {
            [passwordTextField resignFirstResponder];
//            [self login:nil];
        }
    } else {
        if (cell.textFieldType == UsernameType) {
            UITextField *emailTextField = [self textFieldWithRow:1];
            [emailTextField becomeFirstResponder];
        } else if (cell.textFieldType == EmailType) {
            UITextField *passwordTextField = [self textFieldWithRow:2];
            [passwordTextField becomeFirstResponder];
        } else if (cell.textFieldType == PasswordType) {
            UITextField *passwordTextField = [self textFieldWithRow:2];
            [passwordTextField resignFirstResponder];
//            [self registe:nil];
        }
    }
}


- (void)login:(UIButton *)sender {
    //邮箱
    UITextField *emailTextField = [self textFieldWithRow:0];
    //密码
    UITextField *passwordTextField = [self textFieldWithRow:1];
    
    NSLog(@"email : %@, password : %@", emailTextField.text, passwordTextField.text);
}

- (void)registe:(UIButton *)sender {
    //用户名
    UITextField *usernameTextField = [self textFieldWithRow:0];
    //邮箱
    UITextField *emailTextField = [self textFieldWithRow:1];
    //密码
    UITextField *passwordTextField = [self textFieldWithRow:2];
    
    NSLog(@"username : %@, email : %@, password : %@", usernameTextField.text, emailTextField.text, passwordTextField.text);
}

- (UITextField *)textFieldWithRow:(NSInteger)index {
    return ((WGTextCell *)[self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]]).textField;
}



@end
