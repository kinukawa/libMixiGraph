//
//  MGUpdates.m
//  libMixiGraph
//
//  Created by kenji.kinukawa on 11/06/06.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MGUpdates.h"


@implementation MGUpdates
-(id)init{
	if((self = [super init])){
    }
	return self;
}

- (void) dealloc {
}

+ (NSMutableArray *)getUpdatesArrayByUpdatesDict:(NSDictionary *)updatesDict{
    //NSMutableArray * updates = [NSMutableArray array];
    NSArray * items = [updatesDict objectForKey:@"items"];
    /*for (NSDictionary * item in items) {
        NSDictionary * actorDict = [item objectForKey:@"actor"];
        NSDictionary * objectDict = [item objectForKey:@"object"];
        id object;
        if ([[object objectForKey:@"objectType"] isEqualToString:@"status"]) {
            //voice
        }else if ([[object objectForKey:@"objectType"] isEqualToString:@"article"]) {
            //diary
        }else if ([[object objectForKey:@"objectType"] isEqualToString:@"event"]) {
            //schedule
        }else if ([[object objectForKey:@"objectType"] isEqualToString:@"review"]) {
            //review
        }else if ([[object objectForKey:@"objectType"] isEqualToString:@"video"]) {
            //video
        }else if ([[object objectForKey:@"objectType"] isEqualToString:@"service"]) {
            //appli
        }else if ([[object objectForKey:@"objectType"] isEqualToString:@"photo"]) {
            //photo
        }else if ([[object objectForKey:@"objectType"] isEqualToString:@"photo-album"]) {
            //photo-album
        }else if ([[object objectForKey:@"objectType"] isEqualToString:@"bookmark"]) {
            //check
        }else if ([[object objectForKey:@"objectType"] isEqualToString:@"person"]) {
            //近況
        }    
    }*/
    return items;
}

@end
