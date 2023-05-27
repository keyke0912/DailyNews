//
//  HeaderView.h
//  DailyNews
//
//  Created by Key ke on 2023/5/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSString *HeaderViewReuseIdentifier;

@interface HeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel *dateLab;
@property (nonatomic, strong) UIView *dividingLine;


@end

NS_ASSUME_NONNULL_END
