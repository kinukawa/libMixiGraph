//
//  MGUserDefaults.h
//  libMixiGraph
//
//  Created by kenji kinukawa on 11/02/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define REFRESH_TOKEN_KEY	@"MG_REFRESH_TOKEN"
#define ACCESS_TOKEN_KEY	@"MG_ACCESS_TOKEN"
#define EXPIRES_IN_KEY		@"MG_EXPIRES_IN"

@interface MGUserDefaults : NSObject {

}

+(void)setRefreshToken:(NSString *)data;
+(NSString *)loadRefreshToken;
+(void)removeRefreshToken;
+(void)setAccessToken:(NSString *)val;
+(NSString *)loadAccessToken;
+(void)removeAccessToken;
+(void)setExpiresIn:(NSString *)val;
+(NSString *)loadExpiresIn;
+(void)removeExpiresIn;
@end
