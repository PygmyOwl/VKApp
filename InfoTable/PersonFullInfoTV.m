//
//  PersonFullInfoTV.m
//  InfoTable
//
//  Created by Abdushev Sergey on 23.02.17.
//  Copyright © 2017 Abdushev Sergey. All rights reserved.
//

#import "PersonFullInfoTV.h"
#import "TVCell.h"
#import "AuthWebView.h"
#import "ChatTV.h"
#import "VKApiManager.h"
#import "Message.h"

@interface PersonFullInfoTV () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *fullInfoTVC;
@property (strong, nonatomic) TVCell *tvCell;
@property (strong, nonatomic) AuthWebView *authView;
@property (strong, nonatomic) Message *message;
@property (strong, nonatomic) NSArray *arrayOfMessages;
@property (strong, nonatomic) NSArray *arrayOfIndicators;

@end

@implementation PersonFullInfoTV

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self.tvCell activityIndicator] startAnimating];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fullInfoArrayTV.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        if(indexPath.row == 0) {
            static NSString *fullInfoImageCellIdentifier = @"fullInfoImageCell";
            TVCell *cVCell = (TVCell *)[tableView dequeueReusableCellWithIdentifier:fullInfoImageCellIdentifier forIndexPath:indexPath];
            cVCell.avatarImageTVC.image = self.avatarImageTV;
            return cVCell;
        } else {
            static NSString *fullInfoLabelCell = @"fullInfoLabelCell";
            UITableViewCell *cellWithLabel = [tableView dequeueReusableCellWithIdentifier:
                                      fullInfoLabelCell];
        cellWithLabel.textLabel.text = [self.fullInfoArrayTV objectAtIndex:indexPath.row];
        cellWithLabel.textLabel.textAlignment = NSTextAlignmentCenter;
        UIFont *textLabelFont = [UIFont fontWithName: @"Arial" size: 19.0 ];
        cellWithLabel.textLabel.font  = textLabelFont;
        cellWithLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth |
                                        UIViewAutoresizingFlexibleHeight |
                                    UIViewAutoresizingFlexibleLeftMargin |
                                    UIViewAutoresizingFlexibleRightMargin;
        return cellWithLabel;
        }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        if(indexPath.section == 0 && indexPath.row == 0) {
            return 280.0f;
    }
    return 25.0f;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.fullInfoTVC reloadData];
    [[self.tvCell activityIndicator] stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark prepsForChat

- (void)fillChatArrays{
    NSLog(@"fill");
    self.arrayOfMessages = [[VKApiManager sharedInstance] arrayOfMessages];
    self.arrayOfIndicators = [[VKApiManager sharedInstance] arrayOfIndicators];
    if(self.arrayOfMessages == nil) {
        NSLog(@"nil");
        [self fillChatArrays];
    } else if(self.arrayOfMessages != nil) {
        NSLog(@"notnil");
        self.arrayOfMessages = [[VKApiManager sharedInstance] arrayOfMessages];
        self.arrayOfIndicators = [[VKApiManager sharedInstance] arrayOfIndicators];
        [self performSegueWithIdentifier:@"toChat" sender:self];
    }
}

- (IBAction)openChatButton:(id)sender {
    NSLog(@"button");
    [[VKApiManager sharedInstance] readHistoryOfDialogueBy:self.friendIDTV];
    [self performSelectorOnMainThread:@selector(fillChatArrays) withObject:nil waitUntilDone:YES];
}

#pragma mark prepForSegue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"prepare");
    if([segue.identifier isEqualToString:@"toChat"]) {
        ChatTV *chat = segue.destinationViewController;
        chat.arrayOfMessagesCTV = self.arrayOfMessages;
        chat.arrayOfInOutIndicatorsCTV = self.arrayOfIndicators;
    }
}

@end
