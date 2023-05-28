//
//  ViewController.m
//  DailyNews
//
//  Created by Key ke on 2023/4/21.
//

#import "MainPageViewController.h"
#import "Model.h"
#import "MainPageCustomTopView.h"
#import "Masonry.h"
#import "MainPageTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "BannerCollectionViewCell.h"
#import "HeaderView.h"
#import "BannerView.h"
#import "DetailPageViewController.h"
#import "LogingPageViewController.h"

@interface MainPageViewController () <
    UITableViewDelegate,
    UITableViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout,
    UIScrollViewDelegate
    
>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *tableViewDataArray;
@property (nonatomic, strong) NSMutableArray *bannerDataArray;
@property (nonatomic, strong) NSMutableArray<NSArray *> *moreDataArray;
@property (nonatomic, copy) NSString *pastNewsUrlStr;
@property (nonatomic, copy) NSString *firstUrlStr;
@property (nonatomic, getter=isloading, assign) BOOL loading;
@property (nonatomic, strong) MainPageCustomTopView *topView;
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic, strong) BannerView *bannerView;
@property (nonatomic, assign) NSInteger currentPageIndex;


@end

@implementation MainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    _topview = [[MainPageCustomTopView alloc] init];
//    [self.view addSubview:_topview];
//    [self preferredStatusBarStyle];
    self.moreDataArray = [NSMutableArray array];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.navigationController == nil) NSLog(@"11111111nilnilnilnilnil");
    
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.view).mas_offset(55);
        make.left.mas_equalTo(self.view).mas_offset(0);
        make.width.mas_equalTo(self.view.mas_width).mas_offset(0);
        make.height.mas_offset(55);
        
    }];
#pragma mark - getData
    [Model getDataWithSuccess:^(NSArray * _Nonnull arrayWithTableView, NSArray * _Nonnull arrayWithBanner) {
        
        
        self.bannerDataArray = [arrayWithBanner mutableCopy];
        [self.bannerDataArray addObject:arrayWithBanner[0]];
        [self.bannerDataArray insertObject:arrayWithBanner[arrayWithBanner.count - 1] atIndex:0];
        
        NSLog(@"arrayWithBanner%@", arrayWithBanner);
        NSLog(@"bannerDataArray%@", self.bannerDataArray);
        
        self.tableViewDataArray = arrayWithTableView;
        [self.moreDataArray addObject:self.tableViewDataArray];
        NSLog(@"moreDataArray%@", self.moreDataArray);
        NSLog(@"arrayWithTableView%@", arrayWithTableView);
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
        UIView *view = self.bannerView;
//        // 获取第一个section的indexPath
//        NSIndexPath *firstSectionIndexPath = [NSIndexPath indexPathForItem:1 inSection:0];
//
//        // 滚动到指定的indexPath，使其在屏幕上可见
//        [self.bannerView.bannerCollectionView scrollToItemAtIndexPath:firstSectionIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];

//        [self startTimer];
        return view;
    } else {
        NSLog(@"其他header请求");
        
        HeaderView *nomalHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderViewReuseIdentifier];
        if (nomalHeaderView == nil) {
        nomalHeaderView = [[HeaderView alloc] initWithReuseIdentifier:HeaderViewReuseIdentifier];
        }
        
        Model *dateModel = self.moreDataArray[section][0];
        NSString *month = [dateModel.dateStr substringWithRange:NSMakeRange(4, 2)];
        NSString *date = [dateModel.dateStr substringWithRange:NSMakeRange(6, 2)];
        nomalHeaderView.dateLab.text= [NSString stringWithFormat:@"%ld月%ld日",[month integerValue],[date integerValue]];
        
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"select");
    //UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self];
    
//    [[UINavigationController alloc] initWithRootViewController:ViewController];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    Model *dataModel  = self.moreDataArray[indexPath.section][indexPath.row];
    DetailPageViewController *detailPageViewController = [[DetailPageViewController alloc]init];
//    dvc.modalPresentationStyle = UIModalPresentationFullScreen;
    detailPageViewController.url = [NSURL URLWithString:dataModel.urlStr];
    detailPageViewController.dataUrl= [NSString stringWithFormat:@"https://news-at.zhihu.com/api/3/story-extra/%@",dataModel.messageId];
    
    [self.navigationController pushViewController:detailPageViewController animated:YES];
    
    if (self.navigationController == nil) NSLog(@"nilnilnil");
    
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
    return self.bannerDataArray.count;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Model *bannerModel = self.bannerDataArray[indexPath.item];
    DetailPageViewController *detailPageViewController = [[DetailPageViewController alloc]init];
    detailPageViewController.url = [NSURL URLWithString:bannerModel.urlStr];
    detailPageViewController.dataUrl= [NSString stringWithFormat:@"https://news-at.zhihu.com/api/3/story-extra/%@",bannerModel.messageId];
    
    [self.navigationController pushViewController:detailPageViewController animated:YES];
    
    if (self.navigationController == nil) NSLog(@"nilnilnil");
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"成功进入layout");
    return collectionView.frame.size;
}

