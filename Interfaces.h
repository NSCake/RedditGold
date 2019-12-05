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


#pragma mark Interfaces

@interface AppSettings : NSObject
+ (NSInteger)defaultFeedMode;
@end

@interface HlsPlayerView : UIView
- (void)muteTapped:(id)sender;
@end

@interface InboxViewController : UIViewController
- (void)locallyMarkAllAsRead;
- (void)actionSheetViewController:(id)controller didSelectItem:(id)item;
@end

@interface BaseBarButtonItem : UIBarButtonItem
+ (instancetype)barButtonItemWithImage:(UIImage *)icon target:(id)target action:(SEL)action;
@end

@interface BaseActionSheetItem : NSObject
- (instancetype)initWithIdentifier:(NSString *)identifier context:(id)context;
@end

@interface Subreddit : NSObject
@property (readonly) NSString *displayName;
// ie all_ads
@property (readonly) NSString *adWhitelistStatus;
@property NSString *sharingPermalinkIncludingDomain;
@end

@interface Post : NSObject
@property BOOL isHlsVideo;
@property NSURL *linkURL;
@property NSString *internalPermalinkIncludingDomain;
@property NSString *sharingPermalinkIncludingDomain;

@property BOOL shouldBlurContent;
@property BOOL hidden;

@property (readonly) NSString *author;
@property (readonly) NSString *title;
@property (readonly) Subreddit *subreddit;

@end

@interface SubredditFeedViewController : UIViewController
@property Subreddit *subreddit;
@end

@interface Section : NSObject
@property UICollectionView *collectionView;
@property UILabel *headerLabel;
@end;

@interface ShareSheetViewController : UIViewController
@property Post *post;
@property NSArray<Section*> *sections;
@property UIButton *linkCopyButton;
@property UIButton *messageButton;
@property UIButton *defaultActionButton;
@property UIStackView *bottomButtonStackView;
@end

@interface ActionSheetItem : NSObject
@property NSString *identifier;
// kActionSheetSaveID
- (id)initWithLeftIconImage:(UIImage *)image text:(NSString *)text identifier:(NSString *)identifier context:(Post *)context;
@end

@interface PostActionSheetViewController : UIViewController
@property NSArray<ActionSheetItem*> *items;
@property Post *post;
- (void)userDidCancelPopoverView:(id)idk;
@end

@interface Comment : NSObject
@property NSString *author;
@property NSString *bodyText;
@property NSAttributedString *bodyAttributedText;
@property NSString *pkWithoutPrefix;
@property NSString *permalink;
@property NSString *linkTitle;
@end

@interface ThreadedObjectManager : NSObject
@property NSArray<Comment*> *flattenedObjects;
@end

@interface CommentsViewController : UIViewController <UICollectionViewDelegate>
@property UICollectionView *feedCollectionView;
@property ThreadedObjectManager *commentsManager;

- (void)copyStorageFromIdx:(NSUInteger)idx of:(UIMenuController *)controller;
@end

@interface TBMenuItem : UIMenuItem
+ (instancetype)title:(NSString *)title action:(SEL)action copy:(NSString *)string;
@property (nonatomic, readonly) NSString *storage;
@end

@interface MainFeedViewController : UIViewController
@property (nonatomic) NSString *configuredURLString;
- (void)configureWithURLString:(NSString *)url;
@end

@interface HomeViewController : UIViewController
@property (nonatomic) NSArray *controllers;
- (void)configureWithControllers:(NSArray *)controllers;

@property (nonatomic) MainFeedViewController *fortnite;
@end

@interface PageSegmentItem : NSObject
@property UILabel *label;
@end

@interface LayoutGuidance : NSObject
@property CGFloat gridPadding;
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
