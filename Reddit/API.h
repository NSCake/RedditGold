//
//  API.h
//  Reddit
//  
//  Created by Tanner Bennett on 2020-04-24
//  Copyright © 2020 Tanner Bennett. All rights reserved.
//

#pragma mark RedditService
@interface RedditService : NSObject

+ (NSInteger)defaultFeedMode;
- (id)initWithAccount:(Account *)account;
- (void)hidePost:(id)post completion:(id)handler;


@end

#pragma mark AccountManager
@interface AccountManager : NSObject

@property (readonly, class) AccountManager *sharedManager;

@property (readonly) NSURLSession *session;

@property (readonly) Account *currentAccount;
@property (readonly) Account *anonymousAccount;
@property (readonly) NSArray<Account *> *accounts;
@property (readonly) NSArray<Account *> *nonAnonymousAccounts;

@property (readonly) RedditService *currentService;
@property (readonly) RedditService *anonymousService;
@property (readonly) NSArray<RedditService *> *services;

@end

#pragma mark AppSettings
@interface AppSettings : NSObject
+ (NSInteger)defaultFeedMode;
@end
