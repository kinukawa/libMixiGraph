//
//  VoiceTestViewController.m
//  libMixiGraph
//
//  Created by kinukawa on 11/04/01.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VoiceTestViewController.h"


@implementation VoiceTestViewController
@synthesize voiceClient;
@synthesize voiceTextField;
@synthesize voiceIDTextField;
@synthesize testVoice;
@synthesize imageView;
@synthesize commentTextField;
@synthesize scrollView;
@synthesize testComment;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    self.voiceClient = nil;
    [super dealloc];
}

////////////Views Methods////////////////////////////////////////////////
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.voiceClient = [[[MGVoiceClient alloc]init]autorelease];
    self.voiceClient.delegate = self;
    
    self.voiceTextField.delegate = self;
    self.voiceIDTextField.delegate = self;
    self.commentTextField.delegate = self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/////////////IBActions/////////////////////////////////
-(IBAction)pressUsersVoicesTestButton{
    
    //voiceClient.identifier = @"pressUsersVoicesTestButton";
    [voiceClient getUserVoicesByUserID:@"@me" trimUser:NO attachPhoto:YES startIndex:@"0" count:@"0" identifier:@"pressUsersVoicesTestButton"];
    //[voiceClient requestUserVoicesByUserID:@"bgbj9n8rtg3wc" trimUser:NO attachPhoto:YES startIndex:nil count:nil usingSinceId:@"bgbj9n8rtg3wc-20110408225707"];
}

-(IBAction)pressFriendsTestButton{
    
    //voiceClient.identifier = @"pressFriendsTestButton";
    [voiceClient getFriendsVoicesByGroupID:nil trimUser:NO attachPhoto:YES startIndex:nil count:nil identifier: @"pressFriendsTestButton"];
}

-(IBAction)pressVoiceDetailTestButton{
    //voiceClient.identifier = @"pressVoiceDetailTestButton";
    [voiceClient getVoiceInfoByPostID:testVoice.postId trimUser:NO attachPhoto:YES identifier:@"pressVoiceDetailTestButton"];
}

-(IBAction)pressPostVoiceTestButton{
    //voiceClient.identifier = @"post";
    [voiceClient postVoice:@"ほげふが+++" identifier:@"post"];
}
-(IBAction)pressImagePostVoiceTestButton{
    //voiceClient.identifier = @"post";
    [voiceClient postVoice:@"ほげふが+++" withUIImage:imageView.image identifier:@"post"];
}

-(IBAction)pressDeleteVoiceTestButton{
    //testVoice.identifier = @"delete";
    [testVoice deleteVoice:@"delete"];
}

-(IBAction)pressCommentToVoiceButton{
    //self.testVoice.identifier = @"postComment";
    [self.testVoice postComment:@"ほげふが++" identifier:@"postComment"];
}

-(IBAction)pressGetCommentsButton{
    //self.testVoice.identifier = @"getComments";
    [self.testVoice getCommentsWithStartIndex:0 count:0 identifier:@"getComments"];
}

-(IBAction)pressDeleteCommentsButton{
    //self.testVoice.identifier = @"deleteComments";
}

-(IBAction)pressGetIineButton{
    //self.testVoice.identifier = @"getIine";
    [self.testVoice getFavoritesWithStartIndex:0 count:0 identifier:@"getIine"];
}
-(IBAction)pressPostIineButton{
    //self.testVoice.identifier = @"postIine";
    [self.testVoice postFavorite:@"postIine"];
}
-(IBAction)pressDeelteIineButton{
    //self.testVoice.identifier=@"deleteIine";
    [self.testVoice deleteFavoriteByUserId:@"xweichp9oy7nb" identifier:@"deleteIine"];
}


/////////////voiceClientDelegate methods/////////////////////////////////

-(void)mgVoiceClient:(NSURLConnection *)conn didFailWithError:(NSError*)error{
    NSLog(@"mgVoiceClient didFailWithError : %@",error);
    
}
-(void)mgVoiceClient:(NSURLConnection *)conn didFailWithAPIError:(MGApiError*)error{
    NSLog(@"mgVoiceClient didFailWithAPIError : %@",error.body);        
}
-(void)mgVoiceClient:(NSURLConnection *)conn didFinishLoading:(id)result{
    NSLog(@"mgVoiceClient didFinishLoading : %@",result);
    NSString * identifier = [result objectForKey:@"id"];
    if([identifier isEqualToString:@"pressUsersVoicesTestButton"] ||
       [identifier isEqualToString:@"pressFriendsTestButton"]){
        if([result count]>0){
            self.testVoice = [result objectAtIndex:0];
            self.testVoice.delegate = self;
        }
    }else if([identifier isEqualToString:@"pressVoiceDetailTestButton"]){
        self.testVoice = result;
        self.testVoice.delegate = self;
    }
}

-(void)mgVoice:(NSURLConnection *)conn didFailWithError:(NSError*)error{
    NSLog(@"mgVoice didFailWithError : %@",error);    
}
-(void)mgVoice:(NSURLConnection *)conn didFailWithAPIError:(MGApiError*)error{
    NSLog(@"mgVoice didFailWithAPIError : %@",error.body);        
}
-(void)mgVoice:(NSURLConnection *)conn didFinishLoading:(id)result{
    NSLog(@"mgVoice didFinishLoading : %@",result);
    NSString * identifier = [result objectForKey:@"id"];
    if([identifier isEqualToString:@"postComment"]){
    }else if([identifier isEqualToString:@"getComments"]){
        if([result count]>0){
            self.testComment = [result objectAtIndex:0];
        }
    }else if([identifier isEqualToString:@"getIine"]){
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

@end
