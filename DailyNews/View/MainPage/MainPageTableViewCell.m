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

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *hint;
@property (nonatomic, strong) UIImageView *image;


@end

@implementation MainPageTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.hint];
        [self.contentView addSubview:self.image];
        
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).mas_offset(25);
            make.left.mas_equalTo(self.contentView).mas_offset(10);
            make.width.mas_equalTo(self.contentView).mas_offset(-100);
            
        }];
        
        [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY).mas_offset(0);
            make.left.mas_equalTo(self.title.mas_right).mas_offset(2);
            make.width.mas_equalTo(self.contentView.mas_height).mas_offset(-40);
            make.height.mas_equalTo(self.contentView).mas_offset(-40);
        }];
        
        [self.hint mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.title.mas_bottom).mas_offset(0);
            make.left.mas_equalTo(self.title).mas_offset(0);
            make.width.mas_equalTo(self.title).mas_offset(0);
            make.height.mas_offset(20);
        }];

    }
    return self;
}

#pragma mark-Lazy

- (UILabel *)title {
    if (_title == nil) {
        
        _title = [[UILabel alloc] init];
        _title.numberOfLines = 3;
        _title.font = [UIFont boldSystemFontOfSize:16];
        _title.text = _titleStr;
        
    }
    return _title;
}

- (UILabel *) hint {
    if (_hint == nil) {
        
        _hint = [[UILabel alloc] init];
        _hint.font = [UIFont systemFontOfSize:12];
        _hint.textColor = UIColor.grayColor;
        _hint.text = _hintStr;
        
    }
    return _hint;
}

- (UIImageView *) image {
    if (_image == nil) {
        
        _image = [[UIImageView alloc] init];
        _image.layer.cornerRadius = 4;
        _image.clipsToBounds = YES;
        [_image sd_setImageWithURL:[NSURL URLWithString:_imageStr]];
        
    }
    return _image;
}

@end
