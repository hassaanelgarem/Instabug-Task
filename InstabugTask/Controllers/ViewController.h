//
//  ViewController.h
//  InstabugTask
//
//  Created by Hassaan El-Garem on 7/4/18.
//  Copyright © 2018 Garem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "ProductTableViewCell.h"
#import "ProductDetailsViewController.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property NSMutableArray *products;
@property (nonatomic) BOOL loadingMoreTableViewData;
@property int productsPage;
@property int pageSize;
@property NSString *cellIdentifier;

@end

