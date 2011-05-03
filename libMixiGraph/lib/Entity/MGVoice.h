//
//  MGVoice.h
//  libMixiGraph
//
//  Created by kinukawa on 11/02/17.
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
#import "MGContentBase.h"
#import "MGUtil.h"
#import "MGParams.h"
#import "MGComment.h"
#import "MGFavorite.h"
#import "MGHttpClient.h"

@protocol MGVoiceDelegate;

@interface MGVoice : MGContentBase{
@public	
	id <MGVoiceDelegate> delegate;
    //NSString * identifier;
	NSString * postId;			//つぶやきを特定するためのID (Post-ID)
	NSString * createdAt;		//つぶやきが投稿された日時
	NSString * voiceText;			//つぶやきの本文
	NSString * userId;			//つぶやきを投稿したユーザのID
	NSString * userScreeName;	//つぶやきを投稿したユーザのニックネーム
	NSString * userProfileImageUrl;	//つぶやきを投稿したユーザのプロフィール画像のURL
	NSString * userUrl;			//つぶやきを投稿したユーザのプロフィールページのURL
	int replyCount;		//このつぶやきに対してのコメントの件数
	int favoriteCount;	//このつぶやきに対してのイイネ！の件数
	NSString * source;			//このつぶやきがTwitterからmixiボイスに取り込まれたものである場合に、このsourceプロパティが結果に含まれます。プロパティ値は”twitter”となります。
	bool favorited;		//認可ユーザがこのつぶやきに対してすでに”イイネ！”している場合 true。そうでなければ false。
	NSString * photoImageUrl;
	NSString * photoThumbnailUrl;
    
    //NSMutableArray * commentList;
    //NSMutableArray * favoriteList;
@private
	//MGHttpClient * httpClient;
}

-(void)getComments;
-(void)postComment:(NSString *)comment;
-(void)deleteCommentByComment:(MGComment *)comment;
-(void)getFavorites;
-(void)postFavorite;
-(void)deleteFavoriteByUserId:(NSString *)uId;

@property (nonatomic,assign) id delegate;
//@property (nonatomic,retain) NSString * identifier;
//@property (nonatomic,retain) MGHttpClient * httpClient;

@property (nonatomic,retain) NSString * postId;
@property (nonatomic,retain) NSString * createdAt;
@property (nonatomic,retain) NSString * voiceText;
@property (nonatomic,retain) NSString * userId;
@property (nonatomic,retain) NSString * userScreeName;
@property (nonatomic,retain) NSString * userProfileImageUrl;
@property (nonatomic,retain) NSString * userUrl;
@property (nonatomic)       int replyCount;
@property (nonatomic)       int favoriteCount;
@property (nonatomic,retain) NSString * source;
@property bool favorited;
@property (nonatomic,retain) NSString * photoImageUrl;
@property (nonatomic,retain) NSString * photoThumbnailUrl;

@end

@protocol MGVoiceDelegate<NSObject>
-(void)mgVoice:(NSURLConnection *)conn didFailWithError:(NSError*)error;
-(void)mgVoice:(NSURLConnection *)conn didFailWithAPIError:(MGApiError*)error;
-(void)mgVoice:(NSURLConnection *)conn didFinishLoading:(id)result;
@end
