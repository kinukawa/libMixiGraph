//
//  VoiceTestViewController.h
//  libMixiGraph
//
//  Created by kinukawa on 11/04/01.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGVoiceClient.h"
#import "MGVoice.h"

@interface VoiceTestViewController : UIViewController<UITextFieldDelegate> {
    MGVoiceClient * voiceClient;
    UITextField * voiceTextField;
    UITextField * voiceIDTextField;
    MGVoice * testVoice;
    UIImageView * imageView;
    UITextField * commentTextField;
    UIScrollView * scrollView;
    MGComment * testComment;
}
-(IBAction)pressFriendsTestButton;
-(IBAction)pressUsersVoicesTestButton;
-(IBAction)pressVoiceDetailTestButton;
-(IBAction)pressPostVoiceTestButton;
-(IBAction)pressImagePostVoiceTestButton;
-(IBAction)pressDeleteVoiceTestButton;
-(IBAction)pressCommentToVoiceButton;
-(IBAction)pressGetCommentsButton;
-(IBAction)pressDeleteCommentsButton;
-(IBAction)pressGetIineButton;
-(IBAction)pressPostIineButton;
-(IBAction)pressDeelteIineButton;

@property (nonatomic,retain)    MGVoiceClient * voiceClient;
@property (nonatomic,retain)    IBOutlet UITextField * voiceTextField;
@property (nonatomic,retain)    IBOutlet UITextField * voiceIDTextField;
@property (nonatomic,retain)    MGVoice * testVoice;
@property (nonatomic,retain)    MGComment * testComment;
@property (nonatomic,retain)    IBOutlet UIImageView * imageView;
@property (nonatomic,retain)    IBOutlet UITextField * commentTextField;
@property (nonatomic,retain)    IBOutlet UIScrollView * scrollView;
@end
