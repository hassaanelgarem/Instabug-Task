//
//  ProductTableViewCell.h
//  InstabugTask
//
//  Created by Hassaan El-Garem on 7/4/18.
//  Copyright © 2018 Garem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface ProductTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic, strong) UILabel *priceLabel;
@property Product *product;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void) fillData;

@end
