//
//  PhotoTestViewController.m
//  libMixiGraph
//
//  Created by kinukawa on 11/05/03.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PhotoTestViewController.h"


@implementation PhotoTestViewController
@synthesize photoClient;

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
    self.photoClient = nil;
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
    self.photoClient = [[[MGPhotoClient alloc]init] autorelease];
    self.photoClient.delegate = self;
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


-(IBAction)pressGetAlbumButton{
    photoClient.identifier = @"pressGetAlbumButton";
    [photoClient getAlbumListByUserId:@"5fbcb9i8ysmdg" withAlbumId:nil];
}



-(void)mgPhotoClient:(NSURLConnection *)conn didFailWithError:(NSError*)error{
    
}
-(void)mgPhotoClient:(NSURLConnection *)conn didFailWithAPIError:(MGApiError*)error{
    
}
-(void)mgPhotoClient:(NSURLConnection *)conn didFinishLoading:(id)result{
    NSLog(@"mgPhotoClient didFinishLoading : %@",result);
    if([photoClient.identifier isEqualToString:@"hogehuga"]){
    } 
}


@end
