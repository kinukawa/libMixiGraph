//
//  MGPhoto.m
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

#import "MGPhoto.h"


@implementation MGPhoto
@synthesize delegate;
@synthesize albumId;
@synthesize created;
@synthesize photoId;
@synthesize largeImageUrl;
@synthesize mimeType;
@synthesize numComments;
@synthesize numFavorites;
@synthesize thumbnailUrl;
@synthesize title;
@synthesize type;
@synthesize url;
@synthesize viewPageUrl;
@synthesize ownerThumbnailUrl;
@synthesize ownerId;
@synthesize ownerDisplayName;
@synthesize ownerProfileUrl;
@synthesize ownerThumbnailImage;

-(id)init{
	if((self = [super init])){
		//initialize
    }
	return self;
}

- (void) dealloc {
    self.delegate = nil;
    
    self.albumId = nil;
    self.created = nil;
    self.photoId = nil;
    self.largeImageUrl = nil;
    self.mimeType = nil;
    self.numComments = 0;
    self.numFavorites = 0;
    self.thumbnailUrl = nil;
    self.title = nil;
    self.type = nil;
    self.url = nil;
    self.viewPageUrl = nil;
    self.ownerThumbnailUrl = nil;
    self.ownerId = nil;
    self.ownerDisplayName = nil;
    self.ownerProfileUrl = nil;
    self.ownerThumbnailImage = nil;
    
	[super dealloc];
}

+(MGPhoto *)makeContentFromDict:(NSDictionary*)dict{
    MGPhoto * photo = [[[MGPhoto alloc] init] autorelease];
    
    photo.albumId       = [dict objectForKey:@"albumId"];
    photo.created       = [dict objectForKey:@"created"];
    photo.photoId       = [dict objectForKey:@"id"];
    photo.largeImageUrl = [dict objectForKey:@"largeImageUrl"];
    photo.mimeType      = [dict objectForKey:@"mimeType"];
    if ([[dict objectForKey:@"numComments"] isEqual:[NSNull null]]) {
        photo.numComments = [[dict objectForKey:@"numComments"] intValue];
    }
    if (![[dict objectForKey:@"numFavorites"] isEqual:[NSNull null]]) {
        photo.numFavorites = [[dict objectForKey:@"numFavorites"] intValue];
    }
    photo.thumbnailUrl = [dict objectForKey:@"thumbnailUrl"];
    photo.title        = [dict objectForKey:@"title"];
    photo.type         = [dict objectForKey:@"type"];
    photo.url          = [dict objectForKey:@"url"];
    photo.viewPageUrl  = [dict objectForKey:@"viewPageUrl"];
    
    NSDictionary * owner = [dict objectForKey:@"owner"];
    if (![owner isEqual:[NSNull null]]) {
        photo.ownerDisplayName	= [owner objectForKey:@"displayName"];
        photo.ownerId           = [owner objectForKey:@"id"];
        photo.ownerProfileUrl   = [owner objectForKey:@"profileUrl"];
        photo.ownerThumbnailUrl = [owner objectForKey:@"thumbnailUrl"];
    }
    return photo;
}

//////////////MGHttpClientDelegate/////////////////////
-(void)mgHttpClient:(NSURLConnection *)conn didFailWithError:(NSError*)error{
	NSLog(@"mgPhoto didFailWithError");
	if([delegate respondsToSelector:@selector(mgPhoto:didFailWithError:)]){
		[delegate mgPhoto:conn didFailWithError:error];
	}
}

-(void)mgHttpClient:(NSURLConnection *)conn didFailWithAPIError:(MGApiError*)error{
	NSLog(@"mgPhoto didFailWithError : %@",error);
	if([delegate respondsToSelector:@selector(mgPhoto:didFailWithAPIError:)]){
		[delegate mgPhoto:conn didFailWithAPIError:error];
	}
}

-(void)mgHttpClient:(NSURLConnection *)conn didFinishLoading:(NSData *)data{
    NSString *contents = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	NSLog(@"mgPhoto didFinishLoading %@:%@",self.httpClient.identifier,contents);
    id result = data;
    if(self.httpClient.identifier==@"getComments"){
        result = [MGComment makeCommentArrayFromResponseData:data];
    }
    /*else if(self.httpClient.identifier==@"postComment"){
        result = [MGComment makeCommentFromResponseData:data];
        self.replyCount++;
    }else if(self.httpClient.identifier==@"deleteComment"){
        result = [MGComment makeCommentFromResponseData:data];
        self.replyCount--;
    }else if(self.httpClient.identifier==@"getFavorites"){
        result = [MGFavorite makeFavoriteArrayFromResponseData:data];
    }else if(self.httpClient.identifier==@"postFavorite"){
        result = [MGVoice makeContentFromResponseData:data];
    }else if(self.httpClient.identifier==@"deleteFavorite"){
        result = [MGFavorite makeFavoriteFromResponseData:data];
        self.favoriteCount--;
    }
    */
	if([delegate respondsToSelector:@selector(mgPhoto:didFinishLoading:)]){
        [delegate mgPhoto:conn didFinishLoading:data];
    }
}

@end
