//
//  MGHttpConnector.m
//  libMixiGraph
//
//  Created by Kinukawa Kenji on 11/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MGHttpConnector.h"

@implementation MGHttpConnector

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

//return singleton object
+(MGHttpConnector *)sharedConnector{
    static MGHttpConnector * sharedConnector;
    if(!sharedConnector){
        sharedConnector = [[MGHttpConnector alloc]init];
    }
    return sharedConnector;
}

-(BOOL)isNetworkAccessing{
    return [httpClients count]>0;
}

-(void)setHttpClient:(SimpleHttpClient*)httpClient{
    httpClient.identifier = [MGUtil createUniqueID];
    httpClient.delegate = self;
    //リクエスト実行して
    //保持
    [httpClients addObject:httpClient];
}

#pragma mark - http requests

-(void)enqueue:(NSString *)method identifier:(NSString *)identifier request:(NSMutableURLRequest *)req{
    MGHttpClient * httpClient = [[[MGHttpClient alloc]initWithURLRequest:req]autorelease];
    httpClient.delegate = self;
    httpClient.method = method;
    httpClient.identifier = identifier;
    [httpClient doRequest];
    [self.requestQueue addObject:httpClient];
}

-(void)cancelAllRequests{
    //前リクエストの停止と破棄
}

-(void)cancelRequestById:(NSString *)requestID{
    
}

#pragma mark - httpClientDelegate method

-(void)httpClient:(SimpleHttpClient *)client didReceiveResponse:(NSURLResponse *)res{
    //通知する
    
}

-(void)httpClient:(SimpleHttpClient *)client didReceiveData:(NSData *)receivedData{
    //通知する
    
}

-(void)httpClient:(SimpleHttpClient *)client didFailWithError:(NSError*)error{
    //通知する
    
}

-(void)httpClient:(SimpleHttpClient *)client didFinishLoading:(NSMutableData *)data{
    //通知する
}

-(void)httpClientDidCancel:(SimpleHttpClient *)client{
    //通知する
    
}

@end
