//
//  Model.m
//  DailyNews
//
//  Created by Key ke on 2023/4/21.
//

#import "Model.h"
#import "AFHTTPSessionManager.h"
@implementation Model

+ (instancetype)DataWithDict:(NSDictionary *)dict {
    Model *model = [[Model alloc] init];
    model.title = dict[@"title"];
    model.image = dict[@"images"];
    model.url = dict[@"url"];
    model.hint = dict[@"hint"];
    model.messageId = dict[@"id"];
    return model;
}
+ (void)getDataWithSuccess:(void (^)(NSArray * _Nonnull))success Failure:(void (^)(void))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"https://news-at.zhihu.com/api/3/news/latest" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject ){
        
        NSMutableArray *mArray = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"stories"]) {
            Model *model = [Model DataWithDict:dict];
            [mArray addObject:model];
        }
        if (success) success(mArray.copy);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        }];
}

@end
