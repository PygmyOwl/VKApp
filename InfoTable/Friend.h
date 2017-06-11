//
//  Friend.h
//  InfoTable
//
//  Created by Abdushev Sergey on 10.04.17.
//  Copyright © 2017 Abdushev Sergey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Friend : NSObject

@property (strong, nonatomic) NSString *avatarURLString;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *nickName;
@property (strong, nonatomic) NSString *bigAvatarURLString;
@property (strong, nonatomic) NSString *mobilePhone;
@property (strong, nonatomic) NSString *homePhone;
@property (strong, nonatomic) NSString *bdate;
@property (strong, nonatomic) NSString *friendsTown;
@property (strong, nonatomic) NSString *online;
@property (strong, nonatomic) NSString *friendID;
@property (strong, nonatomic) NSString *friendsDomain;

- (instancetype)initWithDictionary:(NSMutableDictionary *)friendInfoDict;

@end
