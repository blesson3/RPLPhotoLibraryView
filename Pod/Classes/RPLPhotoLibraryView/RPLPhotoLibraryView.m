//
//  RPLPhotoLibraryView.m
//
//  Created by Benjamin Maer on 3/11/15.
//  Copyright (c) 2015 ShimmurInc. All rights reserved.
//

#import "RPLPhotoLibraryView.h"
#import "RPLPhotoLibraryCollectionViewCell.h"

#import "RUConditionalReturn.h"
#import "RUDLog.h"

#import <AssetsLibrary/AssetsLibrary.h>





NSString* const kRPLPhotoLibraryView_cellIdentifier_RPLPhotoLibraryCollectionViewCell = @"cellIdentifier_RPLPhotoLibraryCollectionViewCell";





@interface RPLPhotoLibraryView () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, readonly) ALAssetsLibrary* assetsLibrary;
@property (nonatomic, assign) BOOL isEnumeratingAssetsLibrary;

@property (nonatomic, strong) ALAssetsGroup* currentAssetsGroup;
-(NSInteger)assetIndexForIndexPath:(NSIndexPath*)indexPath;
-(ALAsset*)assetAtIndexPath:(NSIndexPath*)indexPath;

@property (nonatomic, readonly) UICollectionViewFlowLayout* collectionViewFlowLayout;
@property (nonatomic, readonly) CGFloat collectionViewFlowLayoutItemPadding;
@property (nonatomic, readonly) CGSize collectionViewFlowLayoutItemSize;
@property (nonatomic, readonly) NSUInteger collectionViewFlowLayoutNumberOfColumns;

@property (nonatomic, readonly) UICollectionView* collectionView;
@property (nonatomic, readonly) CGRect collectionViewFrame;

-(void)loadAssetGroup;

@end





@implementation RPLPhotoLibraryView

#pragma mark - UIView
-(instancetype)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame])
	{
		_assetsLibrary = [ALAssetsLibrary new];

		_collectionViewFlowLayout = [UICollectionViewFlowLayout new];
		[self.collectionViewFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
		[self.collectionViewFlowLayout setMinimumInteritemSpacing:0.0f];
		
		_collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectionViewFlowLayout];
		[self.collectionView setDelegate:self];
		[self.collectionView setDataSource:self];
		[self.collectionView registerClass:[RPLPhotoLibraryCollectionViewCell class] forCellWithReuseIdentifier:kRPLPhotoLibraryView_cellIdentifier_RPLPhotoLibraryCollectionViewCell];
		[self.collectionView setBackgroundColor:[UIColor clearColor]];
		[self addSubview:self.collectionView];

		[self loadAssetGroup];
	}

	return self;
}

-(void)layoutSubviews
{
	[super layoutSubviews];

	[self.collectionViewFlowLayout setMinimumLineSpacing:self.collectionViewFlowLayoutItemPadding];
	[self.collectionViewFlowLayout setItemSize:self.collectionViewFlowLayoutItemSize];
	[self.collectionView setFrame:self.collectionViewFrame];
}

#pragma mark - Frames
-(CGFloat)collectionViewFlowLayoutItemPadding
{
	return 4.0f;
}

-(NSUInteger)collectionViewFlowLayoutNumberOfColumns
{
	return 3.0f;
}

-(CGSize)collectionViewFlowLayoutItemSize
{
	CGFloat collectionViewFlowLayoutItemPadding = self.collectionViewFlowLayoutItemPadding;
	NSUInteger collectionViewFlowLayoutNumberOfColumns = self.collectionViewFlowLayoutNumberOfColumns;
	CGFloat collectionViewFlowLayoutNumberOfColumns_float = collectionViewFlowLayoutNumberOfColumns;
	CGRect collectionViewFrame = self.collectionViewFrame;
	
	CGFloat itemDimensionLength = (CGRectGetWidth(collectionViewFrame) - ((collectionViewFlowLayoutNumberOfColumns_float - 1) * collectionViewFlowLayoutItemPadding)) / collectionViewFlowLayoutNumberOfColumns_float;
	
	return (CGSize){
		.width		= itemDimensionLength,
		.height		= itemDimensionLength,
	};
}

