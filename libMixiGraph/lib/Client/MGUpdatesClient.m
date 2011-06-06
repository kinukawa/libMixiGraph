//
//  MGUpdatesClient.m
//  libMixiGraph
//
//  Created by kenji.kinukawa on 11/06/06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MGUpdatesClient.h"


@implementation MGUpdatesClient
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
                       count:(NSString *)count
                  identifier:(NSString *)identifier{
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
    //httpClientManager.identifier = @"getUserVoices";
	[httpClientManager get:@"getUserVoices" identifier:identifier url:url];
}

//////////////MGhttpClientManagerDelegate/////////////////////

-(void)mgHttpClientManager:(NSURLConnection *)conn didFailWithError:(NSError*)error{
	NSLog(@"mgUpdatesClient didFailWithError");
	if([delegate respondsToSelector:@selector(mgUpdatesClient:didFailWithError:)]){
		[delegate mgUpdatesClient:conn didFailWithError:error];
	}
}

-(void)mgHttpClientManager:(NSURLConnection *)conn didFailWithAPIError:(MGApiError*)error{
	NSLog(@"mgUpdatesClient didFailWithAPIError");
	if([delegate respondsToSelector:@selector(mgUpdatesClient:didFailWithAPIError:)]){
		[delegate mgUpdatesClient:conn didFailWithAPIError:error];
	}    
}

-(void)mgHttpClientManager:(NSURLConnection *)conn didFinishLoading:(NSDictionary *)reply{
	NSData *data = [reply objectForKey:@"data"];
    NSString *contents = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSString *identifier = [reply objectForKey:@"id"];
    NSString *method = [reply objectForKey:@"method"];
	NSLog(@"mgUpdatesClient didFinishLoading %@:%@",identifier,contents);
    
    id result = reply;
    if(method==@"getUserVoices"){
    }
    
	if([delegate respondsToSelector:@selector(mgUpdatesClient:didFinishLoading:)]){
        [delegate mgUpdatesClient:conn didFinishLoading:result];
    }
}

@end
