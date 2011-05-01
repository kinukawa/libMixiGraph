//
//  MGUtil.h
//  libMixiGraph
//
//  Created by kenji kinukawa on 11/02/21.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JSON.h"
#import "MGComment.h"

@interface MGUtil : NSObject {
    
}

+(NSURL *)buildAPIURL:(NSString*)baseURL path:(NSArray *)path query:(NSDictionary*)query;
+(NSDictionary *)parseAuthenticateHeader:(NSString*)param;
+(void)ShowNetworkErrorAlert;
+(void)ShowAuthorizationErrorAlert;
+(void)ShowRefreshTokenExpiredAlert;
+(NSDictionary *)parsePostBody:(NSString*)param;
@end
