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
                      count:(int)count{
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
    httpClient.identifier = @"getAlbumListByUserId";
	[httpClient get:url];
	
}

//最近グループメンバーが作成したアルバム一覧の取得
-(void)getRecentCreatedAlbumListByGroupId:(NSString*)groupId 
                                 startIndex:(int)startIndex
                                      count:(int)count{
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
    httpClient.identifier = @"getRecentCreatedAlbumListByUserId";
	[httpClient get:url];
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
                      count:(int)count{
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
    httpClient.identifier = @"getPhotoListByUserId";
	[httpClient get:url];
}

//あるフォトの情報を取得
-(void)getPhotoByUserId:(NSString*)userId 
                albumId:(NSString*)albumId
            mediaItemId:(NSString*)mediaItemId
              accessKey:(NSString*)accessKey
             startIndex:(int)startIndex
                  count:(int)count{
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
    httpClient.identifier = @"getPhotoByUserId";
	[httpClient get:url];
}

//最近グループメンバーが作成したフォト一覧の取得
-(void)getRecentCreatedPhotoListByGroupId:(NSString*)groupId 
                               startIndex:(int)startIndex
                                    count:(int)count{
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
    httpClient.identifier = @"getRecentCreatedPhotoListByGroupId";
	[httpClient get:url];
}

//最近友人が作成したフォト一覧の取得
-(void)getRecentCreatedFriendsPhotoListWithStartIndex:(int)startIndex count:(int)count{
    [self getRecentCreatedPhotoListByGroupId:@"@friends" startIndex:startIndex count:count];
}

//アルバム作成
-(void)makeAlbumWithTitle:(NSString *)title 
              description:(NSString *)description
               visibility:(NSString *)visibility
                accessKey:(NSString *)accessKey {
    
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
    self.httpClient.identifier = @"makeAlbum";
	[self.httpClient post:requestUrl param:nil body:body];
} 

//フォト投稿
-(void)postPhoto:(UIImage *)image 
         albumId:(NSString *)albumId 
           title:(NSString *)title {
    
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
    httpClient.identifier = @"postPhoto";
	[httpClient imagePost:requestUrl image:image];
} 


//////////////MGHttpClientDelegate/////////////////////

-(void)mgHttpClient:(NSURLConnection *)conn didFailWithError:(NSError*)error{
	NSLog(@"mgPhotoClient didFailWithError");
	if([delegate respondsToSelector:@selector(mgPhotoClient:didFailWithError:)]){
		[delegate mgPhotoClient:conn didFailWithError:error];
	}
}

-(void)mgHttpClient:(NSURLConnection *)conn didFailWithAPIError:(MGApiError*)error{
	NSLog(@"mgPhotoClient didFailWithAPIError");
	if([delegate respondsToSelector:@selector(mgPhotoClient:didFailWithAPIError:)]){
		[delegate mgPhotoClient:conn didFailWithAPIError:error];
	}    
}

-(void)mgHttpClient:(NSURLConnection *)conn didFinishLoading:(NSMutableData *)data{
	NSString *contents = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	NSLog(@"mgPhotoClient didFinishLoading %@:%@",httpClient.identifier,contents);
    
    id result = data;
    
    if([self.httpClient.identifier isEqualToString:@"getAlbumListByUserId"] || 
       [self.httpClient.identifier isEqualToString:@"getRecentCreatedAlbumListByUserId"]){
        NSDictionary * entryDict = [contents JSONValue];
        NSArray * albumArray = [MGAlbum makeContentArrayFromEntryArray:[entryDict objectForKey:@"entry"]];        
        NSDictionary * responseDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                       albumArray,@"entry",
                                       [entryDict objectForKey:@"itemsPerPage"], @"itemsPerPage", 
                                       [entryDict objectForKey:@"startIndex"], @"startIndex", 
                                       [entryDict objectForKey:@"totalResults"], @"totalResults", 
                                       nil];
        result = responseDict;
    }else if([self.httpClient.identifier isEqualToString:@"getPhotoListByUserId"] ||
             [self.httpClient.identifier isEqualToString:@"getRecentCreatedPhotoListByGroupId"]){
        NSDictionary * entryDict = [contents JSONValue];
        NSArray * photoArray = [MGPhoto makeContentArrayFromEntryArray:[entryDict objectForKey:@"entry"]];        
        NSDictionary * responseDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                       photoArray,@"entry",
                                       [entryDict objectForKey:@"itemsPerPage"], @"itemsPerPage", 
                                       [entryDict objectForKey:@"startIndex"], @"startIndex", 
                                       [entryDict objectForKey:@"totalResults"], @"totalResults", 
                                       nil];
        result = responseDict;
    }else if([self.httpClient.identifier isEqualToString:@"getPhotoByUserId"]){
        NSDictionary * entryDict = [contents JSONValue];
        NSArray * photoArray = [MGPhoto makeContentArrayFromEntryArray:[entryDict objectForKey:@"entry"]];        
        NSDictionary * responseDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                       [photoArray objectAtIndex:0],@"entry",
                                       [entryDict objectForKey:@"itemsPerPage"], @"itemsPerPage", 
                                       [entryDict objectForKey:@"startIndex"], @"startIndex", 
                                       [entryDict objectForKey:@"totalResults"], @"totalResults", 
                                       nil];
        result = responseDict;
    }else if([self.httpClient.identifier isEqualToString:@"makeAlbum"]){
        result = [contents JSONValue];
    }else if([self.httpClient.identifier isEqualToString:@"postPhoto"]){
        result = [contents JSONValue];
    }
    
	if([delegate respondsToSelector:@selector(mgPhotoClient:didFinishLoading:)]){
        [delegate mgPhotoClient:conn didFinishLoading:result];
    }
}

@end
