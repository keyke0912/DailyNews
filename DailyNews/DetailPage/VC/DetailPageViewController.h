//
//  DetailPageViewController.h
//  DailyNews
//
//  Created by key ke on 2023/5/26.
//


#import "WebKit/WebKit.h"
#import "ExtraView.h"
#import "ExtraModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailPageViewController : UIViewController
@property (nonatomic, strong) WKWebView * webView;
@property (nonatomic, copy) NSURL *url;
@property (nonatomic, strong) ExtraView *extView;
@property (nonatomic, copy) NSString *dataUrl;
@property (nonatomic, copy) NSArray *dataArray;

@end

NS_ASSUME_NONNULL_END
