//
//  BannerCollectionViewCell.h
//  DailyNews
//
//  Created by Key ke on 2023/5/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 复用标志
UIKIT_EXTERN NSString *BannerCollectionViewCellReuseIdentifier;

@interface BannerCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *bannerTitleLab;
@property (nonatomic, strong) UILabel *bannerHintLab;
@property (nonatomic, strong) UIImageView *bannerImageView;

@end

NS_ASSUME_NONNULL_END
