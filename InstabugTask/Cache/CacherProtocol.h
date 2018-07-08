//
//  CacherProtocol.h
//  InstabugTask
//
//  Created by Hassaan El-Garem on 7/7/18.
//  Copyright © 2018 Garem. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CacherProtocol <NSObject>

@required
-(void) cacheWithArray: (NSArray *) products withPage: (int) page;
-(NSArray*) retrieveWithPage: (int) page;

@end
