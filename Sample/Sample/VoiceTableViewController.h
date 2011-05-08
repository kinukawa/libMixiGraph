//
//  VoiceTableViewController.h
//  Sample
//
//  Created by kinukawa on 11/05/08.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGVoiceClient.h"

@interface VoiceTableViewController : UITableViewController {
    MGVoiceClient * voiceClient;
    NSArray * voiceArray;
}

@property (nonatomic,retain) MGVoiceClient * voiceClient;
@property (nonatomic,retain) NSArray * voiceArray;

@end
