//
//  MGPhotoClient.h
//  libMixiGraph
//
//  Created by kinukawa on 11/02/23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
/*
 Copyright (c) 2011, kenji kinukawa
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 Neither the name of the author nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import <Foundation/Foundation.h>
#import "MGHttpClient.h"
#import "MGClientBase.h"
#import "MGParams.h"
#import "MGUtil.h"
#import "MGAlbum.h"
#import "MGPhoto.h"

@protocol MGPhotoClientDelegate;

@interface MGPhotoClient : MGClientBase {
@public	
	id <MGPhotoClientDelegate> delegate;
@private
}

@property (nonatomic,assign) id delegate;

//アルバム一覧の取得
-(void)getAlbumListByUserId:(NSString*)userId 
                withAlbumId:(NSString*)albumId 
                 startIndex:(int)startIndex
                      count:(int)count
                 identifier:(NSString *)identifier;
//最近グループメンバーが作成したアルバム一覧の取得
-(void)getRecentCreatedAlbumListByGroupId:(NSString*)groupId 
                               startIndex:(int)startIndex
                                    count:(int)count
                               identifier:(NSString *)identifier;

//最近友人が作成したアルバム一覧の取得
-(void)getRecentCreatedFriendsAlbumListWithStartIndex:(int)startIndex 
                                                count:(int)count
                                           identifier:(NSString *)identifier;

//あるアルバムに登録されているフォトの一覧を取得
-(void)getPhotoListByUserId:(NSString*)userId 
                    albumId:(NSString*)albumId
                  accessKey:(NSString*)accessKey
                 startIndex:(int)startIndex
                      count:(int)count
                 identifier:(NSString *)identifier;

//あるフォトの情報を取得
-(void)getPhotoByUserId:(NSString*)userId 
                albumId:(NSString*)albumId
            mediaItemId:(NSString*)mediaItemId
              accessKey:(NSString*)accessKey
             startIndex:(int)startIndex
                  count:(int)count
             identifier:(NSString *)identifier;

//最近グループメンバーが作成したフォト一覧の取得
-(void)getRecentCreatedPhotoListByGroupId:(NSString*)groupId 
                               startIndex:(int)startIndex
                                    count:(int)count
                               identifier:(NSString *)identifier;

//最近友人が作成したフォト一覧の取得
-(void)getRecentCreatedFriendsPhotoListWithStartIndex:(int)startIndex 
                                                count:(int)count
                                           identifier:(NSString *)identifier;

//アルバム作成
-(void)makeAlbumWithTitle:(NSString *)title 
              description:(NSString *)description
               visibility:(NSString *)visibility
                accessKey:(NSString *)accessKey
               identifier:(NSString *)identifier;

//フォト投稿
-(void)postPhoto:(UIImage *)image 
         albumId:(NSString *)albumId 
           title:(NSString *)title
      identifier:(NSString *)identifier;
    
@end

@protocol MGPhotoClientDelegate<NSObject>
-(void)mgPhotoClient:(NSURLConnection *)conn didFailWithError:(NSError*)error;
-(void)mgPhotoClient:(NSURLConnection *)conn didFailWithAPIError:(MGApiError*)error;
-(void)mgPhotoClient:(NSURLConnection *)conn didFinishLoading:(id)result;
@end