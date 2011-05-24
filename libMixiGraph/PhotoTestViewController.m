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
@synthesize photoView;

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
    //photoClient.identifier = @"pressGetAlbumButton";
    [photoClient getAlbumListByUserId:@"5fbcb9i8ysmdg" withAlbumId:nil startIndex:0 count:2 identifier:@"pressGetAlbumButton"];
}

//最近友人が作成したアルバム一覧の取得
-(IBAction)pressGetRecentCreatedAlbumButton{
    //photoClient.identifier = @"pressGetRecentCreatedAlbumButton";
    [photoClient getRecentCreatedFriendsAlbumListWithStartIndex:0 count:0 identifier:@"pressGetRecentCreatedAlbumButton"];
}

//あるアルバムに登録されているフォトの一覧を取得
-(IBAction)pressGetPhotoListButton{
    //photoClient.identifier = @"pressGetPhotoListButton";
    [photoClient getPhotoListByUserId:@"5fbcb9i8ysmdg" albumId:@"@default" accessKey:nil startIndex:0 count:0 identifier:@"pressGetPhotoListButton"];
}

//あるフォトの情報を取得
-(IBAction)pressGetPhotoButton{
    //photoClient.identifier = @"pressGetPhotoButton";
    [photoClient getPhotoByUserId:@"5fbcb9i8ysmdg" albumId:@"@default" mediaItemId:@"1078227913" accessKey:nil startIndex:0 count:0 identifier:@"pressGetPhotoButton"];
}

//最近友人が作成したフォト一覧の取得
-(IBAction)pressGetRecentCreatedPhotoButton{
    //photoClient.identifier = @"pressGetRecentCreatedPhotoButton";
    [photoClient getRecentCreatedFriendsPhotoListWithStartIndex:0 count:0 identifier:@"pressGetRecentCreatedPhotoButton"];
}

//アルバムコメント一覧の取得
-(IBAction)pressGetAlbumCommentsButton{
    //self.testAlbum.identifier = @"pressGetAlbumCommentsButton";
    [self.testAlbum getCommentsWithAccessKey:nil startIndex:0 count:0 identifier:@"pressGetAlbumCommentsButton"];
}

//アルバムにコメント投稿
-(IBAction)pressPostAlbumCommentsButton{
    //self.testAlbum.identifier = @"pressPostAlbumCommentsButton";
    [self.testAlbum postComment:@"ほげふが++" withAccessKey:nil identifier:@"pressPostAlbumCommentsButton"];
}

//アルバムコメント削除
-(IBAction)pressDeleteAlbumCommentsButton{
    //self.testAlbum.identifier = @"pressDeleteAlbumCommentsButton";
    [self.testAlbum deleteCommentByComment:self.testComment withAccessKey:nil identifier:@"pressDeleteAlbumCommentsButton"];
}

//フォトコメント取得
-(IBAction)pressGetPhotoCommentsButton{
    //self.testPhoto.identifier = @"pressGetPhotoCommentsButton";
    [self.testPhoto getCommentsWithAccessKey:nil startIndex:0 count:0 identifier:@"pressGetPhotoCommentsButton"];
}

//フォトコメント投稿
-(IBAction)pressPostPhotoCommentsButton{
    //self.testPhoto.identifier = @"pressPostPhotoCommentsButton";
    [self.testPhoto postComment:@"ほげふが++" withAccessKey:nil identifier:@"pressPostPhotoCommentsButton"];
}

//フォトコメント削除
-(IBAction)pressDeletePhotoCommentsButton{
    //self.testPhoto.identifier = @"pressDeletePhotoCommentsButton";
    [self.testPhoto deleteCommentByComment:testComment withAccessKey:nil identifier:@"pressDeletePhotoCommentsButton"];
}
//フォトイイネ取得
-(IBAction)pressGetPhotoFavosButton{
    //self.testPhoto.identifier = @"pressGetPhotoFavosButton";
    [self.testPhoto getFavoritesWithAccessKey:nil startIndex:0 count:0 identifier:@"pressGetPhotoFavosButton"];
}

