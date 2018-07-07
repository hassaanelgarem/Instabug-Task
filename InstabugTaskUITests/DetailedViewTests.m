//
//  DetailedViewTests.m
//  InstabugTaskUITests
//
//  Created by Hassaan El-Garem on 7/7/18.
//  Copyright © 2018 Garem. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OHHTTPStubs.h>

@interface DetailedViewTests : XCTestCase

@end

@implementation DetailedViewTests

- (void)setUp {
    [super setUp];
    self.continueAfterFailure = NO;
    [[[XCUIApplication alloc] init] launch];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testDetailedView {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *table = app.tables[@"mainTableView"];
    XCTAssertTrue(table.exists, @"The main table view doesn't exist");
    
    // Wait for initial population
    XCUIElementQuery *cells = table.cells;
    XCUIElement *secondCell = [cells elementBoundByIndex:1];
    NSPredicate *populated = [NSPredicate predicateWithFormat:@"exists == 1"];
    [self expectationForPredicate:populated evaluatedWithObject:secondCell handler:nil];
    [self waitForExpectationsWithTimeout:5 handler:nil];
    
    // Test first product detailed view
    XCUIElement *cell = [cells elementBoundByIndex:0];
    [cell tap];
    XCUIElement *image = app.images[@"detailedImage"];
    XCUIElement *descriptionLabel = app.staticTexts[@"descriptionLabel"];
    XCUIElement *priceLabel = app.staticTexts[@"priceLabel"];
    
    // Assert that all elements exist
    XCTAssertTrue(image.exists, @"The product image doesn't exist");
    XCTAssertTrue(descriptionLabel.exists, @"The product description label doesn't exist");
    XCTAssertTrue(priceLabel.exists, @"The product price label doesn't exist");
}

@end
