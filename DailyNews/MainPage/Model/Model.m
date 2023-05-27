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
    modelWithBanner.messageId = dict[@"id"];
    return modelWithBanner;
}

+ (void)getDataWithSuccess:(void (^)(NSArray * _Nonnull, NSArray * _Nonnull))success Failure:(void (^)(void))failure Url:(NSString *)url{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject ){
        
        NSMutableArray *mArrayWithTableView = [NSMutableArray array];
        NSMutableArray *mArrayWithBanner = [NSMutableArray array];
        
        Model *model;
        
        for (NSDictionary *dict in responseObject[@"stories"]) {
            model = [Model DataWithDictInTableView:dict];//临时model
            model.dateStr = responseObject[@"date"];
            [mArrayWithTableView addObject:model];
        }
        for (NSDictionary *dict in responseObject[@"top_stories"]) {
            model = [Model DataWithDictInBanner:dict];
            model.dateStr = responseObject[@"date"];
            [mArrayWithBanner addObject:model];
        }
        
        if (success) success(mArrayWithTableView.copy, mArrayWithBanner.copy);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        } ];
    
}

+ (void)getMoreDataWithSuccess:(void (^)(NSArray * _Nonnull))success Failure:(void (^)(void))failure Url:(NSString *)url {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject ) {
        
        NSMutableArray *mArrayWithMore = [NSMutableArray array];
        Model *model;
        
        for (NSDictionary *dict in responseObject[@"stories"]) {
            model = [Model DataWithDictInTableView:dict];
            model.dateStr = responseObject[@"date"];
            [mArrayWithMore addObject:model];
            
        } if (success) success(mArrayWithMore.copy);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure11");
    }
];
    
}

@end
