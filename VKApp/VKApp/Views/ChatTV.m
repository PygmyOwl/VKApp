//
//  ChatTV.m
//  VKApp
//
//  Created by Abdushev Sergey on 12.06.17.
//  Copyright © 2017 Abdushev Sergey. All rights reserved.
//

#import "ChatTV.h"
#import "ChatReceivingCell.h"
#import "VKApiManager.h"
#import "Message.h"

@interface ChatTV () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) Message *message;
@property (strong, nonatomic) ChatReceivingCell *rCell;
@property (strong, nonatomic) NSArray *arrayOfMessagesWithInfo;
@property (strong, nonatomic) IBOutlet UITextField *messageTextField;
@property (strong, nonatomic) IBOutlet UITableView *chatTV;
@property (strong, nonatomic) NSString *chatFriendID;

@end

@implementation ChatTV

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.chatTV reloadData];
    [[self.rCell receivingMessageIndicator] startAnimating];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.chatTV reloadData];
    [[self.rCell receivingMessageIndicator] startAnimating];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.chatTV reloadData];
    [[self.rCell receivingMessageIndicator] stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfMessagesCTV.count;
}

//- (void)tableView:(UITableView *)tableView prefetchRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellWithMessageID = @"receivingCell";
    UITableViewCell *cellWithLabel = [tableView dequeueReusableCellWithIdentifier: cellWithMessageID];
    cellWithLabel.textLabel.text = [self.arrayOfMessagesCTV objectAtIndex:indexPath.row];
    if([[self.arrayOfInOutIndicatorsCTV objectAtIndex:indexPath.row]
        isEqualToNumber:[NSNumber numberWithInteger:0]]) {
        cellWithLabel.textLabel.textAlignment = NSTextAlignmentLeft;
        cellWithLabel.textLabel.backgroundColor = [UIColor blueColor];
    } else if([[self.arrayOfInOutIndicatorsCTV objectAtIndex:indexPath.row]
               isEqualToNumber:[NSNumber numberWithInteger:1]]) {
        cellWithLabel.textLabel.textAlignment = NSTextAlignmentRight;
        cellWithLabel.textLabel.backgroundColor = [UIColor greenColor];
    }
    UIFont *textLabelFont = [UIFont fontWithName: @"Arial" size: 19.0 ];
    cellWithLabel.textLabel.font  = textLabelFont;
    cellWithLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight |
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin;
    return cellWithLabel;
}

- (IBAction)sendMessageButton:(id)sender {
    NSString *message = self.messageTextField.text;
    [[VKApiManager sharedInstance] sendMessage:
     [[VKApiManager sharedInstance] sendMessageRequest:message
                                           andFriendID:self.chatFriendID]];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

@end
