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
    return 3; // Start on Activity tab
}
%end

%hook ChatHomePagedTabViewController

- (NSArray<UIViewController *> *)viewControllersForChatTabs:(NSArray<NSNumber *> *)tabs {
    NSArray<UIViewController *> *controllers = %orig(@[@1, @2, @3]);

    RedditService *service = [%c(AccountManager) sharedManager].currentService;
    InboxViewController *inbox = [[%c(InboxViewController) alloc] initWithService:service];

    // Chat rooms, chats, notifications, mail
    return @[controllers[1], controllers[2], inbox.activityController, inbox.mailController];
}

%end
