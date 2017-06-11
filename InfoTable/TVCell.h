//
//  TVCell.h
//  InfoTable
//
//  Created by Abdushev Sergey on 01.03.17.
//  Copyright © 2017 Abdushev Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView* avatarImageTVC;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
