//
//  OAuthLoginViewController.h
//  Sample
//
//  Created by kinukawa on 11/05/08.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGOAuthClient.h"

@interface OAuthLoginViewController : UIViewController {
    MGOAuthClient * oauthClient;
}

@property (nonatomic,retain) MGOAuthClient * oauthClient;

@end
