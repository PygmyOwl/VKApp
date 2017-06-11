//
//  PersonFullInfoTV.h
//  InfoTable
//
//  Created by Abdushev Sergey on 23.02.17.
//  Copyright © 2017 Abdushev Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AuthWebView;
@class ChatTV;
@class Message;

@interface PersonFullInfoTV : UIViewController

@property (strong, nonatomic) NSArray *fullInfoArrayTV;
@property (strong, nonatomic) UIImage *avatarImageTV;
@property (strong, nonatomic) NSString *friendIDTV;

@end
