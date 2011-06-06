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

@end

@interface NSObject (MGUpdatesClientDelegate)
-(void)mgUpdatesClient:(NSURLConnection *)conn didFailWithError:(NSError*)error;
-(void)mgUpdatesClient:(NSURLConnection *)conn didFailWithAPIError:(MGApiError*)error;
-(void)mgUpdatesClient:(NSURLConnection *)conn didFinishLoading:(id)result;
@end
