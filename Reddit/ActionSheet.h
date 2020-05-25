//
//  ActionSheet.h
//  Reddit
//  
//  Created by Tanner Bennett on 2020-04-24
//  Copyright © 2020 Tanner Bennett. All rights reserved.
//

// No longer exists
@interface ActionSheetItem : NSObject
@property NSString *identifier;
// kActionSheetSaveID
- (id)initWithLeftIconImage:(UIImage *)image text:(NSString *)text identifier:(NSString *)identifier context:(Post *)context;
@end

@interface PostActionSheetViewController : UIViewController

- (void)userDidCancelPopoverView:(id)idk; // No longer exists
@property NSArray<ActionSheetItem*> *items; // No longer exists

@property Post *post;
@end
