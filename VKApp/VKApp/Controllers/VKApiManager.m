//
//  VKApiManager.m
//  VKApp
//
//  Created by Abdushev Sergey on 12.06.17.
//  Copyright © 2017 Abdushev Sergey. All rights reserved.
//

#import "VKApiManager.h"
#import <UIKit/UIKit.h>
#import "Friend.h"
#import "Message.h"

@interface VKApiManager ()

@property (strong, nonatomic) NSString  *userAccess_token;
@property (strong, nonatomic) NSString  *smallAvatarURLString;
@property (strong, nonatomic) Friend    *friend;
@property (strong, nonatomic) Message   *message;

@end

@implementation VKApiManager

+ (VKApiManager*)sharedInstance {
    static VKApiManager *_sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[VKApiManager alloc] init];
    });
    return _sharedInstance;
}

#pragma mark getFriends

- (NSURLRequest *)getFriendsInfoRequest:(NSString *)access_token {
    NSString *getFriendInfoURLString = [NSString
                                        stringWithFormat: @"https://api.vk.com/method/friends.get?id=5774017&access_token=%@&lang=3&fields=photo_200_orig,photo_400_orig,contacts,bdate,home_town,domain", access_token];
    self.userAccess_token = access_token;
    NSURL *getFriendInfoURL = [NSURL URLWithString:getFriendInfoURLString];
    NSURLRequest *getFriendInfoRequest = [NSURLRequest requestWithURL:getFriendInfoURL];
    return getFriendInfoRequest;
}

#pragma mark notif

- (void)postNotifMethodIsDone {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ready" object:nil];
}

- (void)parseFriendsInfo:(NSString *)getFriendInfoURLString {
    NSURL *getFriendInfoURL = [NSURL URLWithString:getFriendInfoURLString];
    NSURLSessionDataTask *getFriendInfoTask =
    [[NSURLSession sharedSession]
     dataTaskWithURL:getFriendInfoURL
     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
         NSDictionary *JSONFriendInfo = [NSJSONSerialization
                                         JSONObjectWithData:data
                                         options:NSJSONReadingMutableContainers
                                         error:nil];
         NSArray *arrayOfFriendsFromJSON = [NSArray arrayWithArray:JSONFriendInfo[@"response"]];
         self.friendClassFilledWithInfo =
         [NSArray arrayWithArray:
          [self fillFriendsClassWithData:arrayOfFriendsFromJSON]];
         [self performSelectorOnMainThread:@selector(postNotifMethodIsDone)
                                withObject:nil waitUntilDone:YES];
     }];
    [getFriendInfoTask resume];
}

- (NSMutableArray *)fillFriendsClassWithData:(NSArray *)friendsInfoArray {
    NSMutableArray *friendsClassesList = [NSMutableArray new];
    for(NSMutableDictionary *friendDictionary in friendsInfoArray) {
        Friend *newFriend = [[Friend alloc] initWithDictionary:friendDictionary];
        [friendsClassesList addObject:newFriend];
    }
    return friendsClassesList;
}

#pragma mark readHistory

- (void)readHistoryOfDialogueBy:(NSString *)selectedUser {
    NSLog(@"readhis");
    NSString *getHistoryURLString = [NSString stringWithFormat:@"https://api.vk.com/method/messages.getHistory?user_id=%@&access_token=%@&count=10", selectedUser, self.userAccess_token];
    NSURL *getHistoryURL = [NSURL URLWithString:getHistoryURLString];
    NSURLRequest *getHistoryRequest = [NSURLRequest requestWithURL:getHistoryURL];
    NSURLSession *chatSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[chatSession dataTaskWithRequest:getHistoryRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *JSONMessage = [NSJSONSerialization
                                     JSONObjectWithData:data
                                     options:NSJSONReadingMutableContainers
                                     error:nil];
        NSMutableArray *messagesFromJSON = [NSMutableArray arrayWithArray:JSONMessage[@"response"]];
        [messagesFromJSON removeObjectAtIndex:0];
        NSSortDescriptor *dateDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
        NSArray *sortDescriptor = [NSArray arrayWithObject:dateDescriptor];
        NSArray *sortedMessagesDataFromJSON = [messagesFromJSON sortedArrayUsingDescriptors:sortDescriptor];
        self.arrayOfMessages = [self fillArrayOfMessagesByArray:sortedMessagesDataFromJSON];
        self.arrayOfIndicators = [self fillArrayOfInOutIndicators:sortedMessagesDataFromJSON];
        NSLog(@"readed %@", sortedMessagesDataFromJSON);
    }] resume];
}

- (NSMutableArray *)fillArrayOfMessagesByArray:(NSArray *)arrayOfMessagesWithInfo {
    NSMutableArray *arrayOfMessages = [NSMutableArray array];
    for(int i = 0; i < arrayOfMessagesWithInfo.count; i++) {
        [arrayOfMessages addObject:arrayOfMessagesWithInfo[i][@"body"]];
    }
    return arrayOfMessages;
}

- (NSMutableArray *)fillArrayOfInOutIndicators:(NSArray *)arrayOfMessagesWithInfo {
    NSMutableArray *arrayOfInOutIndicators = [NSMutableArray array];
    for(int i = 0; i < arrayOfMessagesWithInfo.count; i++) {
        [arrayOfInOutIndicators addObject:arrayOfMessagesWithInfo[i][@"out"]];
    }
    return arrayOfInOutIndicators;
}

- (NSMutableArray *)fillArrayOfMessageDates:(NSArray *)arrayOfMessagesWithInfo {
    NSMutableArray *arrayOfMessageDates = [NSMutableArray new];
    for(int i = 0; i< arrayOfMessagesWithInfo.count; i++ ) {
        [arrayOfMessageDates addObject:arrayOfMessagesWithInfo[i][@"date"]];
    }
    return arrayOfMessageDates;
}

#pragma mark sendMessage

- (NSURLRequest *)sendMessageRequest:(NSString *)messageText
                         andFriendID:(NSString *)friendID {
    NSString *getAuthToMessagesString = [NSString stringWithFormat:@"https://api.vk.com/method/messages.send?user_id=%@&message=%@&access_token=%@", friendID, messageText, self.userAccess_token];
    NSString *encodedString = [getAuthToMessagesString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *getAuthToMessagesURL = [NSURL URLWithString:encodedString];
    NSURLRequest *getAuthToMessagesRequest =
    [NSURLRequest requestWithURL:getAuthToMessagesURL];
    return getAuthToMessagesRequest;
}

- (void)sendMessage:(NSURLRequest *)sendMessageRequest {
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    __block NSString *requestReply = [NSString new];
    [[session dataTaskWithRequest:sendMessageRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(@"requestReply: %@", requestReply);
    }] resume];
}

@end
