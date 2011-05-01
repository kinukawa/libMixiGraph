//
//  MGUserDefaults.m
//  libMixiGraph
//
//  Created by kenji kinukawa on 11/02/17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MGUserDefaults.h"


@implementation MGUserDefaults



+(void)setUserDefault:(NSString *)key
				 value:(NSString*)val{
	NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];	
	[defaults setObject:val forKey:key];
}

+(NSString *)loadUserDefault:(NSString *)key{
	NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];	
	return [defaults stringForKey:key];
}

+(void)removeUserDefault:(NSString *)key{
	NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];	
	[defaults removeObjectForKey:key];
}

+(void)setRefreshToken:(NSString *)val{
	[self setUserDefault:REFRESH_TOKEN_KEY value:val];
}

+(NSString *)loadRefreshToken{
	return [self loadUserDefault:REFRESH_TOKEN_KEY];
}

+(void)removeRefreshToken{
	[self removeUserDefault:REFRESH_TOKEN_KEY];
}

+(void)setAccessToken:(NSString *)val{
	[self setUserDefault:ACCESS_TOKEN_KEY value:val];
}

+(NSString *)loadAccessToken{
	return [self loadUserDefault:ACCESS_TOKEN_KEY];
}

+(void)removeAccessToken{
	[self removeUserDefault:ACCESS_TOKEN_KEY];
}

+(void)setExpiresIn:(NSString *)val{
	[self setUserDefault:EXPIRES_IN_KEY value:val];
}

+(NSString *)loadExpiresIn{
	return [self loadUserDefault:EXPIRES_IN_KEY];
}

+(void)removeExpiresIn{
	[self removeUserDefault:EXPIRES_IN_KEY];
}


@end
