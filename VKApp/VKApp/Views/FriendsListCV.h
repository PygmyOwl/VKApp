//
//  FriendsListCV.h
//  VKApp
//
//  Created by Abdushev Sergey on 12.06.17.
//  Copyright © 2017 Abdushev Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FriendsListCell;
@class FriendFullInfoTV;
@class VKApiManager;
@class AuthWebVC;

@interface FriendsListCV : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) NSArray *friendsInfoArray;

@end
