//
//  ProductTests.m
//  InstabugTaskTests
//
//  Created by Hassaan El-Garem on 7/5/18.
//  Copyright © 2018 Garem. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Product.h"
#import <OHHTTPStubs.h>

@interface ProductTests : XCTestCase

@end

@implementation ProductTests

- (void)setUp {
    [super setUp];
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES;
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:@"/Users/Garem/Documents/Projects/Instabug/InstabugTask/products.json"
                                                statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
}

- (void)tearDown {
    [OHHTTPStubs removeAllStubs];
    [super tearDown];
}

- (void)testGetProducts {
    XCTestExpectation *responseArrived = [self expectationWithDescription:@"Response for get products request arrived"];
    [Product getProductsFrom:1 withCount:10 withCompletionHandler:^(NSMutableArray *products) {
        if (products) {
            XCTAssertEqual(products.count, 10, @"The count of the products returned is incorrect");
            XCTAssertNotNil(products[0], @"The first product obtained is nil");
            XCTAssertEqual([products[0] _id], 1, @"The product id of the first product obtained is not accurate");
            XCTAssertEqualObjects([products[0] productDescription], @"1 - Lorem ipsum whqbspekmugdlwvadwddskfvpzdxrcookvpraeyp", @"The product description of the first product obtained is not accurate");
            XCTAssertEqual([products[0] price], 77, @"The product price of the first product obtained is not accurate");
            XCTAssertEqualObjects([products[0] imageUrl], @"https://blog.instabug.com/wp-content/uploads/2015/02/instabug.jpg", @"The product image of the first product obtained is not accurate");
           [responseArrived fulfill];
            
        }
    }];
    [self waitForExpectationsWithTimeout:10 handler:nil];    
}


@end
