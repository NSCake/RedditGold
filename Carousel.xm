//
// Carousel.xm
// RedditGold
// 
// Created by Tanner Bennett on 2018-10-04
// Copyright © 2018 Tanner Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>

%hook Carousel
- (BOOL)isHiddenByUserWithAccountSettings:(id)settings {
    return YES;
}
%end
