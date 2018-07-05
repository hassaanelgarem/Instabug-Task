//
//  APIWrapperTest.m
//  InstabugTaskTests
//
//  Created by Hassaan El-Garem on 7/4/18.
//  Copyright © 2018 Garem. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "APIWrapper.h"

@interface APIWrapperTest : XCTestCase

@end

@implementation APIWrapperTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//- (void) modifyURLTest {
//    NSString *baseURL = @"http://grapesnberries.getsandbox.com/products?count=10&from=1";
//    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
//                            [NSNumber numberWithInt:10], @"count",
//                            [NSNumber numberWithInt:1], @"from",
//                            nil];
//    NSString *expectedURL = @"http://grapesnberries.getsandbox.com/products?count=10&from=1";
//    NSString *modifiedURL = [APIWrapper modifyURL:baseURL withQueryParameters:params]
//}

@end
