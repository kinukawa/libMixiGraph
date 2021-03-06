//
//  MGPeopleClient.h
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

#import <Foundation/Foundation.h>
#import "MGClientBase.h"
#import "MGUtil.h"
#import "MGParams.h"
#import "JSON.h"
#import "MGPeople.h"

@protocol MGPeopleClientDelegate;

@interface MGPeopleClient : MGClientBase {
@public	
	id <MGPeopleClientDelegate> delegate;
}

//-(void)getMyProfile:(bool)status;

//自分の友人一覧取得
-(void)getFriendsByUserId:(NSString *)userId
                  groupId:(NSString *)groupId
                   sortBy:(NSString *)displayName 
                sortOrder:(NSString *)sortOrder
                   fields:(NSString *)fields
               startIndex:(NSString *)startIndex
                    count:(NSString *)count
               identifier:(NSString *)identifier;
    
//自分の友人一欄取得
-(void)getMyFriendsWithSortBy:(NSString *)displayName 
                    sortOrder:(NSString *)sortOrder
                       fields:(NSString *)fields
                   startIndex:(NSString *)startIndex
                        count:(NSString *)count
                   identifier:(NSString *)identifier;

-(void)getMyProfileWithFields:(NSString *)fields
                   identifier:(NSString *)identifier;

@property (nonatomic,assign) id delegate;

@end

@protocol MGPeopleClientDelegate<NSObject>
-(void)mgPeopleClient:(NSURLConnection *)conn didFailWithError:(NSError*)error;
-(void)mgPeopleClient:(NSURLConnection *)conn didFailWithAPIError:(MGApiError*)error;
-(void)mgPeopleClient:(NSURLConnection *)conn didFinishLoading:(id)result;
@end
