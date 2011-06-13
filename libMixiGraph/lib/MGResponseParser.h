//
//  MGResponseParser.h
//  libMixiGraph
//
//  Created by kenji.kinukawa on 11/06/13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGVoiceClient.h"

@interface MGResponseParser : NSObject {
    
}
+(id)parseVoiceClientResponse:(id)data;
@end
