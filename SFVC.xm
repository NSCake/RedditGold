//
// SFVC.xm
// RedditGold
// 
// Created by Tanner Bennett on 2018-10-04
// Copyright © 2018 Tanner Bennett. All rights reserved.
//

@import SafariServices;

%hook SFSafariViewController

- (id)initWithURL:(NSURL *)url configuration:(SFSafariViewControllerConfiguration *)config {
    self.preferredBarTintColor = [UIColor blackColor];
    config.entersReaderIfAvailable = YES;
    return %orig;
}

%end
