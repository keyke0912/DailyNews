//
//  HeaderView.m
//  DailyNews
//
//  Created by Key ke on 2023/5/23.
//

#import "HeaderView.h"

NSString *HeaderViewReuseIdentifier = @"HeaderView";

@interface HeaderView ()


@property (nonatomic, strong) UILabel *dateLab;
@property (nonatomic, strong) UIView *dividingLine;


@end

@implementation HeaderView

- (instancetype) initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.dateLab];
        [self.contentView addSubview:self.dividingLine];
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark -Lazy

- (UILabel *) dateLab {
    if (_dateLab == nil) {
        _dateLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        _dateLab.text = @"666";
        _dateLab.font = [UIFont boldSystemFontOfSize:23];
    }
    return _dateLab;
}

- (UIView *) dividingLine {
    if (_dividingLine == nil) {
        _dividingLine = [[UIView alloc] initWithFrame:CGRectMake(100, 10, 200, 1)];
        _dividingLine.backgroundColor = [UIColor grayColor];
    }
    return _dividingLine;
}

@end
