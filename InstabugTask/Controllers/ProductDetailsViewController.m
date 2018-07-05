//
//  ProductDetailsViewController.m
//  InstabugTask
//
//  Created by Hassaan El-Garem on 7/5/18.
//  Copyright © 2018 Garem. All rights reserved.
//

#import "ProductDetailsViewController.h"

@interface ProductDetailsViewController ()

@end

@implementation ProductDetailsViewController {
    UIImageView *productImage;
    UILabel *descriptionLabel;
    UILabel *priceLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addViews];
    [self fillData];
    [self setupConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helpers

- (void)addViews {
    descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 300, 30)];
    descriptionLabel.textColor = [UIColor blackColor];
    descriptionLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    descriptionLabel.numberOfLines = 0;
    descriptionLabel.textAlignment = NSTextAlignmentCenter;
    
    productImage = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 50, 50)];
    
    priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    priceLabel.textColor = [UIColor blackColor];
    priceLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    priceLabel.textAlignment = NSTextAlignmentCenter;
    
    
    [self.view addSubview: productImage];
    [self.view addSubview: descriptionLabel];
    [self.view addSubview: priceLabel];
}

- (void) fillData {
    descriptionLabel.text = self.product.productDescription;
    priceLabel.text = [NSString stringWithFormat: @"%d $", self.product.price];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSURL *url = [NSURL URLWithString: self.product.imageUrl];
        NSData *data = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:data];
            [productImage setImage:image];
        });
    });
    
    
    
}

- (void) setupConstraints {
    [productImage setTranslatesAutoresizingMaskIntoConstraints: NO];
    [descriptionLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [priceLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSDictionary *views = [[NSDictionary alloc] initWithObjectsAndKeys:
                           productImage, @"productImageView",
                           descriptionLabel, @"descriptionLabel",
                           priceLabel, @"priceLabel",
                           nil];
    
    NSArray *imageHorizontalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[productImageView]-10-|" options:0 metrics:nil views:views];
    NSArray *descriptionHorizontalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[descriptionLabel]-10-|" options:0 metrics:nil views:views];
    NSArray *imageVerticalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[productImageView]-10-[descriptionLabel]-10-[priceLabel]" options:0 metrics:nil views:views];
    NSLayoutConstraint *imageAspectRatioConstraint = [NSLayoutConstraint
                                                      constraintWithItem:productImage
                                                      attribute:NSLayoutAttributeHeight
                                                      relatedBy:NSLayoutRelationEqual
                                                      toItem:productImage
                                                      attribute:NSLayoutAttributeWidth
                                                      multiplier:1.0
                                                      constant:0];
    
    NSLayoutConstraint *centerPriceLabelConstraint = [NSLayoutConstraint
                                                      constraintWithItem:priceLabel
                                                      attribute:NSLayoutAttributeCenterX
                                                      relatedBy:NSLayoutRelationEqual
                                                      toItem: self.view
                                                      attribute:NSLayoutAttributeCenterX
                                                      multiplier:1.0
                                                      constant:0];
    
    [self.view addConstraints:imageHorizontalConstraints];
    [self.view addConstraints:descriptionHorizontalConstraints];
    [self.view addConstraints:imageVerticalConstraints];
    [self.view addConstraint:imageAspectRatioConstraint];
    [self.view addConstraint:centerPriceLabelConstraint];
    [self.view layoutIfNeeded];
    
}


@end
