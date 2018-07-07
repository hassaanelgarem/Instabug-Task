//
//  Cacher.h
//  InstabugTask
//
//  Created by Hassaan El-Garem on 7/8/18.
//  Copyright © 2018 Garem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CacherProtocol.h"

@interface Cacher : NSObject

@property (strong, nonatomic) id<CacherProtocol> protocol;

- (id)initWithProtocol:(id<CacherProtocol>)protocol;
- (void) cacheWithArray: (NSArray *) products withPage:(int)page;
- (NSMutableArray*) retrieveWithPage: (int) page;

@end
