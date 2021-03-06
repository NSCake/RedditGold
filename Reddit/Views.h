//
//  Views.h
//  Reddit
//  
//  Created by Tanner Bennett on 2020-04-24
//  Copyright © 2020 Tanner Bennett. All rights reserved.
//

@interface HlsPlayerView : UIView
- (void)muteTapped:(id)sender;
@end

@interface BaseBarButtonItem : UIBarButtonItem
+ (instancetype)barButtonItemWithImage:(UIImage *)icon target:(id)target action:(SEL)action;
+ (instancetype)closeButtonWithTarget:(id)target action:(SEL)action;
@end

@interface BaseActionSheetItem : NSObject
- (instancetype)initWithIdentifier:(NSString *)identifier context:(id)context;
@end

@interface UserKarmaAndAgeView : UIView
- (void)configureWithUser:(User *)user;
@end

@interface ChatAvatarImageView : UIImageView
- (void)configureWithUser:(User *)user;
@end

@interface BaseButton : UIButton
@property (readonly) id actionBlock;
- (void)onTapped:(id)actionBlock;
- (void)setAttributedTitleWithString:(NSString *)string;
@end

#pragma mark Comment stuff

@interface LinkKeyboardAccessoryView : NSObject
@property (readonly) BaseButton *linkButton;
@property (readonly) BaseButton *rightButton;
@end

@interface CommentComposeboardAccessoryView : LinkKeyboardAccessoryView
@property (readonly) UIStackView *rightStackView;
@end

@interface BaseAttachmentTextView : UITextView @end

@interface CommentComposeView : UIView
@property (readonly) BaseAttachmentTextView *replyTextView;
@end
