//
//  Product.h
//  InstabugTask
//
//  Created by Hassaan El-Garem on 7/4/18.
//  Copyright © 2018 Garem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIWrapper.h"
#import "UserDefaultsCacher.h"
#import "Cacher.h"

@interface Product : NSObject

typedef void(^productCompletion)(NSMutableArray *);

@property int _id;
@property NSString *productDescription;
@property int price;
@property NSString *imageUrl;

+ (int) pageSize;
+ (void) getProductsWithPage: (int) page withCompletionHandler:(productCompletion) completionHandler;
- (id)initWithID: (int) productID withDescription: (NSString *) description withPrice: (int) price withImage: (NSString *) image;
- (id)initWithData: (NSDictionary *) productJson;

@end
