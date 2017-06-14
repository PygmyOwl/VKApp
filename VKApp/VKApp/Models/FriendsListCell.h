//
//  FriendsListCell.h
//  VKApp
//
//  Created by Abdushev Sergey on 12.06.17.
//  Copyright © 2017 Abdushev Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsListCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *personAvatarImage;
@property (strong, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *cvCellActivityIndicator;

@end
