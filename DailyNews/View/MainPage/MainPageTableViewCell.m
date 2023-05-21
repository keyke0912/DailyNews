//
//  MainPageTableViewCell.m
//  DailyNews
//
//  Created by Key ke on 2023/4/25.
//

#import "MainPageTableViewCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface MainPageTableViewCell()



@end

@implementation MainPageTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self.contentView addSubview:self.tableTitleLab];
        [self.contentView addSubview:self.tableHintLab];
        [self.contentView addSubview:self.tableImageView];
        
        [self.tableTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).mas_offset(25);
            make.left.mas_equalTo(self.contentView).mas_offset(10);
            make.width.mas_equalTo(self.contentView).mas_offset(-100);
            
        }];
        
        [self.tableImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY).mas_offset(0);
            make.left.mas_equalTo(self.tableTitleLab.mas_right).mas_offset(2);
            make.width.mas_equalTo(self.contentView.mas_height).mas_offset(-40);
            make.height.mas_equalTo(self.contentView).mas_offset(-40);
        }];
        
        [self.tableHintLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.tableTitleLab.mas_bottom).mas_offset(0);
            make.left.mas_equalTo(self.tableTitleLab).mas_offset(0);
            make.width.mas_equalTo(self.tableTitleLab).mas_offset(0);
            make.height.mas_offset(20);
        }];

    }
    return self;
}

#pragma mark-Lazy

- (UILabel *)tableTitleLab {
    if (_tableTitleLab == nil) {
        
        _tableTitleLab = [[UILabel alloc] init];
        _tableTitleLab.numberOfLines = 2;
        _tableTitleLab.font = [UIFont boldSystemFontOfSize:16];
        //_title.backgroundColor = [UIColor blueColor];
        //_title.text = _titleStr;
        
    }
    return _tableTitleLab;
}

- (UILabel *) tableHintLab {
    if (_tableHintLab == nil) {
        
        _tableHintLab = [[UILabel alloc] init];
        _tableHintLab.font = [UIFont systemFontOfSize:12];
        _tableHintLab.textColor = UIColor.grayColor;
        //_hint.backgroundColor = [UIColor greenColor];
        //_hint.text = _hintStr;
        
    }
    return _tableHintLab;
}

- (UIImageView *) tableImageView {
    if (_tableImageView == nil) {
        
        _tableImageView = [[UIImageView alloc] init];
        _tableImageView.layer.cornerRadius = 4;
        _tableImageView.clipsToBounds = YES;
        //[_image sd_setImageWithURL:[NSURL URLWithString:_imageStr]];
        
        
    }
    return _tableImageView;
}

@end
