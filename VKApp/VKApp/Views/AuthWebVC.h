//
//  AuthWebVC.h
//  VKApp
//
//  Created by Abdushev Sergey on 12.06.17.
//  Copyright © 2017 Abdushev Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VKApiManager;
@class FriendsListCV;

@interface AuthWebVC : UIViewController

@property (assign, nonatomic) NSInteger timeForTokenExpires;

- (void)getAuth;

@end
