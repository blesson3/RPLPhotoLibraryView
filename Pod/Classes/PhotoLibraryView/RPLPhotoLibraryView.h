//
//  RPLPhotoLibraryView.h
//  Shimmur
//
//  Created by Benjamin Maer on 3/11/15.
//  Copyright (c) 2015 ShimmurInc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RPLPhotoLibraryView/RPLPhotoLibraryViewProtocols.h>





@interface RPLPhotoLibraryView : UIView

@property (nonatomic, assign) id<RPLPhotoLibraryView_assetSelectionDelegate> assetSelectionDelegate;

-(void)scrollToTop:(BOOL)animated;

@end
