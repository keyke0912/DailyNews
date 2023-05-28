//
//  MainPageCustomTopView.m
//  DailyNews
//
//  Created by Key ke on 2023/4/25.
//

#import "MainPageCustomTopView.h"
#import "Masonry.h"

@interface MainPageCustomTopView()


@property(nonatomic, strong)UILabel *dateLab;
@property(nonatomic, strong)UILabel *monthLab;
@property(nonatomic, strong)UIView *segmentationView;
@property(nonatomic, strong)UILabel *greetLab;


@end

@implementation MainPageCustomTopView

//这里一开始用的是initWithFrame,想到后面添加这个自定义view给主界面可能会出现适配问题故后面改为init结合masonry

- (instancetype)init {
    self = [super init];
    
    //有些情况下可能会因为一些原因，无法创建对象，if (self)判断对象是否为nil,不为nil的话进行后面的初始化方法
    
    if (self) {
        
        //先添加控件，因为Masonry是根据已有的子视图进行相对布局
    
        [self addSubview:self.dateLab];
        [self addSubview:self.monthLab];
        [self addSubview:self.segmentationView];
        [self addSubview:self.greetLab];
        [self addSubview:self.avatarBtn];
        
        self.backgroundColor = [UIColor whiteColor];
        
        //本视图的位置与大小不要跟据外部条件动态的更新，所以Masonry写在init中
       
        
        [self.dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(self.mas_top).mas_offset(10);
            make.left.mas_equalTo(self.mas_left).mas_offset(18);  //将这里的mas_left省略后自动匹配make.left
            make.width.mas_offset(30);
            make.height.mas_offset(20);
            
        }];
        
        
        
        [self.monthLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(self.dateLab).mas_offset(20);
            make.centerX.mas_equalTo(self.dateLab).mas_offset(0);
            make.width.mas_equalTo(self.dateLab).mas_offset(10);
            make.height.mas_equalTo(self.dateLab).mas_offset(-5);
            
        }];
        
        [self.segmentationView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(self.dateLab).mas_offset(0);
            make.left.mas_equalTo(self.dateLab.mas_right).mas_offset(15);
            make.height.mas_offset(30);
            make.width.mas_offset(2);
            
        }];
        
        [self.greetLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(self.dateLab).mas_offset(0);
            make.left.mas_equalTo(self.segmentationView.mas_right).mas_offset(5);
            make.height.mas_equalTo(self.segmentationView.mas_height).mas_offset(0);
            make.width.mas_offset(120);
            
        }];
        
        [self.avatarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(self).mas_offset(5);
            make.right.mas_equalTo(self).mas_offset(-30);
            make.width.mas_offset(40);
            make.height.mas_offset(40);
            //_avatarBtn.layer.cornerRadius = _avatarBtn.frame.size.width/2; //将button的形状设置为圆形
            
        }];
    }
    
    return self;
}

#pragma mark -lazy



-(UILabel *)dateLab {
    if (_dateLab == nil) {
        
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"d"];
        NSString *dateString = [dateFormatter stringFromDate:date];
        _dateLab = [[UILabel alloc] init];
        _dateLab.text = dateString;
        _dateLab.textColor = UIColor.blackColor;
        _dateLab.backgroundColor = UIColor.whiteColor;
        _dateLab.font = [UIFont boldSystemFontOfSize:21];
        _dateLab.textAlignment = NSTextAlignmentCenter; //中心对齐

        
    }
    return _dateLab;
}

-(UILabel *)monthLab {
    if (_monthLab == nil) {
        //这要进行改动，看看能不能和datelab合起来
        _monthLab = [[UILabel alloc] init];
        NSArray *monthArray = @[@"一月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月", @"九月", @"十月", @"十一月", @"十二月"];
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"M"];
        NSString *dateString = monthArray[[[dateFormatter stringFromDate:date] intValue] - 1];
        _monthLab.text = dateString;
        _monthLab.textColor = UIColor.blackColor;
        _monthLab.backgroundColor = UIColor.whiteColor;
        _monthLab.font = [UIFont systemFontOfSize:12];
        _monthLab.textAlignment = NSTextAlignmentCenter;
        
    }
    return _monthLab;
}

-(UIView *)segmentationView {
    if (_segmentationView == nil) {
        _segmentationView = [[UIView alloc] init];
        _segmentationView.backgroundColor = [UIColor grayColor];
    }
    return _segmentationView;
}

- (UILabel *)greetLab {
    
    if (_greetLab == nil) {
        _greetLab = [[UILabel alloc] init];
        NSDate* date = [NSDate date];
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"H"];
        NSString* hourStr = [dateFormat stringFromDate:date];
        int hour = hourStr.intValue;
        if(hour >= 22 || hour <= 2){
            _greetLab.text = @"早点休息";
        }else if(hour >= 7 && hour <= 9){
            _greetLab.text = @"早上好";
        }else{
            _greetLab.text = @"知乎日报";
        }
        _greetLab.backgroundColor = UIColor.whiteColor;
        _greetLab.textColor = UIColor.blackColor;
        _greetLab.textAlignment = NSTextAlignmentLeft;
        _greetLab.font = [UIFont boldSystemFontOfSize:25];

    }

    return _greetLab;
}

-(UIButton *)avatarBtn {
    if (_avatarBtn == nil) {
        _avatarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_avatarBtn setBackgroundImage:[UIImage imageNamed:@"headshot2"] forState:UIControlStateNormal];
        _avatarBtn.backgroundColor = [UIColor blueColor];
        
    }
    return _avatarBtn;
}

@end
