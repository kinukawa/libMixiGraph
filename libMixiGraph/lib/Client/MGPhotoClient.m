//
//  MGPhotoClient.m
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

#import "MGPhotoClient.h"


@implementation MGPhotoClient
@synthesize delegate;

-(id)init{
	if((self = [super init])){
		//initialize
	}
	return self;
}

- (void) dealloc {
    self.delegate = nil;
	[super dealloc];
}

//アルバム一覧の取得
-(void)getAlbumListByUserId:(NSString*)userId 
                withAlbumId:(NSString*)albumId 
                 startIndex:(int)startIndex
                      count:(int)count
                 identifier:(NSString *)identifier{
	NSMutableDictionary * queryDict = [NSMutableDictionary dictionary];
    if (startIndex>0) {
		[queryDict setObject:[NSString stringWithFormat:@"%d",startIndex] forKey:@"startIndex"];
	} 
    if (count>0) {
		[queryDict setObject:[NSString stringWithFormat:@"%d",count] forKey:@"count"];
	}   
	NSURL * url = [MGUtil buildAPIURL:PHOTO_BASE_URL
                                 path:[NSArray arrayWithObjects:
                                       @"albums",
                                       userId,
                                       @"@self",
                                       albumId,
                                       nil]
                                query:queryDict];
    //httpClientManager.identifier = @"getAlbumListByUserId";
	[httpClientManager get:@"getAlbumListByUserId" identifier:identifier url:url];
	
}

//最近グループメンバーが作成したアルバム一覧の取得
-(void)getRecentCreatedAlbumListByGroupId:(NSString*)groupId 
                                 startIndex:(int)startIndex
                                      count:(int)count
                               identifier:(NSString *)identifier{

	NSMutableDictionary * queryDict = [NSMutableDictionary dictionary];
    if (startIndex>0) {
		[queryDict setObject:[NSString stringWithFormat:@"%d",startIndex] forKey:@"startIndex"];
	} 
    if (count>0) {
		[queryDict setObject:[NSString stringWithFormat:@"%d",count] forKey:@"count"];
	}   
	NSURL * url = [MGUtil buildAPIURL:PHOTO_BASE_URL
                                 path:[NSArray arrayWithObjects:
                                       @"albums",
                                       @"@me",
                                       groupId,
                                       nil]
                                query:queryDict];
    //httpClientManager.identifier = @"getRecentCreatedAlbumListByUserId";
	[httpClientManager get:@"getRecentCreatedAlbumListByUserId" identifier:identifier url:url];
}

//最近友人が作成したアルバム一覧の取得
-(void)getRecentCreatedFriendsAlbumListWithStartIndex:(int)startIndex count:(int)count{
    [self getRecentCreatedAlbumListByGroupId:@"@friends" startIndex:startIndex count:count];
}

//あるアルバムに登録されているフォトの一覧を取得
-(void)getPhotoListByUserId:(NSString*)userId 
                    albumId:(NSString*)albumId
                  accessKey:(NSString*)accessKey
                 startIndex:(int)startIndex
                      count:(int)count
                 identifier:(NSString *)identifier{

	NSMutableDictionary * queryDict = [NSMutableDictionary dictionary];
    if (accessKey) {
		[queryDict setObject:accessKey forKey:@"accessKey"];
	} 
    if (startIndex>0) {
		[queryDict setObject:[NSString stringWithFormat:@"%d",startIndex] forKey:@"startIndex"];
	} 
    if (count>0) {
		[queryDict setObject:[NSString stringWithFormat:@"%d",count] forKey:@"count"];
	}   
	NSURL * url = [MGUtil buildAPIURL:PHOTO_BASE_URL
                                 path:[NSArray arrayWithObjects:
                                       @"mediaItems",
                                       userId,
                                       @"@self",
                                       albumId,
                                       nil]
                                query:queryDict];
    //httpClientManager.identifier = @"getPhotoListByUserId";
	[httpClientManager get:@"getPhotoListByUserId" identifier:identifier url:url];
}