//フォトイイネ投稿
-(IBAction)pressPostPhotoFavosButton{
    //self.testPhoto.identifier = @"pressPostPhotoFavosButton";
    [self.testPhoto postFavoriteWithAccessKey:nil identifier:@"pressPostPhotoFavosButton"];
}

//フォトイイネ削除
-(IBAction)pressDeletePhotoFavosButton{
    //self.testPhoto.identifier = @"pressDeletePhotoFavosButton";
    [self.testPhoto deleteFavoriteByUserId:@"5fbcb9i8ysmdg" withAccessKey:nil identifier:@"pressDeletePhotoFavosButton"];
}

//アルバム作成
-(IBAction)pressMakeAlbumButton{
    //self.photoClient.identifier = @"pressMakeAlbumButton";
    [self.photoClient makeAlbumWithTitle:@"ホゲアルバム+++" description:@"ほげほげ++" visibility:@"everyone" accessKey:nil identifier:@"pressMakeAlbumButton"];
}

//アルバム削除
-(IBAction)pressDeleteAlbumButton{
    //self.testAlbum.identifier = @"pressDeleteAlbumButton";
    [self.testAlbum deleteAlbum:@"pressDeleteAlbumButton"];
}

//フォト投稿
-(IBAction)pressPostPhotoButton{
    //self.photoClient.identifier = @"pressPostPhotoButton";
    [self.photoClient postPhoto:photoView.image albumId:@"@default" title:@"ほげふが++" identifier:@"pressPostPhotoButton"];
}

//フォト削除
-(IBAction)pressDeletePhotoButton{
    //self.testPhoto.identifier = @"pressDeletePhotoButton";
    [self.testPhoto deletePhoto:@"pressDeletePhotoButton"];
}

/////////////////////////////////
-(void)mgPhotoClient:(NSURLConnection *)conn didFailWithError:(NSError*)error{
    
}
-(void)mgPhotoClient:(NSURLConnection *)conn didFailWithAPIError:(MGApiError*)error{
    NSLog(@"mgPhotoClient didFailWithAPIError : %@",error.body);
    
}
-(void)mgPhotoClient:(NSURLConnection *)conn didFinishLoading:(id)result{
    NSLog(@"mgPhotoClient didFinishLoading : %@",result);
    NSString * identifier = [result objectForKey:@"id"];
    if([identifier isEqualToString:@"pressGetAlbumButton"]||
       [identifier isEqualToString:@"pressGetRecentCreatedAlbumButton"]){
        NSArray * albumArray = (NSArray*)[result objectForKey:@"data"];
        for (MGAlbum * album in albumArray) {
            NSLog(@"%@",album.ownerDisplayName);
            NSLog(@"%@",album.url);
            NSLog(@"%d",album.numComments);
            NSLog(@"%@",album.title);
        }
        if ([albumArray count]>0) {
            self.testAlbum = [albumArray objectAtIndex:0];
            self.testAlbum.delegate = self;
        }
    }else if([identifier isEqualToString:@"pressGetPhotoListButton"] ||
             [identifier isEqualToString:@"pressGetRecentCreatedPhotoButton"]){
        NSArray * photoArray = (NSArray*)[result objectForKey:@"data"];
        for (MGPhoto * photo in photoArray) {
            NSLog(@"%@",photo.ownerDisplayName);
            NSLog(@"%@",photo.url);
            NSLog(@"%@",photo.photoId);
            NSLog(@"%@",photo.title);
        }
        self.testPhoto = [[result objectForKey:@"data"]objectAtIndex:0];
        self.testPhoto.delegate = self;
    }else if([identifier isEqualToString:@"pressGetPhotoButton"]){
        MGPhoto * photo = (MGPhoto*)[result objectForKey:@"data"];
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
    NSString * identifier = [result objectForKey:@"id"];
    if([identifier isEqualToString:@"pressGetPhotoCommentsButton"]){
        NSArray * commentArray = [result objectForKey:@"data"];
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
    NSString * identifier = [result objectForKey:@"id"];
    if([identifier isEqualToString:@"pressGetAlbumCommentsButton"]){
        NSArray * commentArray = [result objectForKey:@"data"];
        if ([commentArray count]>0) {
            self.testComment = [commentArray objectAtIndex:0];            
        }
    }
}

@end
