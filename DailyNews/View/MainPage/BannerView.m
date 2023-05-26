//
//  BannerView.m
//  DailyNews
//
//  Created by Key ke on 2023/5/24.
//

#import "BannerView.h"
#import "BannerCollectionViewCell.h"
#import "Masonry.h"

//NSString *BannerViewReuseIdentifier = @"BannerView";

@interface BannerView ()

@end

@implementation BannerView

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _bannerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
                
                // 其他设置
        _bannerCollectionView.pagingEnabled = YES;
        _bannerCollectionView.showsHorizontalScrollIndicator = NO;
        [_bannerCollectionView registerClass:BannerCollectionViewCell.class forCellWithReuseIdentifier:BannerCollectionViewCellReuseIdentifier];
        [self addSubview:self.bannerCollectionView];
        [self.bannerCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).mas_offset(0);
            make.left.mas_equalTo(self).mas_offset(0);
            make.width.mas_equalTo(self).mas_offset(0);
            make.height.mas_equalTo(self).mas_offset(0);
        }];
        
        [self addSubview:self.bannerPageControl];
        [self.bannerPageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).mas_offset(300);
            make.left.mas_equalTo(self).mas_offset(220);
            make.width.mas_offset(200);
            make.height.mas_offset(100);
        }];
    }
    return self;
}



#pragma mark -Lazy

- (UICollectionView *)bannerCollectionView {
    if (_bannerCollectionView == nil) {
        
        [_bannerCollectionView registerClass:BannerCollectionViewCell.class forCellWithReuseIdentifier:BannerCollectionViewCellReuseIdentifier];
        
    }
    return _bannerCollectionView;
}

- (UIPageControl *) bannerPageControl {
    if (_bannerPageControl == nil) {
        self.bannerPageControl = [[UIPageControl alloc] init];
        // 设置页面控件的属性
        self.bannerPageControl.pageIndicatorTintColor = [UIColor grayColor];
        self.bannerPageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        self.bannerPageControl.translatesAutoresizingMaskIntoConstraints = NO;
        self.bannerPageControl.numberOfPages = 5; // 设置总页数
        self.bannerPageControl.currentPage = 0; // 设置当前页为第一页
    }
    return _bannerPageControl;
}
@end
