//
//  LogingPageView.h
//  DailyNews
//
//  Created by Key ke on 2023/5/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LogingPageView : UIView

@property (nonatomic, strong) UITextField *textFieldWithId;
@property (nonatomic, strong) UITextField *textFieldWithPassCode;
@property (nonatomic, strong) UIButton *logingBtn;
@property (nonatomic, strong) UIButton *signUpBtn;
@property (nonatomic, strong) UIButton *backBtn;

@end

NS_ASSUME_NONNULL_END
