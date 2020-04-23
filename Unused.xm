//
// Unused.xm
// RedditGold
// 
// Created by Tanner Bennett on 2018-10-04
// Copyright © 2018 Tanner Bennett. All rights reserved.
//

%hook AccountManager
- (void)removeAccount:(NSInteger)account deletingAccountData:(NSInteger)data { }
%end

// %hook CarouselFetcher
// - (void)fetchCarouselForDiscoveryUnit:(id)unit carousel:(id)car withCompletion:(void(^)(id block, BOOL success))original {
//     original = [original copy];
//     void (^completion)(id, BOOL) = ^void(id block, BOOL success) {
//         BlockDescription *desc = [BlockDescription describing:[block copy]];
//         NSLog(@"***\n\nInner block:\n%@", desc.blockSignature.debugDescription);
//         original([block copy], success);
//     };

//     %orig(unit, car, [completion copy]);
// }
// %end

// %hook UIImage

// + (id)imageNamed:(NSString *)name {
//     if ([name hasPrefix:@"icon"]) {
//         NSLog(@"***\n%@", name);
//     }

//     return %orig;
// }

// %end

// %hook InboxViewController

// - (void)setupNavBarItems {
//     %orig;
//     UIImage *readIcon = [UIImage imageNamed:@"icon_mark_read_20"];
//     UIImage *composeIcon = [UIImage imageNamed:@"icon_edit_20"];
//     UIBarButtonItem *read = [%c(BaseBarButtonItem)
//         barButtonItemWithImage:readIcon
//         target:self
//         action:@selector(locallyMarkAllAsRead)
//     ];
//     UIBarButtonItem *compose = [%c(BaseBarButtonItem)
//         barButtonItemWithImage:composeIcon
//         target:self
//         action:@selector(_compose_)
//     ];
//     self.navigationItem.rightBarButtonItems = @[read, compose];
// }

// %new
// - (void)_compose_ {
//     id item = [[%c(BaseActionSheetItem) alloc] initWithIdentifier:@"kComposeMessage" context:nil];
//     [self actionSheetViewController:nil didSelectItem:item];
// }

// %end

// %hook NSURLSessionConfiguration

// + (NSURLSessionConfiguration *)backgroundSessionConfigurationWithIdentifier:(NSString *)identifier {
//     return [self defaultSessionConfiguration];
// }

// - (BOOL)_supportsAVAssetDownloads {
//     return YES;
// }

// %end