//あるフォトの情報を取得
-(void)getPhotoByUserId:(NSString*)userId 
                albumId:(NSString*)albumId
            mediaItemId:(NSString*)mediaItemId
              accessKey:(NSString*)accessKey
             startIndex:(int)startIndex
                  count:(int)count
             identifier:(NSString *)identifier{

	NSMutableDictionary * queryDict = [NSMutableDictionary dictionary];
    if (accessKey) {
		[queryDict setObject:accessKey forKey:@"accessKey"];
	} 
    if (startIndex>0) {
		[queryDict setObject:[NSString stringWithFormat:@"%d",startIndex] forKey:@"startIndex"];
	} 
    if (count>0) {
		[queryDict setObject:[NSString stringWithFormat:@"%d",count] forKey:@"count"];
	}   
	NSURL * url = [MGUtil buildAPIURL:PHOTO_BASE_URL
                                 path:[NSArray arrayWithObjects:
                                       @"mediaItems",
                                       userId,
                                       @"@self",
                                       albumId,
                                       mediaItemId,
                                       nil]
                                query:queryDict];
    //httpClientManager.identifier = @"getPhotoByUserId";
	[httpClientManager get:@"getPhotoByUserId" identifier:identifier url:url];
}

//最近グループメンバーが作成したフォト一覧の取得
-(void)getRecentCreatedPhotoListByGroupId:(NSString*)groupId 
                               startIndex:(int)startIndex
                                    count:(int)count
                               identifier:(NSString *)identifier{

	NSMutableDictionary * queryDict = [NSMutableDictionary dictionary];
    if (startIndex>0) {
		[queryDict setObject:[NSString stringWithFormat:@"%d",startIndex] forKey:@"startIndex"];
	} 
    if (count>0) {
		[queryDict setObject:[NSString stringWithFormat:@"%d",count] forKey:@"count"];
	}   
	NSURL * url = [MGUtil buildAPIURL:PHOTO_BASE_URL
                                 path:[NSArray arrayWithObjects:
                                       @"mediaItems",
                                       @"@me",
                                       groupId,
                                       nil]
                                query:queryDict];
    //httpClientManager.identifier = @"getRecentCreatedPhotoListByGroupId";
	[httpClientManager get:@"getRecentCreatedPhotoListByGroupId" identifier:identifier url:url];
}

//最近友人が作成したフォト一覧の取得
-(void)getRecentCreatedFriendsPhotoListWithStartIndex:(int)startIndex count:(int)count{
    [self getRecentCreatedPhotoListByGroupId:@"@friends" startIndex:startIndex count:count];
}

//アルバム作成
-(void)makeAlbumWithTitle:(NSString *)title 
              description:(NSString *)description
               visibility:(NSString *)visibility
                accessKey:(NSString *)accessKey
               identifier:(NSString *)identifier{

    
    NSMutableDictionary * bodyDict = [NSMutableDictionary dictionary];
	if (title) {
		[bodyDict setObject:title forKey:@"title"];
	}
    if (description) {
		[bodyDict setObject:description forKey:@"description"];
	}
    if (visibility) {
		[bodyDict setObject:visibility forKey:@"visibility"];
	}
    if (accessKey) {
		[bodyDict setObject:accessKey forKey:@"accessKey"];
	}
    NSURL * requestUrl = [MGUtil buildAPIURL:PHOTO_BASE_URL
                                        path:[NSArray arrayWithObjects:
                                              @"albums",
                                              @"@me",
                                              @"@self",
                                              nil]
                                       query:nil];
    NSString * bodyStr = [MGUtil buildPostBodyByDictionary:bodyDict];
    NSData * body = [bodyStr 
                     dataUsingEncoding:NSUTF8StringEncoding];
    //self.httpClientManager.identifier = @"makeAlbum";
	[self.httpClientManager post:@"makeAlbum" identifier:identifier url:requestUrl param:nil body:body];
} 

//フォト投稿
-(void)postPhoto:(UIImage *)image 
         albumId:(NSString *)albumId 
           title:(NSString *)title 
      identifier:(NSString *)identifier{

    
    NSMutableDictionary * queryDict = [NSMutableDictionary dictionary];
	if (title) {
		[queryDict setObject:title forKey:@"title"];
	}
    
    NSURL * requestUrl = [MGUtil buildAPIURL:PHOTO_BASE_URL
                                        path:[NSArray arrayWithObjects:
                                              @"mediaItems",
                                              @"@me",
                                              @"@self",
                                              albumId,
                                              nil]
                                       query:queryDict];
    //httpClientManager.identifier = @"postPhoto";
	[httpClientManager imagePost:@"postPhoto" identifier:identifier url:requestUrl image:image];
} 