-(CGRect)collectionViewFrame
{
	return self.bounds;
}

#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.currentAssetsGroup.numberOfAssets;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	RPLPhotoLibraryCollectionViewCell* photoLibraryCollectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:kRPLPhotoLibraryView_cellIdentifier_RPLPhotoLibraryCollectionViewCell forIndexPath:indexPath];
	[photoLibraryCollectionViewCell setAsset:[self assetAtIndexPath:indexPath]];
	
	return photoLibraryCollectionViewCell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	[self.assetSelectionDelegate photoLibraryView:self didSelectAsset:[self assetAtIndexPath:indexPath]];
}

#pragma mark - Load Asset Group
-(void)loadAssetGroup
{
	kRUConditionalReturn(self.isEnumeratingAssetsLibrary, YES);

	[self setIsEnumeratingAssetsLibrary:YES];

	__block BOOL stopped = NO;
	__weak typeof(self) weakSelf = self;
	[self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {

		*stop = YES;

		if ((stopped == false) && (*stop == YES))
		{
			stopped = YES;
			if (weakSelf)
			{
				dispatch_async(dispatch_get_main_queue(), ^{
					if (weakSelf)
					{
						[weakSelf setIsEnumeratingAssetsLibrary:NO];
						[weakSelf setCurrentAssetsGroup:group];
					}
				});
			}
		}
		
	} failureBlock:^(NSError *error) {
		RUDLog(@"error: %@",error);
	}];
}

#pragma mark - currentAssetsGroup
-(void)setCurrentAssetsGroup:(ALAssetsGroup *)currentAssetsGroup
{
	kRUConditionalReturn(self.currentAssetsGroup == currentAssetsGroup, NO);

	if (currentAssetsGroup)
	{
		[currentAssetsGroup setAssetsFilter:[ALAssetsFilter allPhotos]];
	}

	_currentAssetsGroup = currentAssetsGroup;

	[self.collectionView reloadData];
}

#pragma mark - Data Source
-(NSInteger)assetIndexForIndexPath:(NSIndexPath*)indexPath
{
	NSInteger index = indexPath.row;

	NSInteger numberOfAssets = self.currentAssetsGroup.numberOfAssets;
	kRUConditionalReturn_ReturnValue(numberOfAssets == 0, YES, NSNotFound);
	kRUConditionalReturn_ReturnValue(index >= numberOfAssets, YES, NSNotFound);

	if (self.reverseAssetOrder)
	{
		index = numberOfAssets - 1 - index;
	}

	return index;
}

-(ALAsset*)assetAtIndexPath:(NSIndexPath*)indexPath
{
	kRUConditionalReturn_ReturnValueNil(self.currentAssetsGroup == nil, YES);

	NSInteger index = [self assetIndexForIndexPath:indexPath];
	kRUConditionalReturn_ReturnValueNil((index >= self.currentAssetsGroup.numberOfAssets), YES);
	
	__block ALAsset* asset = nil;
	
	[self.currentAssetsGroup enumerateAssetsAtIndexes:[NSIndexSet indexSetWithIndex:index] options:NSEnumerationConcurrent usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
		if (result)
		{
			asset = result;
			*stop = YES;
		}
	}];
	
	return asset;
}

#pragma mark - Scrolling
-(void)scrollToTop:(BOOL)animated
{
	[self.collectionView setContentOffset:CGPointZero animated:animated];
}

#pragma mark - reverseAssetOrder
-(void)setReverseAssetOrder:(BOOL)reverseAssetOrder
{
	kRUConditionalReturn(self.reverseAssetOrder == reverseAssetOrder, NO);

	_reverseAssetOrder = reverseAssetOrder;

	[self.collectionView reloadData];
}

@end
