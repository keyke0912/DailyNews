//
//  BannerView.h
//  DailyNews
//
//  Created by Key ke on 2023/5/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//UIKIT_EXTERN NSString *BannerViewReuseIdentifier;

@interface BannerView : UITableViewHeaderFooterView

@property (nonatomic, strong) UICollectionView *bannerCollectionView;

@end

NS_ASSUME_NONNULL_END
