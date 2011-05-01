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
    
    voiceClient.identifier = @"pressUsersVoicesTestButton";
    [voiceClient requestUserVoicesByUserID:@"@me" trimUser:NO attachPhoto:YES startIndex:@"0" count:@"3"];
    //[voiceClient requestUserVoicesByUserID:@"bgbj9n8rtg3wc" trimUser:NO attachPhoto:YES startIndex:nil count:nil usingSinceId:@"bgbj9n8rtg3wc-20110408225707"];
}

-(IBAction)pressFriendsTestButton{
    
    voiceClient.identifier = @"pressFriendsTestButton";
    [voiceClient requestFriendsVoicesByGroupID:nil trimUser:NO attachPhoto:YES startIndex:nil count:nil];
}

-(IBAction)pressVoiceDetailTestButton{
    voiceClient.identifier = @"pressVoiceDetailTestButton";
    [voiceClient requestVoiceInfoByPostID:@"5fbcb9i8ysmdg-20110430151456" trimUser:NO attachPhoto:YES];
}

-(IBAction)pressPostVoiceTestButton{
    voiceClient.identifier = @"post";
    [voiceClient requestPostVoice:voiceTextField.text];
}
-(IBAction)pressImagePostVoiceTestButton{
    voiceClient.identifier = @"post";
    [voiceClient requestPostVoice:voiceTextField.text withUIImage:imageView.image];
}

-(IBAction)pressDeleteVoiceTestButton{
    voiceClient.identifier = @"delete";
    [voiceClient requestDeleteVoiceByPostId:testVoice.postId];
}

-(IBAction)pressCommentToVoiceButton{
    self.testVoice.identifier = @"postComment";
    [self.testVoice postComment:commentTextField.text];
}

-(IBAction)pressGetCommentsButton{
    self.testVoice.identifier = @"getComments";
    [self.testVoice getComments];
}

-(IBAction)pressDeleteCommentsButton{
    self.testVoice.identifier = @"deleteComments";
    //[self.testVoice deleteCommentByIndex:<#(MGComment *)#>];
}

-(IBAction)pressGetIineButton{
    self.testVoice.identifier = @"getIine";
    [self.testVoice getFavorites];
}
-(IBAction)pressPostIineButton{
    self.testVoice.identifier = @"postIine";
    [self.testVoice postFavorite];
}
-(IBAction)pressDeelteIineButton{
    self.testVoice.identifier=@"deleteIine";
    //[self.testVoice deleteFavorite];
}


/////////////voiceClientDelegate methods/////////////////////////////////

-(void)mgVoiceClient:(NSURLConnection *)conn didFailWithError:(NSError*)error{
    NSLog(@"mgVoiceClient didFailWithError : %@",error);
    
}

-(void)mgVoiceClient:(NSURLConnection *)conn didFinishLoading:(id)result{
    NSLog(@"mgVoiceClient didFinishLoading : %@",result);
    
    if ([result isKindOfClass:[MGVoice class]]) {
        //[result print];   
    }else if([result isKindOfClass:[NSArray class]]){
        //MGVoice * voice = [result objectAtIndex:0];
        //[voice print];   
    }
    
    if([voiceClient.identifier isEqualToString:@"post"]){
        self.testVoice = result;
        self.testVoice.delegate = self;
        
    }else if([voiceClient.identifier isEqualToString:@"pressVoiceDetailTestButton"]){
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
    //NSLog(@"mgVoiceClient didFinishLoading [%@]",result);
    /*for (MGComment*comment in testVoice.commentList) {
        NSLog(@"comment return : %@",comment.commentText);            
    }*/
    if([self.testVoice.identifier isEqualToString:@"postComment"]){
        //NSString *contents = [[[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding] autorelease];
        self.testComment = [MGComment makeCommentFromResponseData:result];
        //self.testComment.delegate = self;
    }

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

@end
