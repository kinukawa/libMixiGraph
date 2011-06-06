//
//  MGUpdatesClient.h
//  libMixiGraph
//
//  Created by kenji.kinukawa on 11/06/06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGClientBase.h"

@interface MGUpdatesClient : MGClientBase {
@public	
	id delegate;
}
@property (nonatomic,assign) id delegate;

//あるユーザの新着フィード取得
-(void)getUpdatesFeedByUserID:(NSString *)userId 
                      groupId:(NSString *)groupId
                       fields:(NSString *)fields
                        count:(NSString *)count
                 updatedSince:(NSString *)updatedSince
                       device:(NSString *)device
                   identifier:(NSString *)identifier;

@end

@interface NSObject (MGUpdatesClientDelegate)
-(void)mgUpdatesClient:(NSURLConnection *)conn didFailWithError:(NSError*)error;
-(void)mgUpdatesClient:(NSURLConnection *)conn didFailWithAPIError:(MGApiError*)error;
-(void)mgUpdatesClient:(NSURLConnection *)conn didFinishLoading:(id)result;
@end
