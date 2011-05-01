//
//  MGUtil.m
//  libMixiGraph
//
//  Created by kenji kinukawa on 11/02/21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MGUtil.h"


@implementation MGUtil
//API用のURLを生成する
+(NSURL *)buildAPIURL:(NSString*)baseURL path:(NSArray *)path query:(NSDictionary*)query{
	NSString *urlStr = baseURL;
	if (path) {
		bool first=YES;
		for(NSString * p in path){
			if(first){
				urlStr = [NSString stringWithFormat:@"%@%@",urlStr,p];
				first = NO;
			}else{
				urlStr = [NSString stringWithFormat:@"%@/%@",urlStr,p];
			}
		}
	}
	if(query){
		bool first=YES;
		for (id key in query){
			if(first){
				urlStr = [NSString stringWithFormat:@"%@?",urlStr];
				first = NO;
			}else{
				urlStr = [NSString stringWithFormat:@"%@&",urlStr];
			}
			urlStr = [NSString stringWithFormat:@"%@%@=%@",urlStr,key,[query objectForKey:key]];		 
		}
	}
	return [NSURL URLWithString:urlStr];
}

+(NSDictionary *)parsePostBody:(NSString*)param{
    if (param == nil || [param isEqualToString:@""]) {
        return nil;
    }
	NSMutableDictionary * retDict = [NSMutableDictionary dictionary];
	NSArray *paramsArr = [param componentsSeparatedByString:@"&"];
	for(NSString * q in paramsArr){
		NSArray *qArr = [q componentsSeparatedByString:@"="];
		[retDict setObject:[qArr objectAtIndex:1]
					forKey:[qArr objectAtIndex:0]];
	}
	return retDict;
}

+(NSDictionary *)parseAuthenticateHeader:(NSString*)param{
	NSMutableDictionary * retDict = [NSMutableDictionary dictionary];
	NSArray *baseArr = [param componentsSeparatedByString:@" "];
	[retDict setObject:[baseArr objectAtIndex:0] forKey:@"param"];
	NSArray *paramsArr = [[baseArr objectAtIndex:1] componentsSeparatedByString:@","];
	for(NSString * q in paramsArr){
		NSArray *qArr = [q componentsSeparatedByString:@"="];
		[retDict setObject:[[qArr objectAtIndex:1] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"'\""]]
					forKey:[qArr objectAtIndex:0]];
	}
	return retDict;
}

+(void)ShowNetworkErrorAlert{
	UIAlertView *alert =
	[[UIAlertView alloc] initWithTitle:@"ネットワークエラー" message:@"インターネットに接続することができませんでした。"
							  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

+(void)ShowAuthorizationErrorAlert{
	UIAlertView *alert =
	[[UIAlertView alloc] initWithTitle:@"認証エラー" message:@"ログインしてください。"
							  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

+(void)ShowRefreshTokenExpiredAlert{
	UIAlertView *alert =
	[[UIAlertView alloc] initWithTitle:@"認証期限が切れました" message:@"再度ログインしてください。"
							  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}
@end
