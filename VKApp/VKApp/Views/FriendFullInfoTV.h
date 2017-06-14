//
//  FriendFullInfoTV.h
//  VKApp
//
//  Created by Abdushev Sergey on 12.06.17.
//  Copyright © 2017 Abdushev Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChatTV;
@class Message;
@class FriendFullInfoCell;

@interface FriendFullInfoTV : UIViewController

@property (strong, nonatomic) NSArray *fullInfoArrayTV;
@property (strong, nonatomic) UIImage *avatarImageTV;
@property (strong, nonatomic) NSString *friendIDTV;

@end
