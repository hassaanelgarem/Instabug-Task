//
//  Cacher.m
//  InstabugTask
//
//  Created by Hassaan El-Garem on 7/8/18.
//  Copyright © 2018 Garem. All rights reserved.
//

#import "Cacher.h"

@implementation Cacher

- (id)initWithProtocol:(id<CacherProtocol>)protocol{
    self = [super init];
    if (self) {
        self.protocol = protocol;
    }
    return self;
}

- (void) cacheWithArray: (NSArray *) products withPage:(int)page {
//    NSLog(self.protocol);
    [self.protocol cacheWithArray:products withPage:page];
}

-(NSMutableArray*) retrieveWithPage: (int) page{
    return [self.protocol retrieveWithPage:page];
}


@end
