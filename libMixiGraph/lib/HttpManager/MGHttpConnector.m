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

#pragma mark - mixi graph response check

-(BOOL)refreshOauthToken{
    NSLog(@"OAuth Token is expired.");
    MGOAuthClient * oauthClient = [[[MGOAuthClient alloc]init]autorelease];
    if([oauthClient refreshOAuthToken]){
        NSLog(@"Refreshed and retry request.");
        return YES;
    }else{
        NSLog(@"Invalid grant. please relogin.");
        return NO;
    }
}

//レスポンスエラーチェック
-(MGApiError *)perseAPIError:(SimpleHttpClient *)client{
    NSDictionary * dict = client.response.allHeaderFields;
	NSString *authenticate = [dict objectForKey:@"Www-Authenticate"];
	MGApiError * apiError = [[[MGApiError alloc]init]autorelease];
    if(authenticate){
		NSDictionary * authDict = [MGUtil parseAuthenticateHeader:authenticate];
		NSString * error = [authDict objectForKey:@"error"];
		if ([error isEqualToString:@"expired_token"]){
			apiError.errorType = MGApiErrorTypeExpiredToken;
		}else if([error isEqualToString:@"invalid_request"]){
			apiError.errorType = MGApiErrorTypeInvalidRequest;
		}else if([error isEqualToString:@"invalid_token"]){
			apiError.errorType = MGApiErrorTypeInvalidToken;
		}else if([error isEqualToString:@"insufficient_scope"]){
			apiError.errorType = MGApiErrorTypeInsufficientScope;
		}else{
			apiError.errorType = MGApiErrorTypeOther;
		}
	}
    apiError.body = [[[NSString alloc] initWithData:client.buffer encoding:NSUTF8StringEncoding]autorelease];
	return apiError;
}

-(MGApiError *)checkResponseError:(SimpleHttpClient *)client{
    NSHTTPURLResponse * response = client.response;
    if([response statusCode]==401){
        //リフレッシュ処理
        MGApiError * apiError = [self perseAPIError:client];
        apiError.response = response;
        return apiError;
    }else if([response statusCode]>=200 &&
             [response statusCode]<400){
        return nil;
    }else{
        MGApiError * apiError = [self perseAPIError:client];
        apiError.response = response;
        apiError.errorType = MGApiErrorTypeOther;
        return apiError;
    }
    return nil;
}
#pragma mark - httpClientDelegate method

-(void)httpClient:(SimpleHttpClient *)client didReceiveResponse:(NSURLResponse *)res{
    //通知する
    HttpReceiver * receiver = [[[HttpReceiver alloc]init]autorelease];
    [receiver notifyDidReceiveResponse:res];
    
}

-(void)httpClient:(SimpleHttpClient *)client didReceiveData:(NSData *)receivedData{
    //通知する
    HttpReceiver * receiver = [[[HttpReceiver alloc]init]autorelease];
    [receiver notifyDidReceiveData:receivedData];
    
}

-(void)httpClient:(SimpleHttpClient *)client didFailWithError:(NSError*)error{
    //通知する
    HttpReceiver * receiver = [[[HttpReceiver alloc]init]autorelease];
    [receiver notifyDidFailWithError:error];
    
}

-(void)httpClient:(SimpleHttpClient *)client didFinishLoading:(NSMutableData *)data{
    //NSString *contents = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    //NSLog(@"contents: %@", contents);
    
    if (client.receiverType == MIXIHttpReceiverTypeNormal){
        HttpReceiver * receiver = [[[HttpReceiver alloc]init]autorelease];
        [receiver notifyDidFinishLoading:client];
    }else if(client.receiverType == MIXIHttpReceiverTypeGraph){
        MGHttpReceiver * receiver = [[[MGHttpReceiver alloc]init]autorelease];
        MGApiError * error = [self checkResponseError:client];
        if (error) {
            if(error.errorType != MGApiErrorTypeExpiredToken){
                //エラー通知
                [receiver notifyWithAPIError:error];
                return;
            }
            if([self refreshOauthToken]){
                //再度setHttpClient
                [self setHttpClient:client];
                return;
            }
            //invalid Grant
            error.errorType = MGApiErrorTypeInvalidGrant;
            [receiver notifyWithAPIError:error];
            return;
        }
        [receiver notifyDidFinishLoading:client];
    }else if(client.receiverType == MIXIHttpReceiverTypeCache){
        
    }else{
        
    }
}

-(void)httpClientDidCancel:(SimpleHttpClient *)client{
    //通知する
    
}

@end
