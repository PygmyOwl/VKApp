//
//  Message.m
//  VKApp
//
//  Created by Abdushev Sergey on 12.06.17.
//  Copyright © 2017 Abdushev Sergey. All rights reserved.
//

#import "Message.h"

@implementation Message

- (instancetype)initWithMessageDictionary:(NSMutableDictionary *)messagesWithInfo {
    self = [super init];
    if(self) {
        self.onlyForMessages = messagesWithInfo[@"body"];
    }
    return self;
}

- (instancetype)initWithInOutDictionary:(NSMutableDictionary *)messagesWithInfo {
    self = [super init];
    if(self) {
        self.onlyForInOut = messagesWithInfo[@"out"];
    }
    return self;
}

- (instancetype)initWithDateDictionary:(NSMutableDictionary *)messagesWithInfo {
    self = [super init];
    if(self) {
        self.onlyForDates = messagesWithInfo[@"date"];
    }
    return self;
}

@end
