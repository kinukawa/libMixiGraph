//
//  PeopleTestViewController.m
//  libMixiGraph
//
//  Created by kinukawa on 11/05/01.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PeopleTestViewController.h"


@implementation PeopleTestViewController

@synthesize peopleClient;

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
    self.peopleClient = nil;
    [super dealloc];
}

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
    peopleClient = [[MGPeopleClient alloc]init];
    peopleClient.delegate = self;
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

-(IBAction)pressMyFriendsButton{
    peopleClient.identifier = @"pressMyFriendsButton";
    [peopleClient getMyFriendsWithSortBy:nil 
                               sortOrder:nil 
                                  fields:@"status" startIndex:@"51" count:@"1000"];
}

-(IBAction)pressMyProfileButton{
    peopleClient.identifier = @"pressMyFriendsButton";
    [peopleClient getMyProfileWithFields:@"status"];
    
}

/////////////////

-(void)mgPeopleClient:(NSURLConnection *)conn didFailWithError:(NSError*)error{
    NSLog(@"mgPeopleClient didFailWithError : %@",error);
    
}
-(void)mgPeopleClient:(NSURLConnection *)conn didFailWithAPIError:(MGApiError*)error{
    NSLog(@"mgPeopleClient didFailWithAPIError : %@",error.body);    

}
-(void)mgPeopleClient:(NSURLConnection *)conn didFinishLoading:(id)result{
    NSLog(@"mgPeopleClient didFinishLoading : %@",result);
    if([peopleClient.identifier isEqualToString:@"pressMyFriendsButton"]){
    }    
}

@end
