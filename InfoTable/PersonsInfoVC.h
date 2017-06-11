//
//  PersonsInfoVC.h
//  InfoTable
//
//  Created by Abdushev Sergey on 08.02.17.
//  Copyright © 2017 Abdushev Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DataProcessor;
@class Person;
@class CVCell;
@class PersonFullInfoTV;
@class VKApiManager;

@interface PersonsInfoVC : UIViewController <UIWebViewDelegate> 

@property (strong, nonatomic) NSArray *friendsInfoArray;

@end
