//
//  FileCacher.m
//  InstabugTask
//
//  Created by Hassaan El-Garem on 7/7/18.
//  Copyright © 2018 Garem. All rights reserved.
//

#import "FileCacher.h"

@implementation FileCacher

- (void) cacheWithArray: (NSArray *) products withPage: (int) page {
    NSError *error = nil;
    NSString *fileName = [NSString stringWithFormat:@"products-%d", page];
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:fileName];
    NSOutputStream *outputStream = [NSOutputStream outputStreamToFileAtPath:filePath append:NO];
    [outputStream open];
    [NSJSONSerialization writeJSONObject:products
                                toStream:outputStream
                                 options:0
                                   error:&error];
    [outputStream close];
    NSLog(@"Caching using files");
}

-(NSArray*) retrieveWithPage: (int) page {
    NSError *error = nil;
    NSString *fileName = [NSString stringWithFormat:@"products-%d", page];
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:fileName];
    NSInputStream *inputStream = [NSInputStream inputStreamWithFileAtPath:filePath];
    [inputStream open];
    NSArray *products = [NSJSONSerialization JSONObjectWithStream:inputStream options:0 error:&error];
    return products;
}

@end
