//
//  Product.m
//  InstabugTask
//
//  Created by Hassaan El-Garem on 7/4/18.
//  Copyright © 2018 Garem. All rights reserved.
//

#import "Product.h"

@implementation Product

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


+ (void) getProductsFrom: (int) from withCount: (int ) count withCompletionHandler:(productCompletion) completionHandler {
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                            [NSNumber numberWithInt:count], @"count",
                            [NSNumber numberWithInt:from], @"from",
                            nil];
    
    [APIWrapper getRequest:@"http://grapesnberries.getsandbox.com/products" withParameters: params withCompletionHandler:^(NSArray *responseDictionary) {
        NSMutableArray *productsArray = [[NSMutableArray alloc] initWithCapacity:count];
        for (NSDictionary* productJson in responseDictionary) {
            int productID = [[productJson objectForKey:@"id"] intValue];
            int productPrice = [[productJson objectForKey:@"price"] intValue];
            NSString *productDescription = [productJson objectForKey:@"productDescription"];
            NSString *productImage = @"https://blog.instabug.com/wp-content/uploads/2015/02/instabug.jpg";
            Product *product = [[Product alloc] initWithID: productID withDescription: productDescription withPrice: productPrice withImage: productImage];
            [productsArray addObject:product];
        }
        completionHandler(productsArray);
    }];
}

@end
