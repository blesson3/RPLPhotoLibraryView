//
//  RPLPhotoLibraryViewProtocols.h
//  Shimmur
//
//  Created by Benjamin Maer on 3/11/15.
//  Copyright (c) 2015 ShimmurInc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@class RPLPhotoLibraryView;


@protocol RPLPhotoLibraryView_assetSelectionDelegate <NSObject>

-(void)photoLibraryView:(RPLPhotoLibraryView*)photoLibraryView didSelectAsset:(ALAsset*)asset;

@end


@protocol RPLPhotoLibraryView_scrollDelegate <NSObject>

@optional
-(void)photoLibraryView:(RPLPhotoLibraryView*)photoLibraryView collectionViewWillBeginDragging:(UICollectionView *)collectionView;
-(void)photoLibraryView:(RPLPhotoLibraryView*)photoLibraryView didScrollWithCollectionView:(UICollectionView*)collectionView;
-(void)photoLibraryView:(RPLPhotoLibraryView*)photoLibraryView collectionViewWillEndDragging:(UICollectionView *)collectionView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset;
-(void)photoLibraryView:(RPLPhotoLibraryView*)photoLibraryView collectionViewDidEndDragging:(UICollectionView *)collectionView willDecelerate:(BOOL)decelerate;

@end
