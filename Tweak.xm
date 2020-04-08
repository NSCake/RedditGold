//
//  Tweak.xm
//  RedditGold
//
//  Created by Tanner Bennett on 2017-08-11
//  Copyright © 2017 Tanner Bennett. All rights reserved.
//

#import "Interfaces.h"

// Prevent app from crashing in the background on iOS 13
%hook UIApplication
- (UIBackgroundTaskIdentifier)beginBackgroundTaskWithExpirationHandler:(void (^)(void))handler {
    return UIBackgroundTaskInvalid;
}

- (UIBackgroundTaskIdentifier)beginBackgroundTaskWithName:(NSString *)taskName expirationHandler:(void (^)(void))handler {
    return UIBackgroundTaskInvalid;
}
%end

// Disable analytics
%hook AnalyticsManager
- (void)logAnalyticsEvent:(id)event { }
%end

%hook Account
- (BOOL)shouldIgnoreSuggestedCommentSort { return YES; }
%end

%hook SearchViewController
- (id)searchTermBlacklist { return @[]; }
%end

%hook UITabBarItem
- (void)setBadgeValue:(id)value { %orig(nil); }
%end

%hook Post
- (BOOL)spoiler { return NO; }
%end

%hook Subreddit
- (BOOL)quarantined { return NO; }
%end

%hook MainTabBarController
- (id)coinSaleNavigationButton { return [UIBarButtonItem new]; }
%end

// Not necessary after 4.3.0
// %hook AVAudioSession
// - (void)setCategory:(NSString *)category {
//     %orig(AVAudioSessionCategorySoloAmbient);
// }
// - (BOOL)setCategory:(NSString *)category error:(NSError *)error {
//     return %orig(AVAudioSessionCategorySoloAmbient, error);
// }
// - (BOOL)setCategory:(NSString *)category withOptions:(AVAudioSessionCategoryOptions)options error:(NSError *)error {
//     return %orig(AVAudioSessionCategorySoloAmbient, options, error);
// }
// %end

%hook HlsPlayerView
- (id)initWithFrame:(CGRect)frame {
    self = %orig;
    [self muteTapped:nil];
    return self;
}
%end

%hook AnalyticsPlatform
- (id)init { return nil; }
+ (id)alloc { return nil; }
%end

%hook AnalyticsAPIClient
- (id)init { return nil; }
%end

%hook SubredditFeedViewController
- (BOOL)hasFetchedCarousel { return YES; }

- (void)shareButtonTapped:(id)sender {
    NSArray *items = @[[NSURL URLWithString:self.subreddit.sharingPermalinkIncludingDomain]];
    UIActivityViewController *share = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    share.excludedActivityTypes = @[UIActivityTypeAirDrop];
    [self presentViewController:share animated:YES completion:nil];
}
%end
