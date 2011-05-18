//
//  MGVoiceClient.h
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MGClientBase.h"
#import "MGVoice.h"
#import "MGUserDefaults.h"
#import "MGHttpClient.h"
#import "JSON.h"
#import "MGApiError.h"
#import "MGUtil.h"
#import "MGParams.h"

@protocol MGVoiceClientDelegate;

@interface MGVoiceClient : MGClientBase {
@public	
	id <MGVoiceClientDelegate> delegate;
}
@property (nonatomic,assign) id delegate;

//あるユーザのつぶやき一覧の取得
-(void)getUserVoicesByUserID:(NSString *)userId 
                    trimUser:(bool)trimUser 
                 attachPhoto:(bool)attachPhoto
                  startIndex:(NSString *)startIndex
                       count:(NSString *)count
                  identifier:(NSString *)identifier;
//あるユーザのつぶやき一覧の取得
-(void)getUserVoicesByUserID:(NSString *)userId 
                trimUser:(bool)trimUser 
             attachPhoto:(bool)attachPhoto
              startIndex:(NSString *)startIndex
                   count:(NSString *)count
            usingSinceId:(NSString *)sinceId
                  identifier:(NSString *)identifier;

//友人のつぶやき一覧の取得
-(void)getFriendsVoicesByGroupID:(NSString *)groupID
                   trimUser:(bool)trimUser 
                attachPhoto:(bool)attachPhoto
                 startIndex:(NSString *)startIndex
                      count:(NSString *)count
                      identifier:(NSString *)identifier;

//友人のつぶやき一覧の取得
-(void)getFriendsVoicesByGroupID:(NSString *)groupID
                   trimUser:(bool)trimUser 
                attachPhoto:(bool)attachPhoto
                 startIndex:(NSString *)startIndex
                      count:(NSString *)count
               usingSinceId:(NSString *)sinceId
                      identifier:(NSString *)identifier;

//ある特定のつぶやき情報の取得
-(void)getVoiceInfoByPostID:(NSString *)postId
               trimUser:(bool)trimUser 
            attachPhoto:(bool)attachPhoto
                 identifier:(NSString *)identifier;

//ボイスの投稿
-(void)postVoice:(NSString*)text
      identifier:(NSString *)identifier;


//フォトボイスの投稿
-(void)postVoice:(NSString*)text withUIImage:(UIImage *)image
      identifier:(NSString *)identifier;


@end

@protocol MGVoiceClientDelegate<NSObject>
-(void)mgVoiceClient:(NSURLConnection *)conn didFailWithError:(NSError*)error;
-(void)mgVoiceClient:(NSURLConnection *)conn didFailWithAPIError:(MGApiError*)error;
-(void)mgVoiceClient:(NSURLConnection *)conn didFinishLoading:(id)result;
@end
