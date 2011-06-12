//
//  SimpleHttpClient.h
//  mixi_hd
//
//  Created by kenji.kinukawa on 11/06/08.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpReceiver.h"

typedef enum {
    MIXINetworkStateNotConnected = 0,
    MIXINetworkStateInProgress,
    MIXINetworkStateFinished,
    MIXINetworkStateError,
    MIXINetworkStateCanceled,
} MIXINetworkState;

@interface SimpleHttpClient : NSObject {
	id delegate;
    NSString * identifier;
    int networkState;
	NSMutableData * buffer;
	NSURLConnection *connection;
    NSMutableURLRequest * request;
    NSHTTPURLResponse *response;
    MIXIHttpReceiverType receiverType;
}

-(bool)doRequest;
-(BOOL)httpGet:(NSURL*)url;
-(BOOL)httpPost:(NSURL*)url 
      param:(NSDictionary *)param 
	   body:(NSData*)body;
-(BOOL)httpDelete:(NSURL*)url;
-(void)httpCancel;

@property (nonatomic,assign) id delegate;
@property (nonatomic,retain) NSString * identifier;
@property int networkState;
@property (nonatomic,retain) NSMutableData * buffer;
@property (nonatomic,retain) NSURLConnection *connection;
@property (nonatomic,retain) NSMutableURLRequest * request;
@property (nonatomic,retain) NSHTTPURLResponse *response;
@property (nonatomic) MIXIHttpReceiverType receiverType;

@end

@interface NSObject (SimpleHttpClientDelegate)
-(void)httpClient:(SimpleHttpClient *)client didReceiveResponse:(NSURLResponse *)res;
-(void)httpClient:(SimpleHttpClient *)client didReceiveData:(NSData *)receivedData;
-(void)httpClient:(SimpleHttpClient *)client didFailWithError:(NSError*)error;
-(void)httpClient:(SimpleHttpClient *)client didFinishLoading:(NSMutableData *)data;
-(void)httpClientDidCancel:(SimpleHttpClient *)client;
@end

