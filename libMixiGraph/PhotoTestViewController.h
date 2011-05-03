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
//最近友人が作成したアルバム一覧の取得
-(IBAction)pressGetRecentCreatedAlbumButton;

@property (nonatomic,retain) MGPhotoClient * photoClient;
@end
