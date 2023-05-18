//
//  MainPageTableViewCell.h
//  DailyNews
//
//  Created by Key ke on 2023/4/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainPageTableViewCell : UITableViewCell

//这里由于要通过controller进行model与view的通信，需要将控件设置的string暴露在h文件里
//出bug了完后再实现

//@property (nonatomic, copy) NSString *titleStr;
//@property (nonatomic, copy) NSString *hintStr;
//@property (nonatomic, copy) NSString *imageStr;

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *hint;
@property (nonatomic, strong) UIImageView *image;


@end

NS_ASSUME_NONNULL_END
