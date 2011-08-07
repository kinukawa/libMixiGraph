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
-(void)postDiaryWithPhoto:(NSString*)title 
					 body:(NSString*)body 
					photo:(UIImage *)photo;
@end
