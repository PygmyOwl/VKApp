//
//  Friend.m
//  InfoTable
//
//  Created by Abdushev Sergey on 10.04.17.
//  Copyright © 2017 Abdushev Sergey. All rights reserved.
//

#import "Friend.h"

@implementation Friend

- (instancetype)initWithDictionary:(NSMutableDictionary *)friendInfoDict {
    self = [super init];
        if(self) {
            self.avatarURLString = friendInfoDict[@"photo_200_orig"];
            self.firstName       = friendInfoDict[@"first_name"];
            self.lastName        = friendInfoDict[@"last_name"];
            self.nickName        = friendInfoDict[@"nickname"];
            self.bigAvatarURLString = friendInfoDict[@"photo_400_orig"];
            self.mobilePhone = friendInfoDict[@"mobile_phone"];
            self.homePhone   = friendInfoDict[@"home_phone"];
            self.bdate       = friendInfoDict[@"bdate"];
            self.friendsTown = friendInfoDict[@"home_town"];
            self.online = friendInfoDict[@"online"];
            self.friendID = friendInfoDict[@"uid"];
            self.friendsDomain = friendInfoDict[@"domain"];
        }
     return self;
}

@end
