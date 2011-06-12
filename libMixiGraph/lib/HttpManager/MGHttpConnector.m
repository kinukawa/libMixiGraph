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
    [httpClient doRequest];
    //保持
    [httpClients addObject:httpClient];
}

#pragma mark - http requests

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
    NSString *contents = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    
    if (client.receiverType == MIXIHttpReceiverTypeNormal){
    
    }else if(client.receiverType == MIXIHttpReceiverTypeGraph){
        MGHttpReceiver * receiver = [[[MGHttpReceiver alloc]init]autorelease];
        [receiver notify:client response:contents];
    }else if(client.receiverType == MIXIHttpReceiverTypeCache){
        
    }else{
        
    }
}

-(void)httpClientDidCancel:(SimpleHttpClient *)client{
    //通知する
    
}

@end
