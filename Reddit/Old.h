//
//  Old.h
//  Reddit
//  
//  Created by Tanner Bennett on 2020-04-24
//  Copyright © 2020 Tanner Bennett. All rights reserved.
//

@interface Section : NSObject
@property UICollectionView *collectionView;
@property UILabel *headerLabel;
@end

@interface ShareSheetViewController : UIViewController
@property Post *post;
@property NSArray<Section*> *sections;
@property UIButton *linkCopyButton;
@property UIButton *messageButton;
@property UIButton *defaultActionButton;
@property UIStackView *bottomButtonStackView;
@end
