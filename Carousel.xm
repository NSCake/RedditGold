//
// Carousel.xm
// RedditGold
// 
// Created by Tanner Bennett on 2018-10-04
// Copyright © 2018 Tanner Bennett. All rights reserved.
//

%hook CarouselFetcher
- (void)fetchCarouselForDiscoveryUnit:(id)unit carousel:(id)car withCompletion:(void(^)(id block, BOOL success))original {
    original(nil, NO);
}
%end

// Old app
%hook FeedViewController
- (void)fetchCarouselDataSourceForDiscoveryModel:(id)model carousel:(id)car withCompletion:(void(^)(id block, BOOL success))original {
    original(nil, NO);
}
%end
