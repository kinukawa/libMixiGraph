//
//  PhotoTestViewController.h
//  libMixiGraph
//
//  Created by kinukawa on 11/05/03.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGPhotoClient.h"

@interface PhotoTestViewController : UIViewController {
    MGPhotoClient * photoClient;
}

-(IBAction)pressGetAlbumButton;

@property (nonatomic,retain) MGPhotoClient * photoClient;
@end
