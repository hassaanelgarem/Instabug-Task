//
//  MainViewTests.m
//  InstabugTaskUITests
//
//  Created by Hassaan El-Garem on 7/7/18.
//  Copyright © 2018 Garem. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OHHTTPStubs.h>

@interface MainViewTests : XCTestCase

@end

@implementation MainViewTests

- (void)setUp {
    [super setUp];
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES;
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithFileAtPath:@"/Users/Garem/Documents/Projects/Instabug/InstabugTask/products.json"
                                                statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
    self.continueAfterFailure = NO;
    [[[XCUIApplication alloc] init] launch];

}

- (void)tearDown {
    [OHHTTPStubs removeAllStubs];
    [super tearDown];
}

- (void)testTableInteraction {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *table = app.tables[@"mainTableView"];
    XCTAssertTrue(table.exists, @"The main table view doesn't exist");
    
    // Wait for initial population
    XCUIElementQuery *cells = table.cells;
    XCUIElement *secondCell = [cells elementBoundByIndex:1];
    NSPredicate *populated = [NSPredicate predicateWithFormat:@"exists == 1"];
    [self expectationForPredicate:populated evaluatedWithObject:secondCell handler:nil];
    [self waitForExpectationsWithTimeout:5 handler:nil];
    
    // Test first 10 cells
    for (int i = 0; i < 10; i++) {
        XCUIElement *cell = [cells elementBoundByIndex:i];
        [cell tap];
        XCUIElement *image = app.images[@"detailedImage"];
        XCTAssertTrue(image.exists, @"The detailed view did not appear");
        [[app.navigationBars.buttons elementBoundByIndex:0] tap];
    }
}

- (void)testLoadMoreData {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *table = app.tables[@"mainTableView"];
    
    // Wait for initail population
    XCUIElementQuery *cells = table.cells;
    XCUIElement *secondCell = [cells elementBoundByIndex:1];
    NSPredicate *populated = [NSPredicate predicateWithFormat:@"exists == 1"];
    [self expectationForPredicate:populated evaluatedWithObject:secondCell handler:nil];
    [self waitForExpectationsWithTimeout:5 handler:nil];
    
    //Simulating scrolling up to load more cells
    cells = table.cells;
    int count = (int) cells.count;
    for (int i = 0; i < count; i += 4) {
        [table swipeUp];
    }
    
    //Test loading more cells
    XCUIElement *newCell = [cells elementBoundByIndex:count];
    [self expectationForPredicate:populated evaluatedWithObject:newCell handler:nil];
    [self waitForExpectationsWithTimeout:5 handler:nil];
    
    
}

@end
