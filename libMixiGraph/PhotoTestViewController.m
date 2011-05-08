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
@synthesize testComment;
@synthesize testPhoto;

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
    [self.testAlbum getCommentsWithAccessKey:nil startIndex:0 count:0];
}

//アルバムにコメント投稿
-(IBAction)pressPostAlbumCommentsButton{
    self.testAlbum.identifier = @"pressPostAlbumCommentsButton";
    [self.testAlbum postComment:@"ほげふが" withAccessKey:nil];
}

//アルバムコメント削除
-(IBAction)pressDeleteAlbumCommentsButton{
    self.testAlbum.identifier = @"pressDeleteAlbumCommentsButton";
    [self.testAlbum deleteCommentByComment:self.testComment withAccessKey:nil];
}

//フォトコメント取得
-(IBAction)pressGetPhotoCommentsButton{
    self.testPhoto.identifier = @"pressGetPhotoCommentsButton";
    [self.testPhoto getCommentsWithAccessKey:nil startIndex:0 count:0];
}

//フォトコメント投稿
-(IBAction)pressPostPhotoCommentsButton{
    self.testPhoto.identifier = @"pressPostPhotoCommentsButton";
    [self.testPhoto postComment:@"ほげふが" withAccessKey:nil];
}

//フォトコメント削除
-(IBAction)pressDeletePhotoCommentsButton{
    self.testPhoto.identifier = @"pressDeletePhotoCommentsButton";
    [self.testPhoto deleteCommentByComment:testComment withAccessKey:nil];
}
//フォトイイネ取得
-(IBAction)pressGetPhotoFavosButton{
    self.testPhoto.identifier = @"pressGetPhotoFavosButton";
    [self.testPhoto getFavoritesWithAccessKey:nil startIndex:0 count:0];
}

//フォトイイネ投稿
-(IBAction)pressPostPhotoFavosButton{
    self.testPhoto.identifier = @"pressPostPhotoFavosButton";
    [self.testPhoto postFavoriteWithAccessKey:nil];
}

//フォトイイネ削除
-(IBAction)pressDeletePhotoFavosButton{
    self.testPhoto.identifier = @"pressDeletePhotoFavosButton";
    [self.testPhoto deleteFavoriteByUserId:@"5fbcb9i8ysmdg" withAccessKey:nil];
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
        self.testPhoto = [[result objectForKey:@"entry"]objectAtIndex:0];
        self.testPhoto.delegate = self;
    }else if([photoClient.identifier isEqualToString:@"pressGetPhotoButton"]){
        MGPhoto * photo = (MGPhoto*)[result objectForKey:@"entry"];
        NSLog(@"%@",photo.ownerDisplayName);
        NSLog(@"%@",photo.url);
        NSLog(@"%@",photo.photoId);
        NSLog(@"%@",photo.title);
    } 
}

-(void)mgPhoto:(NSURLConnection *)conn didFailWithError:(NSError*)error{
    
}
-(void)mgPhoto:(NSURLConnection *)conn didFailWithAPIError:(MGApiError*)error{
    NSLog(@"mgPhoto didFailWithAPIError : %@",error.body);
 
}
-(void)mgPhoto:(NSURLConnection *)conn didFinishLoading:(id)result{
    NSLog(@"mgPhoto didFinishLoading : %@",result);
    if([testPhoto.identifier isEqualToString:@"pressGetPhotoCommentsButton"]){
        NSArray * commentArray = [result objectForKey:@"entry"];
        if ([commentArray count]>0) {
            self.testComment = [commentArray objectAtIndex:0];            
        }
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
        NSArray * commentArray = [result objectForKey:@"entry"];
        if ([commentArray count]>0) {
            self.testComment = [commentArray objectAtIndex:0];            
        }
    }
}

@end
