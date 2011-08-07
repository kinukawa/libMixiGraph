//
//  MGCheckinClient.m
//  libMixiGraph
//
//  Created by Kenji Kinukawa on 11/08/07.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "MGCheckinClient.h"

@implementation MGCheckinClient

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void) dealloc {
	[httpClientManager release];
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


@end
