//
//  ExtraModel.h
//  DailyNews
//
//  Created by key ke on 2023/5/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExtraModel : NSObject

@property (nonatomic, assign) NSNumber *comments;
@property (nonatomic, assign) NSNumber *popularity;

+ (void) getDatawithSuccess:(void (^) (NSArray *array)) success Failure:(void (^) (void)) failure Url:(NSString *)url;

+ (instancetype) dataWithDict:(NSDictionary *) dict;

@end

NS_ASSUME_NONNULL_END
