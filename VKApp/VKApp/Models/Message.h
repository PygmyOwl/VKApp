//
//  Message.h
//  VKApp
//
//  Created by Abdushev Sergey on 12.06.17.
//  Copyright © 2017 Abdushev Sergey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property (strong, nonatomic) NSString *messageText;
@property (strong, nonatomic) NSString *messageID;
@property (strong, nonatomic) NSString *messageSenderID;
@property (strong, nonatomic) NSString *youMeIndicator;
@property (strong, nonatomic) NSString *onlyForDates;
@property (strong, nonatomic) NSString *onlyForMessages;
@property (strong, nonatomic) NSString *onlyForInOut;

- (instancetype)initWithMessageDictionary:(NSMutableDictionary *)messagesWithInfo;
- (instancetype)initWithInOutDictionary:(NSMutableDictionary *)messagesWithInfo;
- (instancetype)initWithDateDictionary:(NSMutableDictionary *)messagesWithInfo;

@end
