//
//  ChatTV.h
//  InfoTable
//
//  Created by Abdushev Sergey on 23.05.17.
//  Copyright © 2017 Abdushev Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReceivingCell;
@class AuthWebView;
@class PersonFullInfoTV;

@interface ChatTV : UIViewController

@property (strong, nonatomic) NSArray *arrayOfMessagesCTV;
@property (strong, nonatomic) NSArray *arrayOfInOutIndicatorsCTV;

@end
