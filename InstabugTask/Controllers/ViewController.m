//
//  ViewController.m
//  InstabugTask
//
//  Created by Hassaan El-Garem on 7/4/18.
//  Copyright © 2018 Garem. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    UITableView *tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self variablesInit];
    [self tableSetup];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return [self.products count] +  1;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductTableViewCell *cell = (ProductTableViewCell *)[theTableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    if (cell == nil) {
        cell = [[ProductTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier];
    }
    if (indexPath.row < self.products.count) {
        cell.product = self.products[indexPath.row];
        [cell fillData];
    } else {
        cell.descriptionLabel.text = @"Loading more data...";
        cell.priceLabel.text = @"";
        cell.productImageView.image = nil;
        if (!self.loadingMoreTableViewData) {
            self.loadingMoreTableViewData = YES;
            [self performSelector:@selector(addSomeMoreEntriesToTableView) withObject:nil afterDelay:5.0f];
        }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.products.count) {
        ProductDetailsViewController *vc = [[ProductDetailsViewController alloc] init];
        vc.product = self.products[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

#pragma mark - Helpers

- (void)addSomeMoreEntriesToTableView {
//    self.productsPage += 1;
    [self fetchProducts];
}

- (void) fetchProducts {
    [Product getProductsWithPage: self.productsPage withCompletionHandler:^(NSMutableArray * products) {
        if(products) {
            [self.products addObjectsFromArray:products];
            self.productsPage += 1;
            self.loadingMoreTableViewData = NO;
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableView reloadData];
            });
        }
        
        
    }];
}

- (void) variablesInit {
    self.productsPage = 1;
    self.pageSize = 10;
    self.cellIdentifier = @"productCell";
    self.products = [[NSMutableArray alloc] init];
}

- (void) tableSetup {
    tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.accessibilityIdentifier = @"mainTableView";
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:tableView];
    self.loadingMoreTableViewData = YES;
    [self fetchProducts];
}

@end
