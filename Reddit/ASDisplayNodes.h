//
//  ASDisplayNodes.h
//  Reddit
//  
//  Created by Tanner Bennett on 2020-04-24
//  Copyright © 2020 Tanner Bennett. All rights reserved.
//

@protocol AccountContext;

@interface ASDisplayNode : NSObject
@property (readonly) UIView *view;
@end

@interface FeedPostCommentBarNode : ASDisplayNode
@property (readonly) UIViewController *delegate;
@property (readonly) Post *post;
@property ASDisplayNode *actionButtonNode;
@end

@interface CommentTreeNode : NSObject
@property (readonly) Comment *comment;
@end

#pragma mark Presenters

@interface ListingPresenter : NSObject
@property (readonly) id<AccountContext> accountContext;
@end

@interface FeedPresenter : ListingPresenter
@end

@interface PostDetailPresenter : ListingPresenter
@property (readonly) NSArray<CommentTreeNode *> *currentComments;
- (id)createTruncatedCommentNetworkSource;
- (id)createDefaultCommentNetworkSource;
@end

@interface PostDetailDelegator : NSObject
@property (readonly) PostDetailPresenter *presenter;
@end

@interface SavedCategoryPresenter : ListingPresenter
- (id)initWithService:(RedditService *)service;
@end

@interface TheatreFeedPresenter : FeedPresenter
@property (nonatomic) NSArray<TheatreMediaItem *> *currentMediaObjects;
@end
