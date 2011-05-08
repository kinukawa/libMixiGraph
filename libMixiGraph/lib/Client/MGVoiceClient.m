//
//  MGVoiceClient.m
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

#import "MGVoiceClient.h"


@implementation MGVoiceClient

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

//あるユーザのつぶやき一覧の取得
-(void)getUserVoicesByUserID:(NSString *)userId 
                trimUser:(bool)trimUser 
             attachPhoto:(bool)attachPhoto
              startIndex:(NSString *)startIndex
                   count:(NSString *)count{
    NSMutableDictionary * queryDict = [NSMutableDictionary dictionary];
	if (trimUser) {
		[queryDict setObject:@"1" forKey:@"trim_user"];
	}
	if (attachPhoto) {
		[queryDict setObject:@"1" forKey:@"attach_photo"];
	}
    if (startIndex) {
		[queryDict setObject:startIndex forKey:@"startIndex"];
	} 
    if (count) {
		[queryDict setObject:count forKey:@"count"];
	}    
	NSURL * url = [MGUtil buildAPIURL:VOICE_BASE_URL
                                 path:[NSArray arrayWithObjects:
                                       userId,
                                       @"user_timeline",
                                       nil]
                                query:queryDict];
    httpClient.identifier = @"getUserVoices";
	[httpClient get:url];
}


//あるユーザのつぶやき一覧の取得
-(void)getUserVoicesByUserID:(NSString *)userId 
                trimUser:(bool)trimUser 
             attachPhoto:(bool)attachPhoto
              startIndex:(NSString *)startIndex
                   count:(NSString *)count
                 usingSinceId:(NSString *)sinceId {
    NSMutableDictionary * queryDict = [NSMutableDictionary dictionary];
	if (trimUser) {
		[queryDict setObject:@"1" forKey:@"trim_user"];
	}
	if (attachPhoto) {
		[queryDict setObject:@"1" forKey:@"attach_photo"];
	}
    if (startIndex) {
		[queryDict setObject:startIndex forKey:@"startIndex"];
	} 
    if (count) {
		[queryDict setObject:count forKey:@"count"];
	}  
    if (sinceId) {
		[queryDict setObject:sinceId forKey:@"since_id"];
	}
	NSURL * url = [MGUtil buildAPIURL:VOICE_BASE_URL
                                 path:[NSArray arrayWithObjects:
                                       userId,
                                       @"user_timeline",
                                       nil]
                                query:queryDict];
    httpClient.identifier = @"getUserVoicesUsingSinceId";
	[httpClient get:url];
}

//友人のつぶやき一覧の取得
-(void)getFriendsVoicesByGroupID:(NSString *)groupID
                   trimUser:(bool)trimUser 
                attachPhoto:(bool)attachPhoto
                 startIndex:(NSString *)startIndex
                      count:(NSString *)count{
    NSMutableDictionary * queryDict = [NSMutableDictionary dictionary];
	if (trimUser) {
		[queryDict setObject:@"1" forKey:@"trim_user"];
	}
	if (attachPhoto) {
		[queryDict setObject:@"1" forKey:@"attach_photo"];
	}
    if (startIndex) {
		[queryDict setObject:startIndex forKey:@"startIndex"];
	} 
    if (count) {
		[queryDict setObject:count forKey:@"count"];
	}    
	NSURL * url = [MGUtil buildAPIURL:VOICE_BASE_URL
                                 path:[NSArray arrayWithObjects:
                                       @"friends_timeline",
                                       groupID,
                                       nil]
                                query:queryDict];
    httpClient.identifier = @"getFriendsVoices";
	[httpClient get:url];
}

//友人のつぶやき一覧の取得
-(void)getFriendsVoicesByGroupID:(NSString *)groupID
                trimUser:(bool)trimUser 
             attachPhoto:(bool)attachPhoto
              startIndex:(NSString *)startIndex
                   count:(NSString *)count
               usingSinceId:(NSString *)sinceId {
    NSMutableDictionary * queryDict = [NSMutableDictionary dictionary];
	if (trimUser) {
		[queryDict setObject:@"1" forKey:@"trim_user"];
	}
	if (attachPhoto) {
		[queryDict setObject:@"1" forKey:@"attach_photo"];
	}
    if (sinceId) {
		[queryDict setObject:sinceId forKey:@"since_id"];
	}    
    if (startIndex) {
		[queryDict setObject:startIndex forKey:@"startIndex"];
	} 
    if (count) {
		[queryDict setObject:count forKey:@"count"];
	}    
	NSURL * url = [MGUtil buildAPIURL:VOICE_BASE_URL
                                 path:[NSArray arrayWithObjects:
                                       @"friends_timeline",
                                       groupID,
                                       nil]
                                query:queryDict];
    httpClient.identifier = @"getFriendsVoicesUsingSinceId";
	[httpClient get:url];
}

