//
// FeedTabs.xm
// RedditGold
// 
// Created by Tanner Bennett on 2019-06-29
// Copyright © 2018 Tanner Bennett. All rights reserved.
//

#import "Interfaces.h"

static NSSet *kMutedSubreddits = nil;

// Keep case of tab titles, smaller tabs
%hook PageSegmentItem
- (void)setText:(NSString *)text {
    self.label.text = text; // Don't localize it
}
- (CGFloat)minimumWidth { return 40.f; }
%end

// Need to be able to hook this value on the fly
%hook LayoutGuidance
static CGFloat padding = CGFLOAT_MAX;
- (CGFloat)gridPadding {
    if (padding == CGFLOAT_MAX) {
        padding = %orig;
    }

    return padding;
}
%end

// Change `gridPadding` just this once,
// since it is used by tons of things
%hook PageSegmentedControl
- (void)layoutItems {
    padding = 0;
    %orig;
    padding = CGFLOAT_MAX;
}
%end

// My custom tabs

// Modify Popular to be All without politics or news
%hook PopularFeedViewController
- (NSString *)pageItemText { return @"All"; }

- (void)configureWithURLString:(NSString *)url {
    %orig(@"https://reddit.com/r/all");
}

- (void)setCurrentObjects:(NSArray<Post *> *)posts {
    NSPredicate *pred = [NSPredicate predicateWithBlock:^BOOL(Post *post, id bindings) {
        return ![kMutedSubreddits containsObject:post.subreddit.displayName];
    }];
    posts = [posts filteredArrayUsingPredicate:pred];
    %orig;
}
%end

%hook PopularFeedPresenter
- (NSString *)title { return @"All"; }

- (void)configureWithURLString:(NSString *)url {
    %orig(@"https://reddit.com/r/all");
}

// This was removed at some point before 2021.19
// - (void)setCurrentObjects:(NSArray<Post *> *)posts {
// Possibly renamed to `replace`?
- (void)replaceCurrentObjects:(NSArray<Post *> *)posts {
    NSPredicate *pred = [NSPredicate predicateWithBlock:^BOOL(Post *post, id bindings) {
        return ![kMutedSubreddits containsObject:post.subreddit.displayName];
    }];
    posts = [posts filteredArrayUsingPredicate:pred];
    %orig;
}
%end

// These show up in the array of posts, make them respond to -subreddit
%hook Reddit.StreamManager
%new
- (NSString *)subreddit { return nil; }
%end
%hook Carousel
%new
- (NSString *)subreddit { return nil; }
%end

// Use my custom tabs

%hook HomeViewController
// %property (nonatomic, retain) MainFeedViewController *fortnite;

// - (void)viewDidLoad {
//     %orig;

//     self.fortnite = [%c(TBFeedViewController) new];
//     NSMutableArray *tabs = self.controllers.mutableCopy;
//     [tabs addObject:self.fortnite];

//     [self configureWithControllers:tabs];
// }

- (void)setFeedViewControllers:(NSArray *)controllers {
    controllers = @[controllers[1], controllers[2]];
    %orig;
}
%end

%ctor {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kMutedSubreddits = [NSSet setWithArray:@[
            @"politics", @"PoliticalHumor", @"worldpolitics", @"The_Mueller",
            @"news", @"worldnews", @"LateStageCapitalism", @"polandball", @"pics",
            @"PewdiepieSubmissions", @"leagueoflegends", @"BlackPeopleTwitter",
            @"insanepeoplefacebook", @"imsorryjon", @"insaneparents", @"dndmemes",
            @"quityourbullshit", @"freefolk", @"mildlyinteresting", @"AdviceAnimals",
            @"PewdiepieSubmissions", @"iamverysmart", @"ShitPostCrusaders", @"facepalm",
            @"madlads", @"apexlegends", @"rareinsults", @"lotrmemes", @"terriblefacebookmemes",
            @"OurPresident", @"VoteBlue", @"blunderyears", @"SandersForPresident", @"CFB",
            @"JustNeckbeardThings", @"PoliticalCompassMemes", @"MMA", @"niceguys", @"soccer",
            @"TheRightCantMeme", @"ToiletPaperUSA", @"FragileWhiteRedditor", @"badwomensanatomy",
            @"trashy", @"ABoringDystopia", @"blackmagicfuckery", @"NatureIsFuckingLit", @"cringe",
            @"TwoXChromosomes", @"SelfAwarewolves", @"Coronavirus", @"MurderedByWords", @"funny", 
            @"FuckYouKaren", @"WhitePeopleTwitter", @"LeopardsAteMyFace", @"BanVideoGames",
            @"Gamingcirclejerk", @"AnimalCrossing", @"WayOfTheBern", 
        ]];
    });

    %init;
}
