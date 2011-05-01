//
//  PeopleTestViewController.h
//  libMixiGraph
//
//  Created by kinukawa on 11/05/01.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGPeopleClient.h"

@interface PeopleTestViewController : UIViewController {
    MGPeopleClient * peopleClient;
}
-(IBAction)pressMyFriendsButton;
-(IBAction)pressMyProfileButton;

@property (nonatomic,retain)    MGPeopleClient * peopleClient;

@end
