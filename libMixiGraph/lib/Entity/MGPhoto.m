//
//  MGPhoto.m
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

#import "MGPhoto.h"


@implementation MGPhoto
@synthesize delegate;
@synthesize albumId;
@synthesize created;
@synthesize photoId;
@synthesize largeImageUrl;
@synthesize mimeType;
@synthesize numComments;
@synthesize numFavorites;
@synthesize thumbnailUrl;
@synthesize photoTitle;
@synthesize photoType;
@synthesize url;
@synthesize viewPageUrl;
@synthesize ownerThumbnailUrl;
@synthesize ownerId;
@synthesize ownerDisplayName;
@synthesize ownerProfileUrl;
//@synthesize ownerThumbnailImage;

-(UIImage *)ownerThumbnailImage
{
    if (ownerThumbnailImage) {
        return ownerThumbnailImage;
        
    }else{
        NSURL * otu =[NSURL URLWithString:ownerThumbnailUrl];
        NSMutableURLRequest* otReq = [[[NSMutableURLRequest alloc] initWithURL:otu] autorelease];
        NSHTTPURLResponse* otRes;
        NSError* otErr;
        NSData * otData = [NSURLConnection sendSynchronousRequest:otReq returningResponse:&otRes error:&otErr];      
        ownerThumbnailImage = [[UIImage alloc] initWithData:otData];
        return ownerThumbnailImage;        
    }
}

- (void)setOwnerThumbnailImage:(UIImage *)oti
{
    ownerThumbnailImage = oti;
    [ownerThumbnailImage retain];
}

-(UIImage *)getPhoto{
	NSURL * photoUrl =[NSURL URLWithString:self.url];
	NSMutableURLRequest* photoReq = [[[NSMutableURLRequest alloc] initWithURL:photoUrl] autorelease];
	NSHTTPURLResponse* photoRes;
	NSError* photoErr;
	NSData * photoData = [NSURLConnection sendSynchronousRequest:photoReq returningResponse:&photoRes error:&photoErr];      
	return [[[UIImage alloc] initWithData:photoData] autorelease];
}

-(id)init{
	if((self = [super init])){
		//initialize
		//commentClient = [[MGCommentClient alloc] init];
		//feedbackClient = [[MGFeedbackClient alloc] init];
		
		//commentClient.delegate = self;
		//feedbackClient.delegate = self;
	}
	return self;
}



//このフォトに、いいねをする
-(id)getFeedback{
    /*[feedbackClient getPhotoFeedbacks:self.ownerId 
                              albumId:self.albumId 
                          mediaItemId:photoId];*/
    
    NSURL * favUrl = [MGUtil buildAPIURL:@"http://api.mixi-platform.com/" 
								 path:[NSArray arrayWithObjects:
									   @"2",
									   @"photo",
									   @"favorites",
									   @"mediaItems",
									   self.ownerId,
                                       @"@self",
                                       self.albumId,
                                       self.photoId,
									   nil]
								query:nil];

	NSMutableURLRequest* req = [[[NSMutableURLRequest alloc] initWithURL:favUrl] autorelease];
	NSHTTPURLResponse* res;
	NSError* err;
	NSData * favData = [NSURLConnection sendSynchronousRequest:req returningResponse:&res error:&err];      
	return [[[UIImage alloc] initWithData:favData] autorelease];
}

-(void)mgFeedbackClient:(NSURLConnection *)conn didFinishGetting:(NSArray *)feedbackArray{
    if([delegate respondsToSelector:@selector(mgPhoto:didFinishGettingFeedbacks:)]){
		[delegate mgPhoto:conn didFinishGettingFeedbacks:feedbackArray];
	}
}

-(void)mgFeedbackClient:(NSURLConnection *)conn didFinishPosting:(id)reply{
    NSString *contents = [[[NSString alloc] initWithData:reply encoding:NSUTF8StringEncoding] autorelease];
	if([delegate respondsToSelector:@selector(mgPhoto:didFinishPostingFeedback:)]){
		[delegate mgPhoto:conn didFinishPostingFeedback:contents];
	}
}

-(void)mgFeedbackClient:(NSURLConnection *)conn didReceiveResponseError:(MGApiError *)error{
    
}

- (void) dealloc {
	//[commentClient release];
	//[feedbackClient release];
	[super dealloc];
}

@end
