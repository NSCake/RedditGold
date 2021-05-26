//
//  Tweak.xm
//  RedditGold
//
//  Created by Tanner Bennett on 2017-08-11
//  Copyright © 2017 Tanner Bennett. All rights reserved.
//

#import "Interfaces.h"

%hook AccountManager
%new
+ (id)sharedAccountManager {
    static AccountManager *shared = nil;
    if (!shared) {
        if ([self respondsToSelector:@selector(sharedManager)]) {
            shared = (id)[self sharedManager];
        } else {
            shared = [(AppDelegate *)UIApplication.sharedApplication.delegate accountManager];
        }
    }
    
    return shared;
}
%end

// Prevent app from crashing in the background on iOS 13
// %hook UIApplication
// - (UIBackgroundTaskIdentifier)beginBackgroundTaskWithExpirationHandler:(void (^)(void))handler {
//     return UIBackgroundTaskInvalid;
// }

// - (UIBackgroundTaskIdentifier)beginBackgroundTaskWithName:(NSString *)taskName expirationHandler:(void (^)(void))handler {
//     return UIBackgroundTaskInvalid;
// }
// %end

// Disable analytics
%hook AnalyticsManager
- (void)logAnalyticsEvent:(id)event { }
- (void)logAnalyticsEvents:(id)event { }
- (void)logEvent:(id)event { }
- (void)logEvents:(id)event { }
%end

%hook Account
- (BOOL)shouldIgnoreSuggestedCommentSort { return YES; }
%end

%hook SearchViewController
- (id)searchTermBlacklist { return @[]; }
%end
%hook ConfigManager
- (id)searchTermBlacklist { return @[]; }
%end

%hook UITabBarItem
- (void)setBadgeValue:(id)value { %orig(nil); }
%end

%hook Post
- (BOOL)spoiler { return NO; } // Gone by at least 2021.19
- (BOOL)isSpoiler { return NO; } // Added with v1.3.0
%end
%hook TheatreMediaItem
- (BOOL)isSpoiler { return NO; } // Added with v1.3.0
%end
%hook FeedPostOptions
- (BOOL)shouldAlwaysShowSpoilerContent { return YES; } // Added with v1.3.0
%end

%hook Subreddit
- (BOOL)quarantined { return NO; }
%end
%hook SearchCommunitySubreddit
- (BOOL)isQuarantined { return NO; } // Added with v1.3.0
%end

@interface FakeCoinContainer : UIView @end
@implementation FakeCoinContainer
- (void)setStorefrontOffer:(NSUInteger)offer { }
@end

%hook MainTabBarController
- (id)coinSaleNavigationButton { return [UIBarButtonItem new]; } // Gone by at least 2021.19
- (id)coinSaleContainer { return [FakeCoinContainer new]; } // Added with v1.3.0
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

// Gone by at least 2021.19
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

/// Used to be SubredditFeedViewController sometime before 2021.19
%hook SubredditPageViewController
// Gone by at least 2021.19
// - (BOOL)hasFetchedCarousel { return YES; }

- (void)shareButtonTapped:(id)sender {
    NSArray *items = @[[NSURL URLWithString:self.subreddit.sharingPermalinkIncludingDomain]];
    UIActivityViewController *share = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    share.excludedActivityTypes = @[UIActivityTypeAirDrop];
    [self presentViewController:share animated:YES completion:nil];
}
%end

/// Disable RPAN
%hook StreamingUnitDataProvider
- (BOOL)shouldHideUnit { return YES; }
%end

/// Disable ads
%hook AdPost
- (void)setIsBlankAd:(BOOL)blank { %orig(YES); }
%end
%hook PostDetailOptions
- (BOOL)disableAdsInComments { return YES; }
%end

/// Disable carousels
%hook DiscoveryUnit
- (BOOL)enabled { return NO; }
%end
// %hook AnyTypeCarouselDataSource
// + (id)alloc { return nil; }
// %end

/// Disable stupid award highlights
%hook Comment
- (NSInteger)awardHighlight { return 0; }
- (BOOL)shouldHighlightForHighAward { return NO; }
- (NSURL *)profileImageURL { return nil; }
%end

/// Disable avatars
%hook Reddit.CommentAvatarNode
- (CGSize)preferredSize { return CGSizeZero; }

- (id)initWithComment:(Comment *)comment shouldShowPlaceholderAvatar:(BOOL)showPlaceholder
                                       isDefaultAvatarPictureEnabled:(BOOL)defaultAviEnabled
                                          isPresenceIndicatorEnabled:(BOOL)onlineStatusEnabled
                                                        isUserOnline:(BOOL)userOnline {
    return %orig(comment, NO, NO, NO, NO);
}
%end

%hook RedditCore.ExperimentManager
- (BOOL)isAvatarsInCommentsEnabled { return NO; }
- (BOOL)isEconAvatarNativeBuilderEnabled { return NO; }
- (void)exposeAvatarsInComments { }
%end
%hook CommentTreeNodeHeaderOptions
- (BOOL)shouldEnableAvatars { return NO; }
- (BOOL)shouldShowPlaceholderAvatar { return NO; }
%end
%hook PostDetailPresenter
- (BOOL)shouldEnableAvatarsForComment:(id)comment { return NO; }
- (BOOL)shouldShowPlaceholderAvatarForComment:(id)comment { return NO; }
%end
// %hook Reddit.CommentTreeHeaderTwoLineNode

// %end

%hook ChatSkeletonElementViewStyle
- (CGFloat)avatarSize { return 16; }
%end
