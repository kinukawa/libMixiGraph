//
//  PhotoTableViewController.h
//  Sample
//
//  Created by kinukawa on 11/05/08.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGPhotoClient.h"

@interface PhotoTableViewController : UITableViewController {
    MGPhotoClient * photoClient;
}

@property (nonatomic,retain) MGPhotoClient * photoClient;
@property (nonatomic,retain) NSArray * photoArray;

@end
