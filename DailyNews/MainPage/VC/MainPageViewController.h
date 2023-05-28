//
//  ViewController.h
//  DailyNews
//
//  Created by Key ke on 2023/4/21.
//

#import <UIKit/UIKit.h>

@interface MainPageViewController : UIViewController

@property (nonatomic, strong) NSTimer *bannerTimer;

- (void) stopTimer;
- (void) startTimer;

@end

