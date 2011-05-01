//
//  MGFavorite.m
//  libMixiGraph
//
//  Created by kinukawa on 11/04/30.
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

#import "MGFavorite.h"


@implementation MGFavorite
@synthesize userId;
@synthesize userScreeName;
@synthesize userProfileImageUrl;
@synthesize userUrl;

-(id)init{
	if((self = [super init])){
		//initialize
    }
	return self;
}

- (void) dealloc {
	[super dealloc];
}

+(MGFavorite *)makeFavoriteFromDict:(NSDictionary*)dict{
	MGFavorite * favorite = [[[MGFavorite alloc]init]autorelease];
    favorite.userId = [dict objectForKey:@"id"];
    favorite.userScreeName = [dict objectForKey:@"screen_name"];
    favorite.userProfileImageUrl = [dict objectForKey:@"profile_image_url"];
    favorite.userUrl = [dict objectForKey:@"url"];
    return favorite;
}

+(MGFavorite *)makeFavoriteFromResponseData:(NSData*)data{
    NSString *contents = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	NSDictionary * favoriteContentDict = [contents JSONValue];
    MGFavorite * favorite = [self makeFavoriteFromDict:favoriteContentDict];
    return favorite;
}

+(NSMutableArray *)makeFavoriteArrayFromResponseData:(NSData*)data{
    NSString *contents = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	//NSLog(@"%@",contents);
    NSMutableArray * favoriteArray = [NSMutableArray array];
    NSArray * favoriteJsonArray = [contents JSONValue];
    for(NSDictionary * favoriteContentDict in favoriteJsonArray){
        MGFavorite * favorite = [self makeFavoriteFromDict:favoriteContentDict];
        [favoriteArray addObject:favorite];
    }
    return favoriteArray;
}
@end
