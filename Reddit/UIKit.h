//
//  UIKit.h
//  Reddit
//  
//  Created by Tanner Bennett on 2021-02-08
//  Copyright © 2021 Tanner Bennett. All rights reserved.
//

@interface UIControlTargetAction : NSObject {
    id _target;
    SEL _action;
}
@end

// @interface UIControl (Private) {
//     NSMutableArray *_targetActions;
// }
// @end

@interface UIButton (Private)
- (void)setTitle:(NSString *)title;
@property (readonly) NSArray<UIControlTargetAction *> *_allTargetActions;
@end
