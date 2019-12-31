//
//  Sharing.xm
//  RedditGold
//  
//  Created by Tanner Bennett on 2019-12-30
//  Copyright © 2019 Tanner Bennett. All rights reserved.
//

#import "Interfaces.h"

%hook CopyLinkActivity
- (NSString *)activityTitle {
    return @"Copy Post Link";
}
%end

// Don't append tracking shit to the sharing URL
%hook ShareSheetData
- (NSURL *)shareablePostURL {
    return [NSURL URLWithString:self.post.sharingPermalinkIncludingDomain];
}
%end

%hook ShareSheetPresenter
// Don't include snapchat shit
- (BOOL)ignoreCheckingAppInstallation { return YES; }
// Don't exclude copy/save/etc
- (NSArray *)excludedActivityTypes {
    NSArray *origs = (id)%orig;
    NSMutableSet *excluded = [NSMutableSet setWithArray:origs];

    // Maybe not excluding, but just to be safe
    [excluded removeObject:UIActivityTypeCopyToPasteboard];
    [excluded removeObject:UIActivityTypeSaveToCameraRoll];

    // Why the f is Reddit excluding these?
    [excluded removeObject:UIActivityTypeAddToReadingList];
    [excluded removeObject:@"com.apple.mobilenotes.SharingExtension"];

    return excluded.allObjects;
}
%end

// Don't include post when sharing an image
%hook TheatreViewController
- (void)presentShareActivityController:(TheatreMediaItem *)item image:(UIImage *)image shareOrigin:(NSUInteger)origin sender:(id)sender {
    ShareSheetData *data = [%c(ShareSheetData) dataWithSender:sender analyticsPageType:nil];
    if (image) {
        data.image = image;
    } else {
        data.url = item.originalPost.linkURL;
    }

    [self presentShareViewForData:data];
}
%end

// Don't include image when sharing a post
%hook UIViewController
- (UIActivityViewController *)activityViewControllerForShareData:(ShareSheetData *)data {
    if (data.post) {
        data.image = nil;
    } else if (data.image) {
        return [[UIActivityViewController alloc] initWithActivityItems:@[data.image] applicationActivities:@[]];
    } else if (data.url && !data.post) {
        return [[UIActivityViewController alloc] initWithActivityItems:@[data.url] applicationActivities:@[]];
    }

    return %orig;
}
%end
