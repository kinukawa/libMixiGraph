//
//  NSString+Util.m
//  libMixiGraph
//
//  Created by kinukawa on 11/05/08.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSString+Util.h"


@implementation NSString (NSString_Util)
-(NSString*) encodeURIComponent {
    return [((NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                (CFStringRef)self,
                                                                NULL,
                                                                (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                kCFStringEncodingUTF8)) autorelease];
}
@end
