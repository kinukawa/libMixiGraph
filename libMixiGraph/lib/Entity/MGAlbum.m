//
//  MGAlbum.m
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

#import "MGAlbum.h"


@implementation MGAlbum
@synthesize created;
@synthesize description;
@synthesize albumId; 
@synthesize mediaItemCount; 
@synthesize numComments;
@synthesize ownerDisplayName;
@synthesize ownerId;
@synthesize ownerProfileUrl;
@synthesize ownerThumbnailUrl;
@synthesize privacyVisibility;
@synthesize thumbnailUrl;
@synthesize title;
@synthesize url;
@synthesize viewPageUrl;

-(id)init{
	if((self = [super init])){
		//initialize
        
    }
	return self;
}

- (void) dealloc {
    self.created = nil;
    self.description = nil;
    self.albumId = nil;
    self.ownerDisplayName = nil;
    self.ownerId = nil;
    self.ownerProfileUrl = nil;
    self.ownerThumbnailUrl = nil;
    self.privacyVisibility = nil;
    self.thumbnailUrl = nil;
    self.title = nil;
    self.url = nil;
    self.viewPageUrl = nil;
    
	[super dealloc];
}

+(MGAlbum *)makeContentFromDict:(NSDictionary*)dict{
    MGAlbum * album = [[[MGAlbum alloc] init] autorelease];
    
    album.created        = [dict objectForKey:@"created"];
    album.description    = [dict objectForKey:@"description"];
    album.albumId        = [dict objectForKey:@"id"];
    if (![[dict objectForKey:@"mediaItemCount"] isEqual:[NSNull null]]) {
        album.mediaItemCount = [[dict objectForKey:@"mediaItemCount"] intValue]; 
    }
    if (![[dict objectForKey:@"numComments"] isEqual:[NSNull null]]) {
        album.numComments    = [[dict objectForKey:@"numComments"] intValue];
    }
    NSDictionary * owner = [dict objectForKey:@"owner"];
    if (![owner isEqual:[NSNull null]]) {
        album.ownerDisplayName	= [owner objectForKey:@"displayName"];
        album.ownerId           = [owner objectForKey:@"id"];
        album.ownerProfileUrl   = [owner objectForKey:@"profileUrl"];
        album.ownerThumbnailUrl = [owner objectForKey:@"thumbnailUrl"];
    }
    NSDictionary * privacy = [dict objectForKey:@"privacy"];
    if (![privacy isEqual:[NSNull null]]) {
        album.privacyVisibility = [privacy objectForKey:@"visibility"];
    }
    album.thumbnailUrl     = [dict objectForKey:@"thumbnailUrl"];
    album.title = [dict objectForKey:@"title"];
    album.url = [dict objectForKey:@"url"];
    album.viewPageUrl = [dict objectForKey:@"viewPageUrl"];

    return album;
}

@end
