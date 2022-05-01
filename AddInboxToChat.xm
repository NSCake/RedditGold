//
//  AddInboxToChat.xm
//  RedditGold
//  
//  Created by Tanner Bennett on 2020-04-22
//  Copyright © 2020 Tanner Bennett. All rights reserved.
//

#import "Interfaces.h"

%hook AccountSettings
- (NSInteger)lastChatTabPage {
    return 2; // Start on Activity tab, broken
}
%end

%hook ChatHomePagedTabViewController

- (NSArray<UIViewController *> *)viewControllersForChatTabs:(NSArray<NSNumber *> *)tabs {
    NSArray<UIViewController *> *controllers = %orig(@[/* @1, */ @2, /* @3 */]); // Chat rooms were removed

    // RedditService *service = [%c(AccountManager) sharedAccountManager].currentService;
    InboxViewController *inbox = [[%c(InboxViewController) alloc] initWithAccountContext:self.accountContext];

    // Chat rooms, chats, notifications, mail
    return @[controllers[0], inbox.activityController, inbox.mailController];
}

%end
