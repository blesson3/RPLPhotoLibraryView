//
//  RPLViewController.m
//  RPLPhotoLibraryView
//
//  Created by Benjamin Maer on 10/11/2016.
//  Copyright (c) 2016 Benjamin Maer. All rights reserved.
//

#import "RPLViewController.h"

#import <ResplendentUtilities/UIView+RUUtility.h>

#import <RPLPhotoLibraryView/RPLPhotoLibraryView.h>





@interface RPLViewController () <RPLPhotoLibraryView_assetSelectionDelegate>

#pragma mark - selectedImageView
@property (nonatomic, readonly, strong, nullable) UIImageView* selectedImageView;
-(CGRect)selectedImageView_frame;

#pragma mark - photoLibraryView
@property (nonatomic, readonly, strong, nullable) RPLPhotoLibraryView* photoLibraryView;
-(CGRect)photoLibraryView_frame;

@end





@implementation RPLViewController

#pragma mark - UIViewController
-(void)viewDidLoad
{
	[super viewDidLoad];

	[self.view setBackgroundColor:[UIColor whiteColor]];

	[self setEdgesForExtendedLayout:UIRectEdgeNone];

	_selectedImageView = [UIImageView new];
	[self.selectedImageView setBackgroundColor:[UIColor clearColor]];
	[self.selectedImageView setContentMode:UIViewContentModeScaleAspectFill];
	[self.selectedImageView setClipsToBounds:YES];
	[self.view addSubview:self.selectedImageView];

	_photoLibraryView = [RPLPhotoLibraryView new];
	[self.photoLibraryView setAssetSelectionDelegate:self];
	[self.photoLibraryView setBackgroundColor:[UIColor clearColor]];
	[self.view addSubview:self.photoLibraryView];
}

-(void)viewWillLayoutSubviews
{
	[super viewWillLayoutSubviews];

	[self.selectedImageView setFrame:self.selectedImageView_frame];
	[self.photoLibraryView setFrame:self.photoLibraryView_frame];
}

#pragma mark - selectedImageView
-(CGRect)selectedImageView_frame
{
	CGFloat const dimensionLength = 100.0f;

	return CGRectCeilOrigin((CGRect){
		.origin.x		= CGRectGetHorizontallyAlignedXCoordForWidthOnWidth(dimensionLength, CGRectGetWidth(self.view.bounds)),
		.size.width		= dimensionLength,
		.size.height	= dimensionLength,
	});
}

#pragma mark - photoLibraryView
-(CGRect)photoLibraryView_frame
{
	CGRect const selectedImageView_frame = self.selectedImageView_frame;

	return CGRectCeilOrigin(UIEdgeInsetsInsetRect(self.view.bounds, (UIEdgeInsets){
		.top	= CGRectGetMaxY(selectedImageView_frame),
	}));
}

#pragma mark - RPLPhotoLibraryView_assetSelectionDelegate
-(void)photoLibraryView:(RPLPhotoLibraryView*)photoLibraryView didSelectAsset:(ALAsset*)asset
{
	[self.selectedImageView setImage:[UIImage imageWithCGImage:asset.aspectRatioThumbnail]];
}

@end
