//
//  APIWrapper.m
//  InstabugTask
//
//  Created by Hassaan El-Garem on 7/4/18.
//  Copyright © 2018 Garem. All rights reserved.
//

#import "APIWrapper.h"

@interface APIWrapper()

+ (NSString *) modifyURL: (NSString *) baseUrl withQueryParameters: (NSDictionary *) queryParams;
+ (NSMutableURLRequest *) createRequest : (NSString *) baseUrl withParameters: (NSDictionary *) parameters;
+ (void) executeRequest: (NSMutableURLRequest *) request withCompletionHandler:(requestCompletion) completionHandler;

@end

@implementation APIWrapper

+ (NSString *) modifyURL: (NSString *) baseUrl withQueryParameters: (NSDictionary *) queryParams {
    NSString *paramsFinalString = @"?";
    for (NSString* key in queryParams) {
        id value = queryParams[key];
        NSString *paramterString = [NSString stringWithFormat: @"%@=%@&", key, value];
        paramsFinalString = [paramsFinalString stringByAppendingString: paramterString];
    }
    paramsFinalString = [paramsFinalString substringToIndex:[paramsFinalString length] - 1];
    NSString *modifiedURL = [baseUrl stringByAppendingString:paramsFinalString];
    return modifiedURL;
}

+ (NSMutableURLRequest *) createRequest : (NSString *) baseUrl withParameters: (NSDictionary *) parameters {
    
    NSString *fullURL = [APIWrapper modifyURL:baseUrl withQueryParameters:parameters];
    NSURL *url = [NSURL URLWithString: fullURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:50.0];
    [request setHTTPMethod:@"GET"];
    return request;
}

+ (void) executeRequest: (NSMutableURLRequest *) request withCompletionHandler:(requestCompletion) completionHandler {
    NSLog(@"GET Request");
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200) {
            NSError *parseError = nil;
            NSArray *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            completionHandler(responseDictionary);
        } else {
            NSLog(@"Error");
            completionHandler(nil);
        }
        
    }];
    
    [dataTask resume];
}

+ (void) getRequest: (NSString *) baseUrl withParameters: (NSDictionary *) parameters withCompletionHandler:(requestCompletion) completionHandler{
    NSMutableURLRequest *request = [APIWrapper createRequest:baseUrl withParameters:parameters];
    [APIWrapper executeRequest:request withCompletionHandler: completionHandler];
    
}

@end
