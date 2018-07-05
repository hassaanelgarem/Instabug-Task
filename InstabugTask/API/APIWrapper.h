//
//  APIWrapper.h
//  InstabugTask
//
//  Created by Hassaan El-Garem on 7/4/18.
//  Copyright © 2018 Garem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIWrapper : NSObject

typedef void(^requestCompletion)(NSArray *);

+ (void) getRequest: (NSString *) baseUrl withParameters: (NSDictionary *) parameters withCompletionHandler:(requestCompletion) completionHandler;

@end
