//
//  Interfaces.h
//  RedditGold
//
//  Created by Tanner Bennett on 2017-08-11
//  Copyright © 2017 Tanner Bennett. All rights reserved.
//

#pragma mark Imports

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "Reddit/Models.h"
#import "Reddit/API.h"
#import "Reddit/ASDisplayNodes.h"
#import "Reddit/ActionSheet.h"
#import "Reddit/Views.h"
#import "Reddit/ViewControllers.h"
#import "Reddit/Categories.h"

// #import "Reddit/Old.h"

#pragma mark Interfaces

@interface TBMenuItem : UIMenuItem
+ (instancetype)title:(NSString *)title action:(SEL)action copy:(NSString *)string;
@property (nonatomic, readonly) NSString *storage;
@end


#pragma mark Macros

#define Log(...) NSLog(@"***\n" __VA_ARGS__)


#define Alert(TITLE,MSG) [[[UIAlertView alloc] initWithTitle:(TITLE) \
message:(MSG) \
delegate:nil \
cancelButtonTitle:@"OK" \
otherButtonTitles:nil] show];

#define UIAlertController(title, msg) [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:1]
#define UIAlertControllerAddAction(alert, title, stl, code...) [alert addAction:[UIAlertAction actionWithTitle:title style:stl handler:^(id action) code]];
#define UIAlertControllerAddCancel(alert) [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]
#define ShowAlertController(alert, from) [from presentViewController:alert animated:YES completion:nil];
