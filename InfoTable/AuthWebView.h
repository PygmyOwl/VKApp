//
//  AuthWebView.h
//  InfoTable
//
//  Created by Abdushev Sergey on 28.03.17.
//  Copyright © 2017 Abdushev Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VKApiManager;
@class PersonsInfoVC;

@interface AuthWebView : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *authWebView;
@property (assign, nonatomic) NSInteger timeForTokenExpires;

- (void)getAuth;

@end
