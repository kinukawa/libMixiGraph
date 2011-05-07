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
@synthesize testAlbum;

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
    [photoClient getAlbumListByUserId:@"5fbcb9i8ysmdg" withAlbumId:nil startIndex:0 count:2];
}

//最近友人が作成したアルバム一覧の取得
-(IBAction)pressGetRecentCreatedAlbumButton{
    photoClient.identifier = @"pressGetRecentCreatedAlbumButton";
    [photoClient getRecentCreatedFriendsAlbumListWithStartIndex:0 count:0];
}

//あるアルバムに登録されているフォトの一覧を取得
-(IBAction)pressGetPhotoListButton{
    photoClient.identifier = @"pressGetPhotoListButton";
    [photoClient getPhotoListByUserId:@"5fbcb9i8ysmdg" albumId:@"@default" accessKey:nil startIndex:0 count:0];
}

//あるフォトの情報を取得
-(IBAction)pressGetPhotoButton{
    photoClient.identifier = @"pressGetPhotoButton";
    [photoClient getPhotoByUserId:@"5fbcb9i8ysmdg" albumId:@"@default" mediaItemId:@"1078227913" accessKey:nil startIndex:0 count:0];
}

//最近友人が作成したフォト一覧の取得
-(IBAction)pressGetRecentCreatedPhotoButton{
    photoClient.identifier = @"pressGetRecentCreatedPhotoButton";
    [photoClient getRecentCreatedFriendsPhotoListWithStartIndex:0 count:0];
}

//アルバムコメント一覧の取得
-(IBAction)pressGetAlbumCommentsButton{
    self.testAlbum.identifier = @"pressGetAlbumCommentsButton";
    [self.testAlbum getCommentsWithAccessKey:nil];
}


/////////////////////////////////
-(void)mgPhotoClient:(NSURLConnection *)conn didFailWithError:(NSError*)error{
    
}
-(void)mgPhotoClient:(NSURLConnection *)conn didFailWithAPIError:(MGApiError*)error{
    NSLog(@"mgPhotoClient didFailWithAPIError : %@",error.body);
    
}
-(void)mgPhotoClient:(NSURLConnection *)conn didFinishLoading:(id)result{
    NSLog(@"mgPhotoClient didFinishLoading : %@",result);
    if([photoClient.identifier isEqualToString:@"pressGetAlbumButton"]||
       [photoClient.identifier isEqualToString:@"pressGetRecentCreatedAlbumButton"]){
        NSArray * albumArray = (NSArray*)[result objectForKey:@"entry"];
        for (MGAlbum * album in albumArray) {
            NSLog(@"%@",album.ownerDisplayName);
            NSLog(@"%@",album.url);
            NSLog(@"%d",album.numComments);
            NSLog(@"%@",album.title);
        }
        self.testAlbum = [albumArray objectAtIndex:0];
        self.testAlbum.delegate = self;
    }else if([photoClient.identifier isEqualToString:@"pressGetPhotoListButton"] ||
             [photoClient.identifier isEqualToString:@"pressGetRecentCreatedPhotoButton"]){
        NSArray * photoArray = (NSArray*)[result objectForKey:@"entry"];
        for (MGPhoto * photo in photoArray) {
            NSLog(@"%@",photo.ownerDisplayName);
            NSLog(@"%@",photo.url);
            NSLog(@"%@",photo.photoId);
            NSLog(@"%@",photo.title);
        }
    }else if([photoClient.identifier isEqualToString:@"pressGetPhotoButton"]){
        MGPhoto * photo = (MGPhoto*)[result objectForKey:@"entry"];
        NSLog(@"%@",photo.ownerDisplayName);
        NSLog(@"%@",photo.url);
        NSLog(@"%@",photo.photoId);
        NSLog(@"%@",photo.title);
    } 
}

-(void)mgAlbum:(NSURLConnection *)conn didFailWithError:(NSError*)error{
    
}
-(void)mgAlbum:(NSURLConnection *)conn didFailWithAPIError:(MGApiError*)error{
    NSLog(@"mgAlbum didFailWithAPIError : %@",error.body);
    
}
-(void)mgAlbum:(NSURLConnection *)conn didFinishLoading:(id)result{
    NSLog(@"mgAlbum didFinishLoading : %@",result);
    if([testAlbum.identifier isEqualToString:@"pressGetAlbumCommentsButton"]){
        
    }
}

@end
