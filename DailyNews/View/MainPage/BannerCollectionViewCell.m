//
//  BannerCollectionViewCell.m
//  DailyNews
//
//  Created by Key ke on 2023/5/20.
//

#import "BannerCollectionViewCell.h"
#import "Masonry.h"

NSString *BannerCollectionViewCellReuseIdentifier = @"BannerCollectionViewCell";

@interface BannerCollectionViewCell ()



@end

@implementation BannerCollectionViewCell

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.bannerImageView];
        [self.contentView addSubview:self.bannerTitleLab];
        [self.contentView addSubview:self.bannerHintLab];
        
        
        [self.bannerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.contentView).mas_offset(0);
        }];
        
        [self.bannerTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).mas_offset(270);
            make.left.mas_equalTo(self.contentView).mas_offset(19);
            make.width.mas_equalTo(self.contentView.mas_width).mas_offset(-55);
            make.height.mas_offset(65);
        }];
        
        [self.bannerHintLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bannerTitleLab.mas_bottom).mas_offset(0);
            make.left.mas_equalTo(self.bannerTitleLab).mas_offset(0);
            make.width.mas_offset(200);
            make.height.mas_offset(20);
        }];

        
    }
    return self;
}

#pragma mark - Lazy

- (UILabel *) bannerTitleLab {
    if (_bannerTitleLab == nil) {
        
        _bannerTitleLab = [[UILabel alloc]init];
        _bannerTitleLab.numberOfLines = 2;
        _bannerTitleLab.font = [UIFont boldSystemFontOfSize:22];
        _bannerTitleLab.textColor = UIColor.whiteColor;
        
    }
    return _bannerTitleLab;
}

- (UILabel *) bannerHintLab {
    if (_bannerHintLab == nil) {
        
        _bannerHintLab = [[UILabel alloc]init];
        _bannerHintLab.font = [UIFont systemFontOfSize:16];
        _bannerHintLab.textColor = UIColor.grayColor;
        _bannerHintLab.alpha = 1;
        
    }
    return _bannerHintLab;
}

- (UIImageView *) bannerImageView {
    if (_bannerImageView == nil) {
        
        _bannerImageView = [[UIImageView alloc] init];
        
    }
    return _bannerImageView;
}
@end
