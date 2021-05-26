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
    // self.preferredBarTintColor = [UIColor blackColor];
    config.entersReaderIfAvailable = YES;
    return %orig;
}

%end

%hook RichTextDisplayNode
// The atRange part was added at least by 2021.19
- (void)richTextTextNode:(id)node didTapURL:(NSURL *)url atPoint:(CGPoint)point atRange:(NSRange)range {
    NSString *domain = url.host;
    BOOL isGithub = [domain hasSuffix:@"github.com"] && ![domain containsString:@"gist.github.com"];
    if ([domain hasSuffix:@"youtube.com"] || [domain hasSuffix:@"youtu.be"] ||
        [domain hasSuffix:@"twitter.com"] || isGithub) {
        [UIApplication.sharedApplication openURL:url];
    } else {
        %orig;
    }
}
%end
