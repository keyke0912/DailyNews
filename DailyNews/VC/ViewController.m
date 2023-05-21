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
#import "BannerCollectionViewCell.h"

@interface ViewController () <
    UITableViewDelegate,
    UITableViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *tableViewDataArray;
@property (nonatomic, copy) NSArray *bannerDataArray;
@property (nonatomic, strong) MainPageCustomTopView *topView;
@property (nonatomic, strong) UICollectionView *bannerCollectionView;

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
    
    [Model getDataWithSuccess:^(NSArray * _Nonnull arrayWithTableView, NSArray * _Nonnull arrayWithBanner) {
        
        self.bannerDataArray = arrayWithBanner;
        NSLog(@"%@", arrayWithBanner);
        [self.view addSubview:self.bannerCollectionView];
        [self.bannerCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(self.topView.mas_bottom).mas_offset(0); //参数设置为topview的高度可以实现紧贴
            make.left.mas_equalTo(self.view).mas_offset(0);
            make.width.mas_equalTo(self.view).mas_offset(0);
            make.height.mas_equalTo(self.view.mas_width).mas_offset(0);
            
        }];
        
        self.tableViewDataArray = arrayWithTableView;
        NSLog(@"%@", arrayWithTableView);
        [self.view addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(self.bannerCollectionView.mas_bottom).mas_offset(0); //参数设置为的高度可以实现紧贴
            make.left.mas_equalTo(self.view).mas_offset(0);
            make.width.mas_equalTo(self.view).mas_offset(0);
            make.height.mas_equalTo(self.view).mas_offset(0);
            
        }];
        } Failure:^{
            NSLog(@"error");
        }];
        
    
}

#pragma mark-<UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1; //tableView中只包含一个分区
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableViewDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[MainPageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    Model *model = self.tableViewDataArray[indexPath.row];
    //这里原来是通过只在h文件里暴露titleStr来搭建桥梁，但出了bug在初始化的时候请求还没传过去，不能正常显示
//    cell.titleStr = model.title;
//    //cell.imageStr = model.image;
//    cell.hintStr = model.hint;
    
    cell.tableTitleLab.text = model.titleStr;
    cell.tableHintLab.text = model.hintStr;
    [cell.tableImageView sd_setImageWithURL:[NSURL URLWithString:[model.imageArray objectAtIndex:0]]];
    
    return cell;
}


#pragma mark-<UITableViewDelegate>

//设置足够的tableview行高之后才能显现出image
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

#pragma mark - <UICollectionViewDataSource>

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BannerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BannerCollectionViewCellReuseIdentifier forIndexPath:indexPath];
    
    Model *model = self.bannerDataArray[indexPath.item];
    cell.bannerTitleLab.text = model.titleStr;
    cell.bannerHintLab.text = model.hintStr;
    [cell.bannerImageView sd_setImageWithURL:[NSURL URLWithString:model.imageStr]];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.frame.size;
}

#pragma mark-Lazy
- (UITableView *)tableView {
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc]  init];
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

- (UICollectionView *)bannerCollectionView {
    if (_bannerCollectionView == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _bannerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _bannerCollectionView.delegate = self;
        _bannerCollectionView.dataSource = self;
        _bannerCollectionView.pagingEnabled = YES;
        _bannerCollectionView.showsHorizontalScrollIndicator = NO;
        
        [_bannerCollectionView registerClass:BannerCollectionViewCell.class forCellWithReuseIdentifier:BannerCollectionViewCellReuseIdentifier];
        
    }
    return _bannerCollectionView;
}



@end
