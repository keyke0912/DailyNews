//
//  ViewController.m
//  DailyNews
//
//  Created by Key ke on 2023/4/21.
//

#import "ViewController.h"
#import "Model.h"
#import "MainPageCustomTopView.h"
#import "Masonry.h"
#import "MainPageTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *array;
@property (nonatomic, strong) MainPageCustomTopView *topView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    _topview = [[MainPageCustomTopView alloc] init];
//    [self.view addSubview:_topview];
    
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view).mas_offset(55);
        make.left.mas_equalTo(self.view).mas_offset(0);
        make.width.mas_equalTo(self.view.mas_width).mas_offset(0);
        make.height.mas_offset(55);
        
    }];
    
    [Model getDataWithSuccess:^(NSArray * _Nonnull array) {
        self.array = array;
        NSLog(@"%@", array);
        [self.view addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(self.topView).mas_offset(55); //参数设置为topview的高度可以实现紧贴
            make.left.mas_equalTo(self.view).mas_offset(0);
            make.width.mas_equalTo(self.view).mas_offset(0);
            make.height.mas_equalTo(self.view).mas_offset(0);
            
        }];
        } Failure:^{
            NSLog(@"error");
        }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1; //tableView中只包含一个分区
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

//设置足够的tableview行高之后才能显现出image
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[MainPageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    Model *model = self.array[indexPath.row];
//    cell.titleStr = model.title;
//    //cell.imageStr = model.image;
//    cell.hintStr = model.hint;
    cell.title.text = model.title;
    cell.hint.text = model.hint;
    [cell.image sd_setImageWithURL:[NSURL URLWithString:[model.image objectAtIndex:0]]];
    
    return cell;
}

#pragma Lazy
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[MainPageCustomTopView alloc] init];
        
        
    }
    return _topView;
}

@end
