//
//  CVCell.h
//  InfoTable
//
//  Created by Abdushev Sergey on 20.02.17.
//  Copyright © 2017 Abdushev Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CVCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *personAvatarImage;
@property (strong, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *positionLabel;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *cvCellActivityIndicator;

@end
