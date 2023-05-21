//
//  Model.m
//  DailyNews
//
//  Created by Key ke on 2023/4/21.
//

#import "Model.h"
#import "AFHTTPSessionManager.h"
@implementation Model

+ (instancetype)DataWithDictInTableView:(NSDictionary *)dict {
    Model *modelWithTableView = [[Model alloc] init];
    modelWithTableView.titleStr = dict[@"title"];
    modelWithTableView.imageArray = dict[@"images"];
    modelWithTableView.urlStr = dict[@"url"];
    modelWithTableView.hintStr = dict[@"hint"];
    modelWithTableView.messageId = dict[@"id"];
    return modelWithTableView;
}

+ (instancetype)DataWithDictInBanner:(NSDictionary *)dict {
    Model *modelWithBanner = [[Model alloc] init];
    modelWithBanner.titleStr = dict[@"title"];
    modelWithBanner.imageStr = dict[@"image"];
    modelWithBanner.urlStr = dict[@"url"];
    modelWithBanner.hintStr = dict[@"hint"];
    return modelWithBanner;
}

+ (void)getDataWithSuccess:(void (^)(NSArray * _Nonnull, NSArray * _Nonnull))success Failure:(void (^)(void))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"https://news-at.zhihu.com/api/3/news/latest" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject ){
        
        NSMutableArray *mArrayWithTableView = [NSMutableArray array];
        NSMutableArray *mArrayWithBanner = [NSMutableArray array];
        
        for (NSDictionary *dict in responseObject[@"stories"]) {
            Model *model = [Model DataWithDictInTableView:dict];//临时model
            [mArrayWithTableView addObject:model];
        }
        for (NSDictionary *dict in responseObject[@"top_stories"]) {
            Model *model = [Model DataWithDictInBanner:dict];
            [mArrayWithBanner addObject:model];
        }
        if (success) success(mArrayWithTableView.copy, mArrayWithBanner.copy);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        }];
}

@end
