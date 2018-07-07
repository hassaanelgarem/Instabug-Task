//
//  UserDefaultsCacher.m
//  InstabugTask
//
//  Created by Hassaan El-Garem on 7/8/18.
//  Copyright © 2018 Garem. All rights reserved.
//

#import "UserDefaultsCacher.h"

@implementation UserDefaultsCacher 

- (void) cacheWithArray: (NSArray *) products withPage:(int)page {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *key = [NSString stringWithFormat:@"products-%d", page];
    [userDefaults setObject:products forKey:key];
    [userDefaults synchronize];
    NSLog(@"Caching using user defaults");
}

-(NSArray*) retrieveWithPage: (int) page {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *key = [NSString stringWithFormat:@"products-%d", page];
    NSArray *products = [userDefaults objectForKey:key];
    return products;
}

@end
