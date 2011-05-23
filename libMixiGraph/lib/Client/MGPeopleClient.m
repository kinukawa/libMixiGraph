//
//  MGPeopleClient.m
//  Picxi
//
//  Created by kinukawa on 11/02/26.
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

#import "MGPeopleClient.h"


@implementation MGPeopleClient
@synthesize delegate;

-(id)init{
	if((self = [super init])){
		//initialize
	}
	return self;
}

- (void) dealloc {
	[super dealloc];
}

//友人一覧の取得
-(void)getFriendsByUserId:(NSString *)userId
                  groupId:(NSString *)groupId
                   sortBy:(NSString *)displayName 
                sortOrder:(NSString *)sortOrder
                   fields:(NSString *)fields
               startIndex:(NSString *)startIndex
                    count:(NSString *)count
               identifier:(NSString *)identifier{
    NSMutableDictionary * queryDict = [NSMutableDictionary dictionary];
	if(displayName){
		[queryDict setObject:displayName forKey:@"sortBy"];
	}
	if(sortOrder){
		[queryDict setObject:sortOrder forKey:@"sortOrder"];
	}
    if (startIndex) {
		[queryDict setObject:startIndex forKey:@"startIndex"];
	} 
    if (count) {
		[queryDict setObject:count forKey:@"count"];
	} 
    if (fields) {
		[queryDict setObject:fields forKey:@"fields"];
	} 
    NSURL * url = [MGUtil buildAPIURL:PEOPLE_BASE_URL
                                 path:[NSArray arrayWithObjects:
                                       userId,
                                       groupId,
                                       nil]
                                query:queryDict];
    
	//httpClient.identifier = @"getFriendsByUserId";
    [httpClientManager get:@"getFriendsByUserId" identifier:identifier url:url];
}

//自分の友人一欄取得
-(void)getMyFriendsWithSortBy:(NSString *)displayName 
                    sortOrder:(NSString *)sortOrder
                       fields:(NSString *)fields
                   startIndex:(NSString *)startIndex
                        count:(NSString *)count
                   identifier:(NSString *)identifier{

    [self getFriendsByUserId:@"@me" 
                     groupId:@"@friends" 
                      sortBy:displayName 
                   sortOrder:sortOrder 
                      fields:(NSString *)fields
                  startIndex:startIndex 
                       count:count
                  identifier:identifier];
}

-(void)getMyProfileWithFields:(NSString *)fields
                   identifier:(NSString *)identifier{

    [self getFriendsByUserId:@"@me" 
                     groupId:@"@self" 
                      sortBy:nil 
                   sortOrder:nil 
                      fields:(NSString *)fields
                  startIndex:0 
                       count:0
                  identifier:@"getMyProfileWithFields"];
    NSMutableDictionary * queryDict = [NSMutableDictionary dictionary];
    [queryDict setObject:0 forKey:@"startIndex"];
    [queryDict setObject:0 forKey:@"count"];
    if (fields) {
		[queryDict setObject:fields forKey:@"fields"];
	} 
    NSURL * url = [MGUtil buildAPIURL:PEOPLE_BASE_URL
                                 path:[NSArray arrayWithObjects:
                                       @"@me",
                                       @"@self",
                                       nil]
                                query:queryDict];
    
	[httpClientManager get:@"getMyProfileWithFields" identifier:identifier url:url];

}


///////////////////
-(void)mgHttpClientManager:(NSURLConnection *)conn didFailWithError:(NSError*)error{
	NSLog(@"MGPeopleClient didFailWithError");
	if([delegate respondsToSelector:@selector(mgVoiceClient:didFailWithError:)]){
		[delegate mgPeopleClient:conn didFailWithError:error];
	}
}

-(void)mgHttpClientManager:(NSURLConnection *)conn didFailWithAPIError:(MGApiError*)error{
	NSLog(@"MGPeopleClient didFailWithAPIError");
	if([delegate respondsToSelector:@selector(mgVoiceClient:didFailWithAPIError:)]){
		[delegate mgPeopleClient:conn didFailWithAPIError:error];
	}    
}

-(void)mgHttpClientManager:(NSURLConnection *)conn didFinishLoading:(NSDictionary *)reply{
	NSData *data = [reply objectForKey:@"data"];
    NSString *contents = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSString *identifier = [reply objectForKey:@"id"];
    NSString *method = [reply objectForKey:@"method"];
	NSLog(@"MGPeopleClient didFinishLoading %@:%@",identifier,contents);
    id result = reply;
    if(method==@"getMyFriendsWithSortBy"){
        NSDictionary * jsonDict = [contents JSONValue];
        NSArray * peopleArray = [MGPeople makeContentArrayFromEntryArray:[jsonDict objectForKey:@"entry"]];
        NSDictionary * responseDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                       peopleArray,@"data",
                                       [jsonDict objectForKey:@"itemsPerPage"], @"itemsPerPage", 
                                       [jsonDict objectForKey:@"startIndex"], @"startIndex", 
                                       [jsonDict objectForKey:@"totalResults"], @"totalResults",
                                       identifier,@"id",
                                       nil];
        result = responseDict;
        //result = [MGVoice makeVoiceArrayFromResponseData:data];
    }else if(method==@"getMyProfileWithFields"){
        result = [NSDictionary dictionaryWithObjectsAndKeys:
                  [MGPeople makeContentFromResponseData:data],@"data",
                  identifier,@"id",nil];

    }
    
    
	if([delegate respondsToSelector:@selector(mgPeopleClient:didFinishLoading:)]){
        [delegate mgPeopleClient:conn didFinishLoading:result];
    }
}

@end
