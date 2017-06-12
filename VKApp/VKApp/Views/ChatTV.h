//
//  ChatTV.h
//  VKApp
//
//  Created by Abdushev Sergey on 12.06.17.
//  Copyright © 2017 Abdushev Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChatReceivingCell;
@class AuthWebView;
@class PersonFullInfoTV;

@interface ChatTV : UIViewController

@property (strong, nonatomic) NSArray *arrayOfMessagesCTV;
@property (strong, nonatomic) NSArray *arrayOfInOutIndicatorsCTV;

@end
