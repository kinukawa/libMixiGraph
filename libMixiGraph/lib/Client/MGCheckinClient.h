//
//  MGCheckinClient.h
//  libMixiGraph
//
//  Created by Kenji Kinukawa on 11/08/07.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGClientBase.h"
#import "MGUtil.h"
@interface MGCheckinClient : MGClientBase{
    id delegate;

}

@end
@interface NSObject (MGUpdatesClientDelegate)
-(void)mgUpdatesClient:(NSURLConnection *)conn didFailWithError:(NSError*)error;
-(void)mgUpdatesClient:(NSURLConnection *)conn didFailWithAPIError:(MGApiError*)error;
-(void)mgUpdatesClient:(NSURLConnection *)conn didFinishLoading:(id)result;
@end
