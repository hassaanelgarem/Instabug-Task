//
//  ProductTableViewCell.m
//  InstabugTask
//
//  Created by Hassaan El-Garem on 7/4/18.
//  Copyright © 2018 Garem. All rights reserved.
//

#import "ProductTableViewCell.h"

@interface ProductTableViewCell()

@end

@implementation ProductTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setupConstraints {
    [self.productImageView setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.descriptionLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.priceLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSDictionary *views = [[NSDictionary alloc] initWithObjectsAndKeys:
                           self.productImageView, @"productImageView",
                           self.descriptionLabel, @"descriptionLabel",
                           self.priceLabel, @"priceLabel",
                           nil];
    
    NSArray *imageHorizontalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[productImageView]-20-[descriptionLabel]-10-|" options:0 metrics:nil views:views];
    NSArray *priceHorizontalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"H:[productImageView]-20-[priceLabel]" options:0 metrics:nil views:views];
    NSArray *labelVerticalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[descriptionLabel]-5-[priceLabel]-5-|" options:0 metrics:nil views:views];
    NSArray *imageVerticalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[productImageView]-5-|" options:0 metrics:nil views:views];
    NSLayoutConstraint *imageAspectRatioConstraint = [NSLayoutConstraint
                                                      constraintWithItem:self.productImageView
                                                      attribute:NSLayoutAttributeHeight
                                                      relatedBy:NSLayoutRelationEqual
                                                      toItem:self.productImageView
                                                      attribute:NSLayoutAttributeWidth
                                                      multiplier:1.0
                                                      constant:0];
    
    [self addConstraints:imageHorizontalConstraints];
    [self addConstraints:priceHorizontalConstraints];
    [self addConstraints:labelVerticalConstraints];
    [self addConstraints:imageVerticalConstraints];
    [self addConstraint:imageAspectRatioConstraint];
    [self layoutIfNeeded];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 300, 30)];
        self.descriptionLabel.textColor = [UIColor blackColor];
        self.descriptionLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        
        self.productImageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 50, 50)];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        self.priceLabel.textColor = [UIColor blackColor];
        self.priceLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        
        
        [self.contentView addSubview:self.productImageView];
        [self.contentView addSubview:self.descriptionLabel];
        [self.contentView addSubview:self.priceLabel];
        
        [self setupConstraints];
    }
    return self;
}

-(void) fillData {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSURL *url = [NSURL URLWithString: self.product.imageUrl];
        NSData *data = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:data];
            [self.productImageView setImage:image];
        });
    });
    self.descriptionLabel.text = self.product.productDescription;
    self.priceLabel.text = [NSString stringWithFormat: @"%d $", self.product.price];
}

@end
