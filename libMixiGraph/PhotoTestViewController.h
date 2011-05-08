//
//  PhotoTestViewController.h
//  libMixiGraph
//
//  Created by kinukawa on 11/05/03.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGPhotoClient.h"

@interface PhotoTestViewController : UIViewController {
    MGPhotoClient * photoClient;
    MGAlbum * testAlbum;
    MGPhoto * testPhoto;
    MGComment * testComment;
    UIImageView * photoView;
}

-(IBAction)pressGetAlbumButton;
//最近友人が作成したアルバム一覧の取得
-(IBAction)pressGetRecentCreatedAlbumButton;
//あるアルバムに登録されているフォトの一覧を取得
-(IBAction)pressGetPhotoListButton;
//あるフォトの情報を取得
-(IBAction)pressGetPhotoButton;
//最近友人が作成したフォト一覧の取得
-(IBAction)pressGetRecentCreatedPhotoButton;
//アルバムコメント一覧の取得
-(IBAction)pressGetAlbumCommentsButton;
//アルバムにコメント投稿
-(IBAction)pressPostAlbumCommentsButton;
//アルバムコメント削除
-(IBAction)pressDeleteAlbumCommentsButton;
//フォトコメント取得
-(IBAction)pressGetPhotoCommentsButton;
//フォトコメント投稿
-(IBAction)pressPostPhotoCommentsButton;
//フォトコメント削除
-(IBAction)pressDeletePhotoCommentsButton;
//フォトイイネ取得
-(IBAction)pressGetPhotoFavosButton;
//フォトイイネ投稿
-(IBAction)pressPostPhotoFavosButton;
//フォトイイネ削除
-(IBAction)pressDeletePhotoFavosButton;
//アルバム作成
-(IBAction)pressMakeAlbumButton;
//アルバム削除
-(IBAction)pressDeleteAlbumButton;
//フォト投稿
-(IBAction)pressPostPhotoButton;

@property (nonatomic,retain) MGPhotoClient * photoClient;
@property (nonatomic,retain) MGAlbum * testAlbum;
@property (nonatomic,retain) MGComment * testComment;
@property (nonatomic,retain) MGPhoto * testPhoto;
@property (nonatomic,retain) IBOutlet UIImageView * photoView;
@end
