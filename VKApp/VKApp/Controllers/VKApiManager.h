//
//  VKApiManager.h
//  VKApp
//
//  Created by Abdushev Sergey on 12.06.17.
//  Copyright © 2017 Abdushev Sergey. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Friend;
@class Message;

@interface VKApiManager : NSObject

@property (nonatomic) __block NSArray *friendClassFilledWithInfo;
@property (nonatomic) __block NSArray *arrayOfMessages;
@property (nonatomic) __block NSArray *arrayOfIndicators;

+ (VKApiManager*)sharedInstance;
- (NSURLRequest *)getFriendsInfoRequest:(NSString *)access_token;
- (void)parseFriendsInfo:               (NSString *)getFriendsInfoURLString;
- (NSMutableArray *)fillFriendsClassWithData:(NSArray *)friendsInfoArray;
- (void)readHistoryOfDialogueBy:(NSString *)selectedUser;
- (NSMutableArray *)fillArrayOfMessagesByArray:(NSArray *)arrayOfMessages;
- (NSMutableArray *)fillArrayOfInOutIndicators:(NSArray *)arrayOfMessages;
- (NSMutableArray *)fillArrayOfMessageDates:(NSArray *)arrayOfMessagesWithInfo;
- (NSURLRequest *)sendMessageRequest:(NSString *)messageText
                         andFriendID:(NSString *)friendID;
- (void)sendMessage:(NSURLRequest *)sendMessageRequest;

@end
