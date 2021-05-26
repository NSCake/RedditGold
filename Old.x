//
//  Old.x
//  RedditGold
//  
//  Created by Tanner Bennett on 2020-04-24
//  Copyright © 2020 Tanner Bennett. All rights reserved.
//

// Old
%hook ShareSheetViewController

- (void)viewWillAppear:(BOOL)animated {
    %orig;

    if (self.sections.count == 2) {
        Section *crossPost = self.sections[0];
        self.sections = @[self.sections[1]];

        [crossPost.collectionView removeFromSuperview];
        [crossPost.headerLabel removeFromSuperview];

        // [self.bottomButtonStackView removeArrangedSubview:self.messageButton];
        // [self.bottomButtonStackView insertArrangedSubview:self.messageButton atIndex:0];

        [self.linkCopyButton setTitle:@"LINK" forState:UIControlStateNormal];
        [self.messageButton setTitle:@"POST LINK" forState:UIControlStateNormal];
        [self.defaultActionButton setTitle:@"SHARE" forState:UIControlStateNormal];
    }
}

- (void)didTapLinkCopyButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [UIPasteboard generalPasteboard].URL = self.post.linkURL;
}

- (void)didTapMessagesActionButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [UIPasteboard generalPasteboard].URL = [NSURL URLWithString:self.post.sharingPermalinkIncludingDomain];
}

%end

%hook FeedViewController
- (void)fetchCarouselDataSourceForDiscoveryModel:(id)model carousel:(id)car withCompletion:(void(^)(id block, BOOL success))original {
    original(nil, NO);
}
%end