- (void) avatarButtonClicked: (UIButton *)sender {
    NSLog(@"avatar按钮被点击了！");
    LogingPageViewController *logingPageViewController = [[LogingPageViewController alloc] init];
    [self.navigationController pushViewController:logingPageViewController animated:YES];
    
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
        [_topView.avatarBtn addTarget:self action:@selector(avatarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _topView;
}

- (BannerView *)bannerView {
    if (_bannerView == nil) {
        self.currentPageIndex = 0;
        CGFloat width = self.view.frame.size.width;
//        NSLog(@"3333333333333    %f", width);
        _bannerView = [[BannerView alloc] initWithFrame:CGRectMake(0, 0, width, 393)];
        _bannerView.bannerCollectionView.delegate = self;
        _bannerView.bannerCollectionView.dataSource = self;

        [self startTimer];
        
    }
    return _bannerView;
}


- (NSMutableArray<NSArray *> *)moreDataArray{
    if(_moreDataArray == nil){
        _moreDataArray = [[NSMutableArray alloc]init];
    }
    return _moreDataArray;
}


#pragma mark - <ScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.bannerView.bannerCollectionView) {
        // 计算当前页码
        CGFloat pageWidth = scrollView.bounds.size.width;
        NSInteger currentPage = (scrollView.contentOffset.x + pageWidth * 0.5) / pageWidth;
            
        // 根据实际的轮播图页面数量，进行取模运算，得到正确的页码
        NSInteger totalPages = 5;
        currentPage = currentPage % totalPages;
            
        // 更新bannerPageControl的当前页码
        self.bannerView.bannerPageControl.currentPage = currentPage;
        
    } else if (scrollView == self.tableView) {
        // 处理表格视图的滚动事件
//        NSLog(@"tableViewScoll");
        CGFloat offsetY = scrollView.contentOffset.y;
        CGFloat contentHeight = scrollView.contentSize.height;
        CGFloat screenHeight = scrollView.frame.size.height;
            
        if (self.isloading == YES) return;
        
        if (offsetY > contentHeight - screenHeight - 300) {
                // 判断滚动到底部
            [self loadMoreData];
            self.loading = YES;
            NSLog(@"加载方法调用成功");
        }
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == self.bannerView.bannerCollectionView) {
            // 处理轮播图的滚动事件
        NSLog(@"scroll------BeginDragging");
        [self stopTimer];
        

        // 更新页面控件的当前页
        //self.bannerView.bannerPageControl.currentPage = nextIndex;
    } else if (scrollView == self.tableView) {
            // 处理表格视图的滚动事件
        NSLog(@"table------BeginDragging");
    }
}
//当用户手指从滚动视图上离开，并且滚动视图停止滚动后，该方法会被触发
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 处理轮播图的滚动事件
    NSInteger currentPage = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    NSInteger totalPages = [self.bannerView.bannerCollectionView numberOfItemsInSection:0];

    if (currentPage == 0) {
    // 滚动到首位单元格时，跳转到倒数第二个单元格（最后一个实际单元格）
        NSLog(@"滚动到首位单元格时，跳转到倒数第二个单元格（最后一个实际单元格）");
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:(totalPages - 2) inSection:0];
        [self.bannerView.bannerCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    } else if (currentPage == (totalPages - 1)) {
    // 滚动到末尾单元格时，跳转到第二个单元格（第一个实际单元格）
        NSLog(@"滚动到末尾单元格时，跳转到第二个单元格（第一个实际单元格)");
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
        [self.bannerView.bannerCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView == self.bannerView.bannerCollectionView) {
           
        ///[self startTimer];
        ///这样设置的话会有连续两下滑动的特别快，解决方法就是，添加一个判断；
        
        if (_bannerTimer == nil)  {
            [self startTimer];
        }
        NSLog(@"scroll------EndDragging");
    } else if (scrollView == self.tableView) {
            // 处理表格视图的滚动事件
        NSLog(@"table------EndDragging");
    }
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}


-(void)loadMoreData {
    NSLog(@"进入加载成功");
    Model *dataModel  = self.moreDataArray[self.moreDataArray.count-1][0];

    NSLog(@"请求前%@", self.moreDataArray);
    self.pastNewsUrlStr = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/3/stories/before/%@", dataModel.dateStr];
    NSLog(@"请求前%@", dataModel.dateStr);
    NSLog(@"pastNewsUrlStr%@", self.pastNewsUrlStr);
    [Model getMoreDataWithSuccess:^(NSArray * _Nonnull array) {
        NSLog(@"进入请求成功");
        [self.moreDataArray addObject:array];
        NSLog(@"请求后%@", self.moreDataArray);
        //重新加载UITableView的数据并刷新显示。
        [self.tableView reloadData];
        self.loading = NO;
    } Failure:^{
            NSLog(@"请求失败");
        } Url:self.pastNewsUrlStr] ;
    
   
}

#pragma mark --Timer

- (void)startTimer {
    // 启动定时器
    NSLog(@"startTimer");
    self.bannerTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(scrollToNextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.bannerTimer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    // 停止定时器
    NSLog(@"endTimer");
    [self.bannerTimer invalidate];
    self.bannerTimer = nil;
}


- (void)scrollToNextPage {
    if (_bannerTimer != nil) {
        NSLog(@"成功调用方法scrollToNextPage");
        BOOL flag = YES;
        // 获取当前显示的索引
        NSInteger currentIndex = self.currentPageIndex;

        // 计算下一个要显示的索引
        NSInteger nextIndex = currentIndex + 1;
        NSLog(@"nextIndex%ld", (long)nextIndex);
        if (currentIndex == 5) {
            nextIndex = 0;
            flag = NO;
            [self stopTimer];
        }
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextIndex inSection:0];
        [self.bannerView.bannerCollectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:flag];
        // 更新当前显示的索引
        self.currentPageIndex = nextIndex;
        NSLog(@"currentPageIndex%ld", (long)self.currentPageIndex);
        if (flag == NO) [self startTimer];

    }
}




@end
