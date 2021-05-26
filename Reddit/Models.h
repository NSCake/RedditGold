//
//  Models.h
//  Reddit
//  
//  Created by Tanner Bennett on 2020-04-24
//  Copyright © 2020 Tanner Bennett. All rights reserved.
//

@interface User : NSObject
@property (readonly) NSString *username; // Original username
@property (readonly) NSString *title; // User chosen display name
@property (readonly) NSString *headerTitle; // ie u/Username
@property (readonly) NSString *descriptionText;
@property (readonly) NSString *publicDescriptionText;
@property (readonly) NSString *subscribersCount;
@property (readonly) NSDate *createdAt;
@property (readonly) BOOL isEmployeeUser;
@property (readonly) BOOL hasPremium;
@property (readonly) NSString *sharingPermalinkIncludingDomain;
@end

@interface Account : NSObject
@property (readonly, getter=isNotLoggedIn) BOOL notLoggedIn;
@property (readonly, getter=isLoggedIn) BOOL loggedIn;
@property (readonly) User *user;
@end

@interface AppFlowCoordinator : NSObject
@property (readonly, class) AppFlowCoordinator *instance;

- (void)didChangeUser:(User *)user;
@end

@interface Subreddit : NSObject
@property (readonly) NSString *displayName;
// ie all_ads
@property (readonly) NSString *adWhitelistStatus;
@property NSString *sharingPermalinkIncludingDomain;
@end

// Usually external
@interface VideoMedia : NSObject
@property NSString *embedHTML;
@property CGSize size;
@property NSURL *url;
@end

// Always a reddit-hosted video
@interface StreamingMedia : NSObject
@property NSURL *hlsURL;
@property BOOL isGIF;
@property CGSize size;
@end

@interface Media : NSObject
@property BOOL hasLargeAssets;
@property NSString *mediaId;
@property id /* StillMedia */ still;
@property id /* AnimatedMedia */ animated;
@property StreamingMedia *streaming;
// Original URL for external media like gfycat
@property VideoMedia *video;
@end

@class RichText;
@interface Post : NSObject
@property BOOL isHlsVideo;
@property BOOL isHlsGif;
@property BOOL isIngestedGif;
@property NSURL *linkURL; // Note: original URL of media, if any
@property NSString *internalPermalinkIncludingDomain;
@property NSString *sharingPermalinkIncludingDomain;
@property NSString *domain;
@property NSString *selfText;

@property BOOL shouldBlurContent;
@property BOOL isHidden;

@property NSString *author;
@property NSString *title;
@property Subreddit *subreddit;
@property Media *media;

@property NSString *selfPostText;
@property NSAttributedString *selfPostRichTextAttributed;
@property RichText *selfPostRichText;
@end

@interface Comment : NSObject
@property NSString *author;
@property NSString *bodyText;
// @property NSAttributedString *bodyAttributedText;
@property NSAttributedString *bodyRichTextAttributed;
@property NSString *pkWithoutPrefix;
@property NSString *sharingPermalinkIncludingDomain;
@property NSString *permalink;
@property NSString *linkTitle;
@end

// Actually mangled swift name
@interface PostShareContext : NSObject
@property (readonly) Post *post;
@end

@interface ShareSheetData : NSObject
+ (instancetype)dataWithSender:(id)sender analyticsPageType:(NSString *)type;
@property (readonly) NSURL *shareablePostURL;
@property UIImage *image;
@property PostShareContext *postShareContext;
@property NSURL *url;
@end

@interface TheatreMediaItem : NSObject
@property NSString *author;
@property NSString *shortDomain; // ie gfycat
@property NSURL *contentURL;
@property NSDate *createdAt;
@property BOOL isGif;
@property BOOL isHlsVideo; // isVideo is also YES
@property BOOL isImage;
@property BOOL isNSFW;
@property BOOL isSpoiler;
@property BOOL isVideo;
@property NSString *mediaId;
@property NSString *title;
@property Subreddit *subreddit;
@property Post *originalPost;
@property NSUInteger postType;
@end

@interface PageSegmentItem : NSObject
@property UILabel *label;
@end

@interface LayoutGuidance : NSObject
@property CGFloat gridPadding;
@end

@interface ThreadedObjectManager : NSObject
@property NSArray<Comment*> *flattenedObjects;
@end

@interface RichTextConfig : NSObject
@property (readonly, class) RichTextConfig *currentConfig;
@end

@interface RichTextElementBase : NSObject
- (id)attributedStringWithConfig:(RichTextConfig *)config;
@end

@interface RichText : NSObject
@property (readonly) NSArray<RichTextElementBase *> *elements;
- (id)attributedStringWithConfig:(RichTextConfig *)config;
@end
