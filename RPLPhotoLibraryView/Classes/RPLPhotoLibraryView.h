//
//  RPLPhotoLibraryView.h
//  Shimmur
//
//  Created by Benjamin Maer on 3/11/15.
//  Copyright (c) 2015 ShimmurInc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPLPhotoLibraryViewProtocols.h"

@interface RPLPhotoLibraryView : UIView

@property (nonatomic, assign) UICollectionViewFlowLayout* collectionViewFlowLayout;
@property (nonatomic, readonly) UICollectionView* collectionView;
@property (nonatomic, assign) id<RPLPhotoLibraryView_assetSelectionDelegate> assetSelectionDelegate;
@property (nonatomic, assign) id<RPLPhotoLibraryView_scrollDelegate> scrollDelegate;
@property (nonatomic, assign) BOOL reverseAssetOrder;

-(void)scrollToTop:(BOOL)animated;
-(void)loadAssetGroup;

@end
