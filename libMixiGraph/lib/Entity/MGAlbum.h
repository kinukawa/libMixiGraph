//
//  MGAlbum.h
//  libMixiGraph
//
//  Created by kinukawa on 11/05/03.
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
#import "JSON.h"
#import "MGComment.h"
#import "MGFavorite.h"

@protocol MGAlbumDelegate;

@interface MGAlbum : MGContentBase {
    id <MGAlbumDelegate>delegate;
    
    NSString * created;
    NSString * description;
    NSString * albumId; 
    int mediaItemCount; 
    int numComments;
    NSString * ownerDisplayName;
    NSString * ownerId;
    NSString * ownerProfileUrl;
    NSString * ownerThumbnailUrl;
    NSString * privacyVisibility;
    NSString * thumbnailUrl;
    NSString * title;
    NSString * url;
    NSString * viewPageUrl;
}

-(void)getCommentsWithAccessKey:(NSString *)accessKey 
                     startIndex:(NSString *)startIndex
                          count:(NSString *)count;
-(void)postComment:(NSString *)comment;
/*
-(void)deleteCommentByComment:(MGComment *)comment;
-(void)getFavoritesWithStartIndex:(NSString *)startIndex
                            count:(NSString *)count;
-(void)postFavorite;
-(void)deleteFavoriteByUserId:(NSString *)uId;
*/
@property (nonatomic,assign) id delegate;

@property (nonatomic,retain) NSString * created;
@property (nonatomic,retain) NSString * description;
@property (nonatomic,retain) NSString * albumId; 
@property (nonatomic) int mediaItemCount; 
@property (nonatomic) int numComments;
@property (nonatomic,retain) NSString * ownerDisplayName;
@property (nonatomic,retain) NSString * ownerId;
@property (nonatomic,retain) NSString * ownerProfileUrl;
@property (nonatomic,retain) NSString * ownerThumbnailUrl;
@property (nonatomic,retain) NSString * privacyVisibility;
@property (nonatomic,retain) NSString * thumbnailUrl;
@property (nonatomic,retain) NSString * title;
@property (nonatomic,retain) NSString * url;
@property (nonatomic,retain) NSString * viewPageUrl;

@end

@protocol MGAlbumDelegate<NSObject>
-(void)mgAlbum:(NSURLConnection *)conn didFailWithError:(NSError*)error;
-(void)mgAlbum:(NSURLConnection *)conn didFailWithAPIError:(MGApiError*)error;
-(void)mgAlbum:(NSURLConnection *)conn didFinishLoading:(id)result;
@end
