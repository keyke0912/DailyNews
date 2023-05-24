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

@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSArray *imageArray;
@property (nonatomic, copy) NSString *imageStr;
@property (nonatomic, copy) NSString *urlStr;
@property (nonatomic, copy) NSString *hintStr;
@property (nonatomic, copy) NSString *dateStr;
@property (nonatomic, copy) NSNumber *messageId;

///请求数据
+ (void)getDataWithSuccess:(void(^)(NSArray * _Nonnull, NSArray * _Nonnull))success
                   Failure:(void (^)(void)) failure
                   Url:(NSString *) url;
+ (void)getMoreDataWithSuccess:(void (^)(NSArray * _Nonnull))success Failure:(void (^)(void))failure Url:(NSString *)url;
///请求数据后返回模型
+ (instancetype)DataWithDictInTableView:(NSDictionary *)dict;

+ (instancetype)DataWithDictInBanner:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
