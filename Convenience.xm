//
// Convenience.xm
// RedditGold
// 
// Created by Tanner Bennett on 2018-10-04
// Copyright © 2018 Tanner Bennett. All rights reserved.
//

#import "Interfaces.h"

// Was possibly just called BaseNavigationController at one point?
%hook BaseNavigationViewController
- (void)setModalPresentationStyle:(NSInteger)style {
    %orig(UIModalPresentationPageSheet);
}
%end

%hook HomeViewController
- (NSUInteger)indexOfControllerWithHomeFeedType:(NSUInteger)type {
    return 0;
}

// Removed by at least 2021.19
// - (void)showForYouFeedBadgeIfNeeded { }
%end

// Renamed from CommentCell sometime before 2021.19
// %hook CommentTreeTextNode
// // - (void)_handleMenuGesture { return; }

// - (BOOL)gestureRecognizerShouldBegin:(UILongPressGestureRecognizer *)panGestureRecognizer {
//     return NO;
// }

// - (BOOL)gestureRecognizer:(UIGestureRecognizer *)menuGesture shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGesture {
//     return YES;
// }
// %end

%hook PostDetailPresenter
- (void)fetchMoreContentIfNecessary { }

- (id)createTruncatedCommentNetworkSource {
    return [self createDefaultCommentNetworkSource];
}
%end

@implementation TBMenuItem
+ (instancetype)title:(NSString *)title action:(SEL)action copy:(NSString *)string {
    TBMenuItem *item = [[TBMenuItem alloc] initWithTitle:title action:action];
    item->_storage = string;
    return item;
}
@end

%hook PostDetailViewController

- (void)viewDidLoad {
    %orig;

    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc]
        initWithTarget:self action:@selector(didLongPressComment:)
    ];
    gesture.minimumPressDuration = .2;
    [self.feedCollectionView addGestureRecognizer:gesture];
}

%new
- (void)didLongPressComment:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        CGPoint point   = [gesture locationInView:self.feedCollectionView];
        NSIndexPath *ip = [self.feedCollectionView indexPathForItemAtPoint:point];
        if (!ip) return;

        [self becomeFirstResponder];

        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setTargetRect:CGRectMake(
            point.x - 22, point.y - 22, 44, 44
        ) inView:self.feedCollectionView];

        // 4.3.0
        // Comment *comment = self.commentsManager.flattenedObjects[ip.row];
        Comment *comment = self.delegator.presenter.currentComments[ip.row].comment;

        menu.menuItems = @[
            [TBMenuItem title:@"Text" action:@selector(copyText:) copy:comment.bodyRichTextAttributed.string],
            [TBMenuItem title:@"Source" action:@selector(copySource:) copy:comment.bodyText],
            [TBMenuItem title:@"Link" action:@selector(copyLink:) copy:comment.sharingPermalinkIncludingDomain]
        ];

        [menu update];
        [menu setMenuVisible:YES animated:YES];
    }
}

%new
- (void)copyStorageFromIdx:(NSUInteger)idx of:(UIMenuController *)controller {
    TBMenuItem *item = (id)controller.menuItems[idx];
    [UIPasteboard generalPasteboard].string = item.storage;
}

%new
- (void)copyText:(UIMenuController *)controller {
    [self copyStorageFromIdx:0 of:controller];
}

%new
- (void)copySource:(UIMenuController *)controller {
    [self copyStorageFromIdx:1 of:controller];
}

%new
- (void)copyLink:(UIMenuController *)controller {
    [self copyStorageFromIdx:2 of:controller];
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return action == @selector(copyText:) ||
           action == @selector(copySource:) ||
           action == @selector(copyLink:);
}

- (BOOL)canBecomeFirstResponder { return YES; }

%end

%hook PostActionSheetViewController

// Renamed by 2021.19
// - (id)initOverflowActionSheetWithPost:(Post *)post includeSaveItem:(BOOL)save showFlairItem:(BOOL)flair {
- (id)initWithAccountContext:(id)context post:(Post *)post
     postActionSheetDelegate:(id)delegate
             includeSaveItem:(BOOL)save showFlairItem:(BOOL)flair {
    %orig;

    if (post.isHlsVideo) {
        ActionSheetItem *copy = [[%c(ActionSheetItem) alloc]
            initWithLeftIconImage:[UIImage imageNamed:@"icon_link_20"]
            text:@"Copy media link"
            identifier:@"kCopyMediaLink"
            context:post
        ];
        self.items = [self.items arrayByAddingObject:copy];
    }

    return self;
}

- (void)actionSheetViewController:(id)me didSelectItem:(ActionSheetItem *)item {
    if ([item.identifier isEqualToString:@"kCopyMediaLink"]) {
        NSString *video = [self.post.linkURL.absoluteString stringByAppendingString:@"/HLSPlaylist.m3u8"];
        [UIPasteboard generalPasteboard].string = video;
        [self userDidCancelPopoverView:nil];
    } else {
        %orig;
    }
}

%end

%hook RedditUI.VoteButtonNode
- (id)initWithType:(NSInteger)type overrideTheme:(id)theme shouldUseSmallIcons:(BOOL)smallIcons shouldCenterAlign:(BOOL)center {
    smallIcons = YES;
    return %orig;
}
%end

%hook Reddit.AwardCTAButtonNode
- (id)initWithEconomyContext:(id)context shouldUseSmallIcons:(BOOL)smallIcons presentTooltip:(id)tip action:(id)action {
    smallIcons = YES;
    return %orig;
}
%end

%hook FeedPostCommentBarNode

- (BOOL)shouldUseSmallIcons { return YES; }

// Renamed by 2021.19
// - (id)initWithPost:(Post *)post options:(id)options {
- (id)initWithContext:(id)context post:(Post *)post options:(id)options shouldUseSmallIcons:(BOOL)smallIcons {
    smallIcons = YES;
    self = %orig;

    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc]
        initWithTarget:self action:@selector(__didLongPressActionButton:)
    ];

    [self.actionButtonNode.view addGestureRecognizer:gesture];

    return self;
}

%new
- (void)__didLongPressActionButton:(UIGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [[%c(AccountManager) sharedAccountManager].currentService hidePost:self.post completion:nil];
    }
}

%end
