//
//  TabBarItems.xm
//  RedditGold
//  
//  Created by Tanner Bennett on 2020-04-24
//  Copyright © 2020 Tanner Bennett. All rights reserved.
//

#import "Interfaces.h"

%hook MainTabBarController

- (void)setViewControllers:(NSMutableArray<UIViewController *> *)controllers {
    // Create the new last tab
    UIViewController *userDrawer = [[%c(UserDrawerViewController) alloc]
        initWithAccountContext:self.accountContext
    ];

    // Replace the last tab
    NSMutableArray<UIViewController *> *tabs = controllers.mutableCopy;
    [tabs removeLastObject];
    [tabs addObject:[[%c(BaseNavigationViewController) alloc]
        initWithRootViewController:userDrawer
    ]];

    // Set the tab bar icon to a cake icon
    UITabBarItem *item = tabs.lastObject.tabBarItem;
    item.imageInsets = tabs.firstObject.tabBarItem.imageInsets;
    item.image = item.selectedImage = [UIImage imageNamed:@"icon_cake_24"];

    // Add long press gesture recognizer to middle tab bar item
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc]
        initWithTarget:userDrawer action:@selector(pressedSignUpOrLogInButton:)
    ];
    gesture.minimumPressDuration = .2;
    [self.postButton addGestureRecognizer:gesture];
    
    %orig(tabs);
}

%end

%hook UserDrawerViewController

// Make the drawer full screen width
+ (CGFloat)panelWidth {
    return UIScreen.mainScreen.bounds.size.width;
}

// Remove some useless actions
- (NSMutableArray *)availableUserActions {
    NSMutableArray<NSNumber *> *actions = %orig;
    [actions removeObject:@(UserDrawerActionRedditCoins)];
    [actions removeObject:@(UserDrawerActionRedditPremium)];
    return actions;
}

- (void)viewDidLoad {
    %orig;

    if (self.tabBarController) {
        self.closeButton.hidden = YES;

        // Experimental: set the tab bar icon to my avatar
        // UITabBarItem *item = self.navigationController.tabBarItem;
        // UIImage *icon = [self.iconImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        // icon = [icon imageScaledToSize:CGSizeMake(24, 24)];
        // item.image = icon;
        // item.selectedImage = icon;
    }
}

- (void)pressedAvatar:(id)sender {
    if (self.tabBarController) {
        // Push profile
        [self.navigationController pushViewController:[[%c(UserProfileViewController) alloc]
            initWithUsername:self.accountManager.currentService.account.user.username
            accountContext:self.accountContext
            analyticsReferrerInfo:nil
        ] animated:YES];
    } else {
        %orig;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.tabBarController) {
        %orig;
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *toPush = nil;
    
    if (tableView == self.actionsTableView) {
        switch (self.availableUserActions[indexPath.row].unsignedIntegerValue) {
            case UserDrawerActionMyProfile:
                [self pressedAvatar:nil];
                break;
            case UserDrawerActionRedditCoins:
                // lol
                break;
            case UserDrawerActionRedditPremium:
                // looool
                break;
            case UserDrawerActionSaved:
                toPush = [[%c(SavedTabViewController) alloc] initWithCategoryName:nil];
                break;
            case UserDrawerActionHistory:
                toPush = [%c(FeedViewControllerFactory)
                    aggregateHistoryFeedViewControllerWithAccountContext:self.accountContext
                ];
                break;
            case UserDrawerActionPendingPosts:
                toPush = [[%c(Reddit.PendingPostsViewController) alloc]
                    initWithAccountContext:self.accountContext
                ];
                break;
            case UserDrawerActionDrafts:
                // Previously without the `Reddit.`
                toPush = [[%c(Reddit.DraftsListViewController) alloc]
                    initWithAccountContext:self.accountContext
                ];
                break;
            case UserDrawerActionCreateCommunity:
                
                break;
        }

        if (toPush) {
            [self.navigationController pushViewController:toPush animated:YES];
        }
    } else {
        // Present settings
        AppSettingsViewController *settings = [[%c(AppSettingsViewController) alloc]
            initWithAccountManager:self.accountManager
        ];
        settings.navigationItem.leftBarButtonItem = [%c(BaseBarButtonItem)
            closeButtonWithTarget:settings action:NSSelectorFromString(@"didTapCloseButton:")
        ];
        BaseNavigationViewController *nav = [[%c(BaseNavigationViewController) alloc]
            initWithRootViewController:settings
        ];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }
}

%end

%hook Reddit.AccountStatusViewController
// Used to be in UserDrawerViewController
- (void)actionSheetViewController:(id)sheet didSelectSwitchToAccount:(id)account {
    %orig;
    [%c(RootViewController) reloadAllControllers];
}
%end
