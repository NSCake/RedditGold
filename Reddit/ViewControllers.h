//
//  ViewControllers.h
//  Reddit
//  
//  Created by Tanner Bennett on 2020-04-24
//  Copyright © 2020 Tanner Bennett. All rights reserved.
//

#pragma mark Reddit's Categories
@interface UIViewController (Reddit)
- (void)presentShareViewForData:(ShareSheetData *)data;
@end

#pragma mark BaseNavigationViewController
@interface BaseNavigationViewController : UINavigationController
@end

#pragma mark ListingViewController
@interface ListingViewController : UIViewController // BaseViewController
- (id)initWithPresenter:(id)presenter;
@end

#pragma mark PagedTabViewControllers

@interface PagedTabViewController : UIViewController
- (void)configureWithControllers:(NSArray<UIViewController *> *)controllers activeControllerIndex:(NSInteger)idx;
@end

@interface HomeViewController : PagedTabViewController
- (void)configureWithControllers:(NSArray *)controllers;
// %new
// @property (nonatomic) MainFeedViewController *fortnite;
@property (readonly) NSArray<UIViewController *> *feedViewControllers;
@end

@interface ChatHomePagedTabViewController : PagedTabViewController
@property (readonly) NSArray<UIViewController *> *controllers;
@property (readonly) RedditService *service;
@end

#pragma mark AppSettingsViewController
@interface AppSettingsViewController : UIViewController
- (id)initWithAccountManager:(AccountManager *)manager;
@end

#pragma mark TheatreViewController
@interface TheatreViewController : UIViewController
@end

#pragma mark RootViewController
@interface RootViewController : UIViewController
+ (void)reloadAllControllers;
@end

#pragma mark MainTabBarController
@interface MainTabBarController : UITabBarController
@end

#pragma mark MainFeedViewController
@interface MainFeedViewController : UIViewController

@property (nonatomic) NSString *configuredURLString;
- (void)configureWithURLString:(NSString *)url;

@end

#pragma mark FeedViewControllerFactory
@interface FeedViewControllerFactory : NSObject
+ (UIViewController *)aggregateHistoryFeedViewControllerWithRedditService:(RedditService *)service;
@end

#pragma mark PostDetailViewController
// Previously called CommentsViewController
@interface PostDetailViewController : UIViewController <UICollectionViewDelegate>
@property UICollectionView *feedCollectionView;
// @property ThreadedObjectManager *commentsManager;
@property (readonly) PostDetailDelegator *delegator;

- (void)copyStorageFromIdx:(NSUInteger)idx of:(UIMenuController *)controller;
@end

#pragma mark SubredditFeedViewController
@interface SubredditFeedViewController : UIViewController
@property Subreddit *subreddit;
@end



#pragma mark InboxViewController
@interface InboxViewController : UIViewController

- (id)initWithService:(RedditService *)service;

@property (readonly) RedditService *service;
@property (readonly) UIViewController *mailController; // MailListViewController
@property (readonly) UIViewController *activityController; // ActivityViewController

- (void)locallyMarkAllAsRead;
- (void)actionSheetViewController:(id)controller didSelectItem:(id)item;
@end

#pragma mark UserDrawerViewController

typedef NS_ENUM(NSUInteger, UserDrawerAction) {
    UserDrawerActionMyProfile = 2,
    UserDrawerActionRedditCoins = 7,
    UserDrawerActionRedditPremium = 6,
    UserDrawerActionSaved = 3,
    UserDrawerActionHistory = 4,
    UserDrawerActionPendingPosts = 5,
    UserDrawerActionDrafts = 8,
    UserDrawerActionCreateCommunity = 1,
};

@interface UserDrawerViewController : UIViewController

- (id)initWithAccountManager:(AccountManager *)manager;

@property (readonly) UIButton *closeButton;
@property (readonly) ChatAvatarImageView *iconImageView;
@property (readonly) AccountManager *accountManager;

@property (readonly) UITableView *actionsTableView;
@property (readonly) NSMutableArray<NSNumber *> *availableUserActions;

- (void)pressedAvatar:(id)sender;

@end

#pragma mark UserProfileViewController
@interface UserProfileViewController : UIViewController
- (id)initWithUsername:(NSString *)username redditService:(RedditService *)service;
@end

#pragma mark Saved
@interface SelectSavedCategoryViewController : UIViewController
- (id)initWithSavedCategoryPresenter:(id)presenter;
@end

@interface SavedTabViewController : UIViewController
- (id)initWithCategoryName:(NSString *)name;
@end

#pragma mark Pending posts
@interface PendingPostsViewController : UIViewController
- (id)initWithService:(RedditService *)service;
@end
