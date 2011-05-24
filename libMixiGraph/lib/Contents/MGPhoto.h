//
//  MGPhoto.h
//  Picxi
//
//  Created by kenji kinukawa on 11/03/04.
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
#import <UIKit/UIKit.h>
#import "MGComment.h"
#import "MGFavorite.h"
#import "MGContentBase.h"
#import "MGApiError.h"

@protocol MGPhotoDelegate;

@interface MGPhoto : MGContentBase {
    id <MGPhotoDelegate> delegate;
	NSString * albumId;
	NSString * created;
	NSString * photoId;
	NSString * mimeType;
	int numComments;
	int numFavorites;
	NSString * thumbnailUrl;
	NSString * title;
	NSString * type;
	NSString * largeImageUrl;
	NSString * url;
	NSString * viewPageUrl;
	NSString * ownerThumbnailUrl;
	NSString * ownerId;
	NSString * ownerDisplayName;
	NSString * ownerProfileUrl;
    UIImage * ownerThumbnailImage;
@private
}
//-(UIImage *)getPhoto;

-(void)getCommentsWithAccessKey:(NSString *)accessKey 
                     startIndex:(NSString *)startIndex
                          count:(NSString *)count
                     identifier:(NSString *)identifier;
-(void)postComment:(NSString *)comment withAccessKey:(NSString *)accessKey
        identifier:(NSString *)identifier;

-(void)deleteCommentByComment:(MGComment *)comment withAccessKey:(NSString *)accessKey
                   identifier:(NSString *)identifier;

-(void)getFavoritesWithAccessKey:(NSString *)accessKey 
                      startIndex:(NSString *)startIndex
                           count:(NSString *)count
                      identifier:(NSString *)identifier;

-(void)postFavoriteWithAccessKey:(NSString *)accessKey
                      identifier:(NSString *)identifier;

-(void)deleteFavoriteByUserId:(NSString *)uId withAccessKey:(NSString *)accessKey
                   identifier:(NSString *)identifier;

-(void)deletePhoto:(NSString *)identifier;


@property (nonatomic,assign) id delegate;

@property (nonatomic,retain) NSString * albumId;
@property (nonatomic,retain) NSString * created;
@property (nonatomic,retain) NSString * photoId;
@property (nonatomic,retain) NSString * largeImageUrl;
@property (nonatomic,retain) NSString * mimeType;
@property (nonatomic) int numComments;
@property (nonatomic) int numFavorites;
@property (nonatomic,retain) NSString * thumbnailUrl;
@property (nonatomic,retain) NSString * title;
@property (nonatomic,retain) NSString * type;
@property (nonatomic,retain) NSString * url;
@property (nonatomic,retain) NSString * viewPageUrl;
@property (nonatomic,retain) NSString * ownerThumbnailUrl;
@property (nonatomic,retain) NSString * ownerId;
@property (nonatomic,retain) NSString * ownerDisplayName;
@property (nonatomic,retain) NSString * ownerProfileUrl;
@property (nonatomic,retain) UIImage * ownerThumbnailImage;

@end

@protocol MGPhotoDelegate<NSObject>
-(void)mgPhoto:(NSURLConnection *)conn didFailWithError:(NSError*)error;
-(void)mgPhoto:(NSURLConnection *)conn didFailWithAPIError:(MGApiError*)error;
-(void)mgPhoto:(NSURLConnection *)conn didFinishLoading:(id)result;
@end
