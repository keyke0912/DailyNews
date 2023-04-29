//
//  Model.h
//  DailyNews
//
//  Created by Key ke on 2023/4/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Model : NSObject

@property (nonatomic, copy) NSString *title;
///请求数据
+ (void)getDataWithSuccess:(void(^)(NSArray *array))success
                   Failure:(void (^)(void)) failure;
///请求数据后返回模型
+ (instancetype)DataWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
