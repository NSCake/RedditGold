//
//  FLEX.xm
//  RedditGold
//  
//  Created by Tanner Bennett on 2021-01-20
//  Copyright © 2021 Tanner Bennett. All rights reserved.
//

#import "Interfaces.h"

%ctor {
    [%c(FLEXShortcutsFactory) replace].properties(@[
        @"post", @"deeplinkURL", @"isSingleCommentThread",
        @"delegator", @"postDelegator", @"navigator", @"feedCollectionNode", @"postDetailPresenter",
    ]).forClass(NSClassFromString(@"PostDetailViewController"));
}
