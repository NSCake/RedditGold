//
// NSFW.xm
// RedditGold
// 
// Created by Tanner Bennett on 2018-10-04
// Copyright © 2018 Tanner Bennett. All rights reserved.
//

%hook NSURLSession
- (NSURLSessionDataTask *)dataTaskWithRequest:(NSMutableURLRequest *)request completionHandler:(id)completionHandler {
    if ([request.URL.path containsString:@"subreddits/search.json"]) { // || [request.URL.path containsString:@"search_reddit_names.json"]) {
        if ([request isKindOfClass:[NSMutableURLRequest class]]) {
            NSString *url = request.URL.absoluteString;
            url = [url stringByReplacingOccurrencesOfString:@"&obey_over18=1" withString:@""];
            request.URL = [NSURL URLWithString:[url stringByAppendingString:@"&include_over_18=on"]];
        } else {
            NSLog(@"***\nnot mutable");
        }
    }

    return %orig;
}
%end
