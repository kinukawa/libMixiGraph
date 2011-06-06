//
//  UpdatesTestViewController.m
//  libMixiGraph
//
//  Created by kenji.kinukawa on 11/06/06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UpdatesTestViewController.h"


@implementation UpdatesTestViewController
@synthesize updatesClient;

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
    self.updatesClient = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(IBAction)getMyFeed{
    [updatesClient getUpdatesFeedByUserID:@"@me" groupId:@"@friends" fields:nil count:@"5" updatedSince:nil device:nil identifier:@"getMyFeed"];
}

#pragma mark - UpdatesClientDelegate
-(void)mgUpdatesClient:(NSURLConnection *)conn didFailWithError:(NSError*)error{
    
}

-(void)mgUpdatesClient:(NSURLConnection *)conn didFailWithAPIError:(MGApiError*)error{
    NSLog(@"mgUpdatesClient didFailWithAPIError : %@",error.body);
    
}

-(void)mgUpdatesClient:(NSURLConnection *)conn didFinishLoading:(id)result{
    NSLog(@"mgUpdatesClient didFinishLoading : %@",result);
    NSString * identifier = [result objectForKey:@"id"];
    if([identifier isEqualToString:@"getMyFeed"]){
        
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.updatesClient = [[[MGUpdatesClient alloc]init]autorelease];
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

@end
