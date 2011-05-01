//
//  MGPhoto.h
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "MGCommentClient.h"
#import "MGComment.h"
#import "MGFavorite.h"

@protocol MGPhotoDelegate;

@interface MGPhoto : NSObject {
    id <MGPhotoDelegate> delegate;
	NSString * albumId;
	NSString * created;
	NSString * photoId;
	NSString * largeImageUrl;
	NSString * mimeType;
	NSString * numComments;
	NSString * numFavorites;
	NSString * thumbnailUrl;
	NSString * photoTitle;
	NSString * photoType;
	NSString * url;
	NSString * viewPageUrl;
	NSString * ownerThumbnailUrl;
	NSString * ownerId;
	NSString * ownerDisplayName;
	NSString * ownerProfileUrl;
    UIImage * ownerThumbnailImage;
@private
	//MGCommentClient * commentClient;
	//MGFeedbackClient * feedbackClient;

}
-(UIImage *)getPhoto;
//-(void)postFeedback;
-(id)getFeedback;

@property (nonatomic,assign) id delegate;

@property (nonatomic,retain) NSString * albumId;
@property (nonatomic,retain) NSString * created;
@property (nonatomic,retain) NSString * photoId;
@property (nonatomic,retain) NSString * largeImageUrl;
@property (nonatomic,retain) NSString * mimeType;
@property (nonatomic,retain) NSString * numComments;
@property (nonatomic,retain) NSString * numFavorites;
@property (nonatomic,retain) NSString * thumbnailUrl;
@property (nonatomic,retain) NSString * photoTitle;
@property (nonatomic,retain) NSString * photoType;
@property (nonatomic,retain) NSString * url;
@property (nonatomic,retain) NSString * viewPageUrl;
@property (nonatomic,retain) NSString * ownerThumbnailUrl;
@property (nonatomic,retain) NSString * ownerId;
@property (nonatomic,retain) NSString * ownerDisplayName;
@property (nonatomic,retain) NSString * ownerProfileUrl;
@property (nonatomic,retain) UIImage * ownerThumbnailImage;

@end

@protocol MGPhotoDelegate<NSObject>
//-(void)mgVoice:(NSURLConnection *)conn didReceiveResponseError:(NSString *)error;
//-(void)mgVoiceClient:(NSURLConnection *)conn didFailWithError:(NSError*)error;
-(void)mgPhoto:(NSURLConnection *)conn didFinishGettingComments:(NSArray *)commentArray;
-(void)mgPhoto:(NSURLConnection *)conn didFinishPostingComment:(id)reply;
-(void)mgPhoto:(NSURLConnection *)conn didFinishGettingFeedbacks:(NSArray *)feedbackArray;
-(void)mgPhoto:(NSURLConnection *)conn didFinishPostingFeedback:(id)reply;
//-(void)mgVoiceClient:(NSURLConnection *)conn didFinishPosting:(MGVoice *)voice;
@end
