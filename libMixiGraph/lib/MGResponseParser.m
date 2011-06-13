//
//  MGResponseParser.m
//  libMixiGraph
//
//  Created by kenji.kinukawa on 11/06/13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MGResponseParser.h"


@implementation MGResponseParser
+(id)parseVoiceClientResponse:(id)data{
    return [MGVoiceClient responseParser:data];
}
@end
