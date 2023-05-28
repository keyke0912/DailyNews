//
//  LogingPageViewController.m
//  DailyNews
//
//  Created by Key ke on 2023/5/27.
//

#import "LogingPageViewController.h"
#import "LogingPageView.h"
#import "MainPageViewController.h"
#import "MainPageCustomTopView.h"

@interface LogingPageViewController ()

@property (nonatomic, strong) LogingPageView *logingPageView;
@property (nonatomic, getter=isloading, assign) BOOL loading;

@end

@implementation LogingPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //MainPageViewController *mainPageViewController = [[MainPageViewController alloc] init];
    //[mainPageViewController stopTimer];
    // Do any additional setup after loading the view.
    self.loading = NO;
    [self.view addSubview:self.logingPageView];
}

- (void) logingButtonClicked:(UIButton *)sender {
    // 在这里执行想要的操作
    NSLog(@"log按钮被点击了！");
    
    //将plist文件中的数据导入字典
//    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"LoginCredentials" ofType:@"plist"];
    // 获取应用程序沙盒中的 Documents 目录路径
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];

    // 拼接 plist 文件路径
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"LoginCredentials.plist"];

    NSDictionary *userInfoDict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    NSLog(@"%@", userInfoDict);
    //判断是否存在用户名
    NSString *inputUsername = self.logingPageView.textFieldWithId.text;
    NSString *inputPassword = self.logingPageView.textFieldWithPassCode.text;
    BOOL isUsernameExist = [userInfoDict.allKeys containsObject:inputUsername];
    if (isUsernameExist) {
        // 用户名存在
        NSLog(@"用户名存在！");
        NSString *storedPassword = [userInfoDict objectForKey:inputUsername];
        if ([storedPassword isEqualToString:inputPassword]) {
            // 用户名和密码匹配成功
            NSLog(@"登录成功！");
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"登录成功！" preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
            self.loading = YES;
            
//            [self.navigationController popViewControllerAnimated:YES];
            //出现了冲突问题

        } else {
            // 用户名和密码不匹配
            NSLog(@"用户名或密码错误！");
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名或密码错误！" preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:okAction];

            [self presentViewController:alertController animated:YES completion:nil];
        }

    } else {
        // 用户名不存在
        NSLog(@"用户名不存在！");
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名不存在！" preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];

        [self presentViewController:alertController animated:YES completion:nil];
    }


}

- (void) singUpButtonClicked:(UIButton *)sender {
    NSLog(@"signUp按钮被点击了！");
    // 获取plist文件路径
//    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"LoginCredentials" ofType:@"plist"];
    // 获取应用程序沙盒中的 Documents 目录路径
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];

    // 拼接 plist 文件路径
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"LoginCredentials.plist"];

    // 创建一个可变的NSMutableDictionary对象
    NSMutableDictionary *userInfoDict = [[NSMutableDictionary alloc] init];

    // 获取用户输入的用户名和密码
    NSString *inputUsername = self.logingPageView.textFieldWithId.text;
    NSString *inputPassword = self.logingPageView.textFieldWithPassCode.text;

    // 将用户名和密码存储到userInfoDict中
    [userInfoDict setObject:inputPassword forKey:inputUsername];

    // 将userInfoDict写入plist文件
    if ([userInfoDict writeToFile:plistPath atomically:YES]) {
        NSLog(@"用户信息注册成功");
        NSLog(@"%@", userInfoDict);
        // 读取 plist 文件内容
        NSDictionary *userInfo = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        NSLog(@"用户信息：%@", userInfo);
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户信息注册成功" preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];

        [self presentViewController:alertController animated:YES completion:nil];

    } else {
        NSLog(@"用户信息注册失败");
    }
}

- (void) backButtonClicked:(UIButton *)sender {
    
    if (self.isloading == YES) {
        NSLog(@"成功进入图片切换");
        MainPageCustomTopView *mainPageCustomTopView = [[MainPageCustomTopView alloc] init];
        [mainPageCustomTopView.avatarBtn setBackgroundImage:[UIImage imageNamed:@"headshot"] forState:UIControlStateNormal];
        [mainPageCustomTopView.avatarBtn setNeedsDisplay];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

#pragma mark -Lazy
- (LogingPageView *) logingPageView {
    if (_logingPageView == nil) {
        CGFloat width = self.view.frame.size.width;
        CGFloat height = self.view.frame.size.height;
        _logingPageView = [[LogingPageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        _logingPageView.backgroundColor = [UIColor whiteColor];
        
        [_logingPageView.logingBtn addTarget:self action:@selector(logingButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [_logingPageView.signUpBtn addTarget:self action:@selector(singUpButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [_logingPageView.backBtn addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logingPageView;
}

@end
