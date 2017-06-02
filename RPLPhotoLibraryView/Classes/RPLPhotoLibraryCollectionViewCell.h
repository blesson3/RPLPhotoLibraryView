//
//  RPLPhotoLibraryCollectionViewCell.h
//  Shimmur
//
//  Created by Benjamin Maer on 3/11/15.
//  Copyright (c) 2015 ShimmurInc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface RPLPhotoLibraryCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) ALAsset* asset;

@end
