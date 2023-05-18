//
//  Model.h
//  DailyNews
//
//  Created by Key ke on 2023/4/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Model : NSObject
//这里要声明一些需要请求下来的数据类型

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray *image;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *hint;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSNumber *messageId;

///请求数据
+ (void)getDataWithSuccess:(void(^)(NSArray *array))success
                   Failure:(void (^)(void)) failure;
///请求数据后返回模型
+ (instancetype)DataWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
