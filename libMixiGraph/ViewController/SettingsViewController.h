//
//  SettingsViewController.h
//  libMixiGraph
//
//  Created by kenji.kinukawa on 11/03/30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGOAuthClient.h"

@interface SettingsViewController : UIViewController {
    MGOAuthClient * oauthClient;
}

@end
