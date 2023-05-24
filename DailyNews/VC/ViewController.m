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
#import "HeaderView.h"
#import "BannerView.h"

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
@property (nonatomic, strong) NSMutableArray<NSArray *> *moreDataArray;
@property (nonatomic, copy) NSString *pastNewsUrlStr;
@property (nonatomic, copy) NSString *firstUrlStr;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong) MainPageCustomTopView *topView;
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic, strong) BannerView *bannerView;


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
#pragma mark - getData
    [Model getDataWithSuccess:^(NSArray * _Nonnull arrayWithTableView, NSArray * _Nonnull arrayWithBanner) {
        
        
        self.bannerDataArray = arrayWithBanner;
        NSLog(@"%@", arrayWithBanner);
//        [self.view addSubview:self.bannerView.bannerCollectionView];
//        [self.bannerView.bannerCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.top.mas_equalTo(self.topView.mas_bottom).mas_offset(0); //参数设置为topview的高度可以实现紧贴
//            make.left.mas_equalTo(self.view).mas_offset(0);
//            make.width.mas_equalTo(self.view).mas_offset(0);
//            make.height.mas_equalTo(self.view.mas_width).mas_offset(0);
//
//        }];
        
        self.tableViewDataArray = arrayWithTableView;
        [self.moreDataArray addObject:self.tableViewDataArray];
        NSLog(@"222222%@", self.moreDataArray);
        NSLog(@"%@", arrayWithTableView);
        [self.view addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(self.topView.mas_bottom).mas_offset(0); //参数设置为的高度可以实现紧贴
            make.left.mas_equalTo(self.view).mas_offset(0);
            make.width.mas_equalTo(self.view).mas_offset(0);
            make.height.mas_equalTo(self.view).mas_offset(0);
            
        }];
        } Failure:^{
            NSLog(@"error");
        } Url:@"https://news-at.zhihu.com/api/3/news/latest"];
        
    
}

#pragma mark-<UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.moreDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.moreDataArray[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[MainPageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    Model *model = self.moreDataArray[indexPath.section][indexPath.row];
    //这里原来是通过只在h文件里暴露titleStr来搭建桥梁，但出了bug在初始化的时候请求还没传过去，不能正常显示
//    cell.titleStr = model.title;
//    //cell.imageStr = model.image;
//    cell.hintStr = model.hint;
    
    cell.tableTitleLab.text = model.titleStr;
    cell.tableHintLab.text = model.hintStr;
    [cell.tableImageView sd_setImageWithURL:[NSURL URLWithString:[model.imageArray objectAtIndex:0]]];
    
    return cell;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        NSLog(@"bannerView请求");
        return self.bannerView;
    } else {
        NSLog(@"其他header请求");
    HeaderView *nomalHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderViewReuseIdentifier];
    if (nomalHeaderView == nil) {
        nomalHeaderView = [[HeaderView alloc] initWithReuseIdentifier:HeaderViewReuseIdentifier];
    }
    return nomalHeaderView;
   }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        CGFloat collectionViewHeight = self.view.frame.size.width;
        return collectionViewHeight;
    }else{
        return 30;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0000001f;
}
#pragma mark-<UITableViewDelegate>

//设置足够的tableview行高之后才能显现出image
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

#pragma mark - <UICollectionViewDataSource>

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"正常进入collectionCell的设置");
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
    NSLog(@"成功进入layout");
    return collectionView.frame.size;
}


#pragma mark-Lazy
- (UITableView *)tableView {
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        
        [_tableView registerClass:HeaderView.class forHeaderFooterViewReuseIdentifier:HeaderViewReuseIdentifier];
        [_tableView registerClass:MainPageTableViewCell.class forCellReuseIdentifier:MainPageTableViewCellReuseIdentifier];
        
        
    }
    return _tableView;
}

- (MainPageCustomTopView *)topView {
    if (_topView == nil) {
        
        _topView = [[MainPageCustomTopView alloc] init];
        
    }
    return _topView;
}

- (BannerView *)bannerView {
    if (_bannerView == nil) {
        CGFloat width = self.view.frame.size.width;
        NSLog(@"3333333333333    %f", width);
        _bannerView = [[BannerView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
        _bannerView.bannerCollectionView.delegate = self;
        _bannerView.bannerCollectionView.dataSource = self;
        
        
        
    }
    return _bannerView;
}


- (NSMutableArray<NSArray *> *)moreDataArray{
    if(_moreDataArray == nil){
        _moreDataArray = [[NSMutableArray alloc]init];
    }
    return _moreDataArray;
}


#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGFloat contentYoffset = scrollView.contentOffset.y;
//    NSLog(@"内容-偏移量:%f table高度:%f",scrollView.contentSize.height-contentYoffset,self.tableView.frame.size.height);
//    if(self.tableView.frame.size.height == 0 ||scrollView.contentSize.height-contentYoffset<700) return;
//    if(self.isLoading == YES) return;
//    if (scrollView.contentSize.height-contentYoffset- 200<= self.tableView.frame.size.height) {
//        [self loadMoreData];
//        NSLog(@"loadMore success\n\n\n\n\n\n\n\n\n\n");
//        self.isLoading = YES;
//    }
//
    CGFloat offsetY = scrollView.contentOffset.y;
        CGFloat contentHeight = scrollView.contentSize.height;
        CGFloat screenHeight = scrollView.frame.size.height;
        
        if (offsetY > contentHeight - screenHeight - 200) {
            // 判断滚动到底部
            [self loadMoreData];
            NSLog(@"加载方法调用成功");
        }
}

-(void)loadMoreData {
    NSLog(@"进入加载成功");
    Model *dataModel  = self.moreDataArray[self.moreDataArray.count-1][0];
    NSLog(@"1111111%lu", self.moreDataArray.count-1);
    NSLog(@"%@", self.moreDataArray);
    self.pastNewsUrlStr = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/3/stories/before/%@", [NSString stringWithFormat:@"%d",[dataModel.dateStr intValue]]];
    NSLog(@"%@", dataModel.dateStr);
    [Model getMoreDataWithSuccess:^(NSArray * _Nonnull array) {
        NSLog(@"进入请求成功");
        //self.tableViewDataArray = array;
        [self.moreDataArray addObject:array];
        NSLog(@"loadmore\n\n\n\n");
        NSLog(@"%@", dataModel.dateStr);
        [self.tableView reloadData];
        self.isLoading = NO;
    } Failure:^{
            NSLog(@"请求失败");
        } Url:self.pastNewsUrlStr] ;
    
   
}



@end
