//
// Testing.xm
// RedditGold
// 
// Created by Tanner Bennett on 2018-10-04
// Copyright © 2018 Tanner Bennett. All rights reserved.
//

#import "Interfaces.h"
#import "../includes/BlockDescription.h"

// %hook RedditService
//  - (void)notifyMissingToken { }
//  - (void)invalidate { }
// %end

// %hook Credentials
// - (id)initWithKeychainAdapter:(id)adapter {
//     return [[%c(MYCredentials) alloc] initWithKeychainAdapter:adapter];
// }

// - (id)initWithIdentifier:(id)identifier {
//     return [[%c(MYCredentials) alloc] initWithIdentifier:identifier];
// }
// %end

// #define SetIvar(target, name, type, value) ({ \
//     Ivar ivar = class_getInstanceVariable(%c(MYCredentials), #name); \
//     object_setIvar(target, ivar, value); \
// })

// %hook MYCredentials

// - (CGFloat)tokenDuration {
//     CGFloat ret = %orig;
//     if (ret > 0.f) {
//         SetIvar(self, "_tokenDuration", CGFloat, @(ret));
//     }

//     return 
// }

// - (void)setTokenString:(id)s {
//     if (s) {
//         %orig;
//     }
// }
// - (void)setRefreshTokenString:(id)s {
//     if (s) {
//         %orig;
//     }
// }
// %end

// %ctor {
//     %init();

//     Class MYCredentials = %c(MYCredentials);
//     #define AddIvar(cls, name, type) class_addIvar(cls, #name, sizeof(type), alignof(type), @encode(type));
//     AddIvar(MYCredentials, _tokenDuration, CGFloat);
//     AddIvar(MYCredentials, _tokenString, NSString *);
//     AddIvar(MYCredentials, _refreshTokenString, NSString *);
//     AddIvar(MYCredentials, _expirationDate, NSDate *);
// }