//////////////MGHttpClientDelegate/////////////////////

-(void)mgHttpClientManager:(NSURLConnection *)conn didFailWithError:(NSError*)error{
	NSLog(@"mgPhotoClient didFailWithError");
	if([delegate respondsToSelector:@selector(mgPhotoClient:didFailWithError:)]){
		[delegate mgPhotoClient:conn didFailWithError:error];
	}
}

-(void)mgHttpClientManager:(NSURLConnection *)conn didFailWithAPIError:(MGApiError*)error{
	NSLog(@"mgPhotoClient didFailWithAPIError");
	if([delegate respondsToSelector:@selector(mgPhotoClient:didFailWithAPIError:)]){
		[delegate mgPhotoClient:conn didFailWithAPIError:error];
	}    
}

-(void)mgHttpClientManager:(NSURLConnection *)conn didFinishLoading:(NSDictionary *)reply{
    NSData *data = [reply objectForKey:@"data"];
    NSString *contents = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSString *identifier = [reply objectForKey:@"id"];
    NSString *method = [reply objectForKey:@"method"];
	NSLog(@"MGPhotoClient didFinishLoading %@:%@",identifier,contents);
    
    id result = reply;
    
    if([method isEqualToString:@"getAlbumListByUserId"] || 
       [method isEqualToString:@"getRecentCreatedAlbumListByUserId"]){

        NSDictionary * entryDict = [contents JSONValue];
        NSArray * albumArray = [MGAlbum makeContentArrayFromEntryArray:[entryDict objectForKey:@"entry"]];        
        result = [NSDictionary dictionaryWithObjectsAndKeys:
                  albumArray,@"data",
                                       [entryDict objectForKey:@"itemsPerPage"], @"itemsPerPage", 
                                       [entryDict objectForKey:@"startIndex"], @"startIndex", 
                                       [entryDict objectForKey:@"totalResults"], @"totalResults",
                                       identifier,@"id",
                                       nil];
    }else if([method isEqualToString:@"getPhotoListByUserId"] ||
             [method isEqualToString:@"getRecentCreatedPhotoListByGroupId"]){
        NSDictionary * entryDict = [contents JSONValue];
        NSArray * photoArray = [MGPhoto makeContentArrayFromEntryArray:[entryDict objectForKey:@"entry"]];        
        result = [NSDictionary dictionaryWithObjectsAndKeys:
                                       photoArray,@"data",
                                       [entryDict objectForKey:@"itemsPerPage"], @"itemsPerPage", 
                                       [entryDict objectForKey:@"startIndex"], @"startIndex", 
                                       [entryDict objectForKey:@"totalResults"], @"totalResults", 
                                       identifier,@"id",
                                       nil];
    }else if([method isEqualToString:@"getPhotoByUserId"]){
        NSDictionary * entryDict = [contents JSONValue];
        NSArray * photoArray = [MGPhoto makeContentArrayFromEntryArray:[entryDict objectForKey:@"entry"]];        
        result = [NSDictionary dictionaryWithObjectsAndKeys:
                                       [photoArray objectAtIndex:0],@"data",
                                       [entryDict objectForKey:@"itemsPerPage"], @"itemsPerPage", 
                                       [entryDict objectForKey:@"startIndex"], @"startIndex", 
                                       [entryDict objectForKey:@"totalResults"], @"totalResults", 
                                       identifier,@"id",
                                       nil];
    }else if([method isEqualToString:@"makeAlbum"]){
        result = [NSDictionary dictionaryWithObjectsAndKeys:
                                       [contents JSONValue],@"data",
                                       identifier,@"id",
                                       nil];
    }else if([method isEqualToString:@"postPhoto"]){
        result = [NSDictionary dictionaryWithObjectsAndKeys:
                  [contents JSONValue],@"data",
                  identifier,@"id",
                  nil];
    }
    
	if([delegate respondsToSelector:@selector(mgPhotoClient:didFinishLoading:)]){
        [delegate mgPhotoClient:conn didFinishLoading:result];
    }
}

@end
