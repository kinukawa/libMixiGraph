//
//  MGParams.h
//  libMixiGraph
//
//  Created by kenji.kinukawa on 11/03/30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//OAuth constant definition
#define OAUTH_REQUEST_URL   @"https://secure.mixi-platform.com/2/token"
#define OAUTH_SCOPES        @"r_photo",@"w_photo",@"r_voice",@"w_voice",@"w_diary",@"r_profile",@"r_profile_status",@"r_updates",@"r_checkin",@"w_checkin"
#define OAUTH_DISPLAY_TYPE  @"touch"
#define OAUTH_REFRESH_TOKEN @"refresh_token"
#define OAUTH_ACCESS_TOKEN  @"access_token"
#define OAUTH_EXPIRES_IN    @"expires_in"
#define OAUTH_REDIRECT_URL  @"http://mixi.jp/"

//API URL
#define API_BASE_URL        http://api.mixi-platform.com/
#define VOICE_BASE_URL      @"http://api.mixi-platform.com/2/voice/statuses/"
#define VOICE_REPLYS_URL    @"http://api.mixi-platform.com/2/voice/replies/"
#define VOICE_FAVORITES_URL @"http://api.mixi-platform.com/2/voice/favorites/"

#define PEOPLE_BASE_URL     @"http://api.mixi-platform.com/2/people/"

#define PHOTO_BASE_URL      @"http://api.mixi-platform.com/2/photo/"
#define PHOTO_REPLYS_URL    @"http://api.mixi-platform.com/2/photo/comments/"
#define PHOTO_FAVORITES_URL @"http://api.mixi-platform.com/2/photo/favorites/mediaItems/"

#define UPDATES_BASE_URL    @"http://api.mixi-platform.com/2/updates/"

#define CHECKIN_BASE_URL    @"http://api.mixi-platform.com/2/spots/"
@interface MGParams : NSObject {
    
}

@end
