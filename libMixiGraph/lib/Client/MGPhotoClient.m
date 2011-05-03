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

//最近友人が作成したアルバム一覧の取得
-(void)getRecentCreatedMyAlbumListByGroupId:(NSString*)groupId 
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


//マイミクのフォトを取得
-(void)getFriendsRecentPhotos:(NSString*)groupID{
	
	NSURL * url = [MGUtil buildAPIURL:PHOTO_BASE_URL
							   path:[NSArray arrayWithObjects:
									 @"mediaItems",
									 @"@me",
									 groupID,
									 nil]
							  query:nil];
	[httpClient get:url];
	
}

//すべてのマイミクのフォトを取得
-(void)getAllFriendsRecentPhotos{
	[self getFriendsRecentPhotos:@"@friends"];
}

//フォトの投稿
-(void)postPhoto:(UIImage *)photo userId:(NSString*)userId albumId:(NSString *)albumId title:(NSString*)title{
	
	NSMutableDictionary * queryDict = [NSMutableDictionary dictionary];
	if (title) {
		[queryDict setObject:[title stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"title"];
	}
	
	NSURL * url = [MGUtil buildAPIURL:@"http://api.mixi-platform.com/" 
							   path:[NSArray arrayWithObjects:
									 @"2",
									 @"photo",
									 @"mediaItems",
									 userId,
									 @"@self",
									 albumId,
									 nil]
							  query:queryDict];
	
	
	[httpClient imagePost:url image:photo];
}

//自分の簡単公開アルバムにフォトを投稿
-(void)postPhotoToMyEasyAlbum:(UIImage *)photo title:(NSString*)title{
    [self postPhoto:photo userId:@"@me" albumId:@"@default" title:title];
}

//アルバムの作成
-(void)makeAlbum:(NSString*)userId title:(NSString*)title body:(NSString*)body visibility:(NSString *)visibility accessKey:(NSString *)accessKey{
	NSURL * url = [MGUtil buildAPIURL:@"http://api.mixi-platform.com/" 
							   path:[NSArray arrayWithObjects:
									 @"2",
									 @"photo",
									 @"albums",
									 @"@me",
									 @"@self",
									 nil]
							  query:nil];
    
    NSString * json;
    if(accessKey){
        json = [NSString stringWithFormat:@"{\"title\":\"%@\",\"description\":\"%@\",\"privacy\":{\"visibility\":\"%@\",\"accessKey\":\"%@\"}}",title,body,visibility,accessKey];
	}else{
        json = [NSString stringWithFormat:@"{\"title\":\"%@\",\"description\":\"%@\",\"privacy\":{\"visibility\":\"%@\"}}",title,body,visibility,accessKey];
	}
    NSLog(@"%@",json);
	NSData * postData = [json dataUsingEncoding:NSUTF8StringEncoding];
	[httpClient post:url param:[NSDictionary dictionaryWithObjectsAndKeys:
								@"application/json",@"Content-type",nil] body:postData];
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
    }/*else if(httpClient.identifier==@"requestUserVoicesUsingSinceId"){
        NSArray * entryArray = [contents JSONValue];
        result = [MGVoice makeContentArrayFromEntryArray:entryArray];
    }else if(httpClient.identifier==@"requestFriendsVoices"){
        NSArray * entryArray = [contents JSONValue];
        result = [MGVoice makeContentArrayFromEntryArray:entryArray];
    }else if(httpClient.identifier==@"requestFriendsVoicesUsingSinceId"){
        NSArray * entryArray = [contents JSONValue];
        result = [MGVoice makeContentArrayFromEntryArray:entryArray];
    }else if(httpClient.identifier==@"requestVoiceInfo"){
        result = [MGVoice makeContentFromResponseData:data];
    }else if(httpClient.identifier==@"requestPostVoice"){
        result = [MGVoice makeContentFromResponseData:data];
    }else if(httpClient.identifier==@"requestPostPhotoVoice"){
        result = [MGVoice makeContentFromResponseData:data];
    }
    */
	if([delegate respondsToSelector:@selector(mgPhotoClient:didFinishLoading:)]){
        [delegate mgPhotoClient:conn didFinishLoading:result];
    }
}

/*
 -(void)mgHttpClient:(NSURLConnection *)conn didFinishLoadingGet:(NSMutableData *)data{
	NSLog(@"didFinishLoading");
	
	NSString *contents = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	if([delegate respondsToSelector:@selector(MGPhotoClient:didFinishGetting:)]){
		
	
		NSDictionary * jsonDict = [contents JSONValue];
		NSArray * entries = [jsonDict objectForKey:@"entry"];
		NSMutableArray * photos = [NSMutableArray array];
		
		for(NSDictionary * entry in entries){
			NSLog(@"%@",entry);
			MGPhoto * photo = [[[MGPhoto alloc]init]autorelease];
	
			photo.albumId			= [entry objectForKey:@"albumId"];
			photo.created			= [entry objectForKey:@"created"];
			photo.photoId			= [entry objectForKey:@"id"];
			photo.largeImageUrl		= [entry objectForKey:@"largeImageUrl"];
			photo.mimeType			= [entry objectForKey:@"mimeType"];
			photo.numComments		= [entry objectForKey:@"numComments"];
			photo.numFavorites		= [entry objectForKey:@"numFavorites"];
			photo.thumbnailUrl		= [entry objectForKey:@"thumbnailUrl"];
			photo.photoTitle		= [entry objectForKey:@"title"];
			photo.photoType			= [entry objectForKey:@"type"];
			photo.url				= [entry objectForKey:@"url"];
			photo.viewPageUrl		= [entry objectForKey:@"viewPageUrl"];
			NSDictionary * owner	= [entry objectForKey:@"owner"];
			photo.ownerThumbnailUrl = [owner objectForKey:@"thumbnailUrl"];
			photo.ownerId			= [owner objectForKey:@"id"];
			photo.ownerDisplayName	= [owner objectForKey:@"displayName"];
			photo.ownerProfileUrl	= [owner objectForKey:@"profileUrl"];
			
			[photos addObject:photo];
		}
		
		[delegate MGPhotoClient:conn didFinishGetting:photos];
	}

}

-(void)mgHttpClient:(NSURLConnection *)conn didFinishLoadingPost:(NSMutableData *)data{
	NSLog(@"didFinishLoading");
	NSString *contents = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
	
	if([delegate respondsToSelector:@selector(MGPhotoClient:didFinishPosting:)]){
		[delegate MGPhotoClient:conn didFinishPosting:contents];
	}
}
*/

@end
