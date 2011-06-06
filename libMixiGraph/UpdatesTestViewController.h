//
//  UpdatesTestViewController.h
//  libMixiGraph
//
//  Created by kenji.kinukawa on 11/06/06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGUpdatesClient.h"

@interface UpdatesTestViewController : UIViewController {
    MGUpdatesClient * updatesClient;
}

-(IBAction)getMyFeed;

@property (nonatomic, retain) MGUpdatesClient * updatesClient;
@end
