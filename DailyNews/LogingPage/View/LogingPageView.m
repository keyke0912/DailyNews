//
//  LogingPageView.m
//  DailyNews
//
//  Created by Key ke on 2023/5/27.
//

#import "LogingPageView.h"

@implementation LogingPageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.textFieldWithId];
        [self addSubview:self.textFieldWithPassCode];
        [self addSubview:self.logingBtn];
        [self addSubview:self.signUpBtn];
        [self addSubview:self.backBtn];
        
    }
    return self;
}

#pragma mark -Lazy

- (UITextField *) textFieldWithId {
    if (_textFieldWithId == nil) {
        _textFieldWithId = [[UITextField alloc] initWithFrame:CGRectMake(121.5, 155, 150, 40)];
        _textFieldWithId.placeholder = @"用户名";
        _textFieldWithId.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _textFieldWithId;
}

- (UITextField *) textFieldWithPassCode {
    if (_textFieldWithPassCode == nil) {
        _textFieldWithPassCode = [[UITextField alloc] initWithFrame:CGRectMake(121.5, 205, 150, 40)];
        _textFieldWithPassCode.placeholder = @"密码";
        _textFieldWithPassCode.borderStyle = UITextBorderStyleRoundedRect;
        
    }
    return _textFieldWithPassCode;
}

- (UIButton *) logingBtn {
    if (_logingBtn == nil) {
        _logingBtn = [[UIButton alloc] initWithFrame:CGRectMake(121.5, 255, 150, 40)];
        [_logingBtn setTitle:@"登录" forState:UIControlStateNormal];
        _logingBtn.backgroundColor = [UIColor blueColor];
        
    }
    return _logingBtn;
}

- (UIButton *) signUpBtn {
    if (_signUpBtn == nil) {
        _signUpBtn = [[UIButton alloc] initWithFrame:CGRectMake(121.5, 305, 150, 40)];
        [_signUpBtn setTitle:@"注册" forState:UIControlStateNormal];
        _signUpBtn.backgroundColor = [UIColor blueColor];
    }
    return _signUpBtn;
}

- (UIButton *) backBtn {
    if (_backBtn == nil) {
        _backBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 65, 30,30)];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    }
    return _backBtn;
}
@end
