//
//  Product.m
//  InstabugTask
//
//  Created by Hassaan El-Garem on 7/4/18.
//  Copyright © 2018 Garem. All rights reserved.
//

#import "Product.h"

@implementation Product

+ (int) pageSize {
    return 10;
}

- (id)initWithID: (int) productID withDescription: (NSString *) description withPrice: (int) price withImage: (NSString *) image {
    self = [super init];
    if (self) {
        self._id = productID;
        self.productDescription = description;
        self.price = price;
        self.imageUrl = image;
    }
    return self;
}

- (id)initWithData: (NSDictionary *) productJson {
    self = [super init];
    int productID = [[productJson objectForKey:@"id"] intValue];
    int productPrice = [[productJson objectForKey:@"price"] intValue];
    NSString *productDescription = [productJson objectForKey:@"productDescription"];
    NSString *productImage = @"https://blog.instabug.com/wp-content/uploads/2015/02/instabug.jpg";
    if(self) {
        self._id = productID;
        self.productDescription = productDescription;
        self.price = productPrice;
        self.imageUrl = productImage;
    }
    return self;
}

+ (NSMutableArray *) productsFromJson: (NSArray *) json {
    int count = [Product pageSize];
    NSMutableArray *productsArray = [[NSMutableArray alloc] initWithCapacity:count];
    for (NSDictionary* productJson in json) {
        Product *product = [[Product alloc] initWithData:productJson];
        [productsArray addObject:product];
    }
    return productsArray;
}


+ (void) getProductsWithPage: (int) page withCompletionHandler:(productCompletion) completionHandler {
    // Initialize cacher
    
//    UserDefaultsCacher *userDefaultsStrategy = [[UserDefaultsCacher alloc] init];
//    Cacher *cacher = [[Cacher alloc] initWithProtocol:userDefaultsStrategy];
    
    FileCacher *fileStrategy = [[FileCacher alloc] init];
    Cacher *cacher = [[Cacher alloc] initWithProtocol:fileStrategy];
    
    // Setting Parameteres
    int count = [Product pageSize];
    int from = ((page - 1) * count) + 1;
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [NSNumber numberWithInt:count], @"count",
                            [NSNumber numberWithInt:from], @"from",
                            nil];
    
    // Sending request
    [APIWrapper getRequest:@"http://grapesnberries.getsandbox.com/products" withParameters: params withCompletionHandler:^(NSArray *responseDictionary) {
        if (responseDictionary){
            [cacher cacheWithArray:responseDictionary withPage:page];
            NSMutableArray *productsArray = [Product productsFromJson:responseDictionary];
            completionHandler(productsArray);
        } else {
            // Retrieve data from cache if available
            NSArray *cachedResponse = [cacher retrieveWithPage:page];
            if (cachedResponse) {
                NSMutableArray *productsArray = [Product productsFromJson:cachedResponse];
                completionHandler(productsArray);
            } else {
                completionHandler(nil);
            }
        }
        
    }];
}

@end
