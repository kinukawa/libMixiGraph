//
//  MGUpdates.h
//  libMixiGraph
//
//  Created by kenji.kinukawa on 11/06/06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MGContentBase.h"

@interface MGUpdates : MGContentBase {
    
}

+ (NSMutableArray *)getUpdatesArrayByUpdatesDict:(NSDictionary *)updatesDict;

@end