//ある特定のつぶやき情報の取得
-(void)getVoiceInfoByPostID:(NSString *)postId
               trimUser:(bool)trimUser 
            attachPhoto:(bool)attachPhoto{
    
    NSMutableDictionary * queryDict = [NSMutableDictionary dictionary];
	if (trimUser) {
		[queryDict setObject:@"1" forKey:@"trim_user"];
	}
	if (attachPhoto) {
		[queryDict setObject:@"1" forKey:@"attach_photo"];
	}
    NSURL * url = [MGUtil buildAPIURL:VOICE_BASE_URL
                                 path:[NSArray arrayWithObjects:
                                       postId,
                                       nil]
                                query:queryDict];
    httpClient.identifier = @"getVoiceInfo";
	[httpClient get:url];
}

//ボイスの投稿
-(void)postVoice:(NSString*)text{
	NSURL * url = [MGUtil buildAPIURL:VOICE_BASE_URL
                                 path:[NSArray arrayWithObjects:
                                       nil]
                                query:nil];
    NSData * body = [[[NSString stringWithFormat:@"status=%@",text] 
                      stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] 
                     dataUsingEncoding:NSUTF8StringEncoding];
    httpClient.identifier = @"postVoice";
	[httpClient post:url param:nil body:body];
}

//フォトボイスの投稿
-(void)postVoice:(NSString*)text withUIImage:(UIImage *)image{
	
	NSMutableDictionary * queryDict = [NSMutableDictionary dictionary];
	if (text) {
		[queryDict setObject:[text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"status"];
	}
	
	NSURL * url = [MGUtil buildAPIURL:VOICE_BASE_URL
                                 path:[NSArray arrayWithObjects:
                                       nil]
							  query:queryDict];
	httpClient.identifier = @"postVoice";
	[httpClient imagePost:url image:image];
}

//ボイスの削除
-(void)deleteVoiceByPostId:(NSString*)postId{
    NSURL * url = [MGUtil buildAPIURL:VOICE_BASE_URL
                                 path:[NSArray arrayWithObjects:
                                       @"destroy",
                                       postId,
                                       nil]
                                query:nil];
    httpClient.identifier = @"deleteVoiceByPostId";
	[httpClient post:url param:nil body:nil];
}

//ボイスの削除
-(void)deleteVoiceByVoice:(MGVoice*)voice{
    [self deleteVoiceByPostId:voice.postId];
}


//////////////MGHttpClientDelegate/////////////////////

-(void)mgHttpClient:(NSURLConnection *)conn didFailWithError:(NSError*)error{
	NSLog(@"MGVoiceClient didFailWithError");
	if([delegate respondsToSelector:@selector(mgVoiceClient:didFailWithError:)]){
		[delegate mgVoiceClient:conn didFailWithError:error];
	}
}

-(void)mgHttpClient:(NSURLConnection *)conn didFailWithAPIError:(MGApiError*)error{
	NSLog(@"MGVoiceClient didFailWithAPIError");
	if([delegate respondsToSelector:@selector(mgVoiceClient:didFailWithAPIError:)]){
		[delegate mgVoiceClient:conn didFailWithAPIError:error];
	}    
}

-(void)mgHttpClient:(NSURLConnection *)conn didFinishLoading:(NSMutableData *)data{
	NSString *contents = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	NSLog(@"MGVoiceClient didFinishLoading %@:%@",httpClient.identifier,contents);
    
    id result = data;
    if(httpClient.identifier==@"getUserVoices"){
        NSArray * entryArray = [contents JSONValue];
        result = [MGVoice makeContentArrayFromEntryArray:entryArray];
    }else if(httpClient.identifier==@"getUserVoicesUsingSinceId"){
        NSArray * entryArray = [contents JSONValue];
        result = [MGVoice makeContentArrayFromEntryArray:entryArray];
    }else if(httpClient.identifier==@"getFriendsVoices"){
        NSArray * entryArray = [contents JSONValue];
        result = [MGVoice makeContentArrayFromEntryArray:entryArray];
    }else if(httpClient.identifier==@"getFriendsVoicesUsingSinceId"){
        NSArray * entryArray = [contents JSONValue];
        result = [MGVoice makeContentArrayFromEntryArray:entryArray];
    }else if(httpClient.identifier==@"getVoiceInfo"){
        result = [MGVoice makeContentFromResponseData:data];
    }else if(httpClient.identifier==@"postVoice"){
        result = [MGVoice makeContentFromResponseData:data];
    }else if(httpClient.identifier==@"postPhotoVoice"){
        result = [MGVoice makeContentFromResponseData:data];
    }
    
	if([delegate respondsToSelector:@selector(mgVoiceClient:didFinishLoading:)]){
        [delegate mgVoiceClient:conn didFinishLoading:result];
    }
}

@end