//
//  FriendsListCV.m
//  VKApp
//
//  Created by Abdushev Sergey on 12.06.17.
//  Copyright © 2017 Abdushev Sergey. All rights reserved.
//

//
//  PersonsInfoVC.m
//  InfoTable
//
//  Created by Abdushev Sergey on 08.02.17.
//  Copyright © 2017 Abdushev Sergey. All rights reserved.
//

#import "FriendsListCV.h"
#import "Friend.h"
#import "FriendsListCell.h"
#import "FriendFullInfoTV.h"
#import "AuthWebVC.h"
#import "VKApiManager.h"

@interface FriendsListCV () <UICollectionViewDataSource, UICollectionViewDelegate, UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *friendsListCV;
@property (strong, nonatomic) Friend *friend;
@property (strong, nonatomic) AuthWebVC  *authView;
@property (strong, nonatomic) FriendsListCell *flCell;
@property (strong, nonatomic) NSArray *convertWebData;
@property (strong, nonatomic) NSMutableDictionary *friendsFullInfo;
@property (strong, nonatomic) NSMutableArray *fullInfoToTV;
@property (strong, nonatomic) UIImage *avatarImage;
@property (strong, nonatomic) UIImage *bigAvatarImage;
@property (strong, nonatomic) NSString *friendIDCV;
@property (strong, nonatomic) NSString *accessTokenVC;
@property (strong, nonatomic) IBOutlet UITextField *searchTextField;
@property (strong, nonatomic) NSArray *searchingResults;
@property (assign, nonatomic) BOOL searchingDataIsFound;

@end

@implementation FriendsListCV

- (NSArray *)initializeWebData {
    NSArray *webData = [NSArray arrayWithArray:[[VKApiManager sharedInstance] friendClassFilledWithInfo]];
    NSLog(@"COLL %@", webData);
    return webData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.searchingDataIsFound == NO) {
        self.convertWebData = [self initializeWebData];
    NSLog(@"convert %@", self.convertWebData);
    } else if(self.searchingDataIsFound == YES) {
        self.convertWebData = [self initializeWebData];
    }
    [[self.flCell cvCellActivityIndicator] startAnimating];
}

- (void)setNavigationBackButton {
    UIBarButtonItem *newBackButton =
    [[UIBarButtonItem alloc] initWithTitle:@"Previous"
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(self.searchingDataIsFound == YES) {
        self.convertWebData = self.searchingResults;
    }
    [self.friendsListCV reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[self.flCell cvCellActivityIndicator] stopAnimating];
    [self.friendsListCV reloadData];
}

- (UIImage *)loadImage:(NSIndexPath *) indexPath {
    self.friend = self.convertWebData[indexPath.row];
    NSString *urlOfImage = self.friend.avatarURLString;
    UIImage  *image = [[UIImage alloc] init];
    NSURL    *imageURL   = [NSURL URLWithString:urlOfImage];
    NSData   *imageData  = [NSData dataWithContentsOfURL:imageURL];
    image      = [UIImage imageWithData:imageData];
    return image;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.convertWebData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FriendsListCell *flCell = (FriendsListCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CVcell" forIndexPath:indexPath];
    flCell.personAvatarImage.image = [self loadImage:indexPath];
    flCell.firstNameLabel.text = self.friend.firstName;
    flCell.lastNameLabel.text  = self.friend.lastName;
    flCell.nickNameLabel.text  = self.friend.nickName;
    return flCell;
}

#pragma mark segueMethods

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.avatarImage = [self loadImage:indexPath];
    [self prepareDataForTransfer:indexPath];
    [self performSegueWithIdentifier:@"fromCVtoTVSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"fromCVtoTVSegue"]) {
        FriendFullInfoTV *friendInfo = segue.destinationViewController;
        friendInfo.avatarImageTV   = self.bigAvatarImage;
        friendInfo.fullInfoArrayTV = self.fullInfoToTV;
        friendInfo.friendIDTV = self.friendIDCV;
    }
}

- (void)prepareDataForTransfer:(NSIndexPath *)indexPath {
    NSDictionary *chosenDict = self.convertWebData[indexPath.row];
    [self prepareArrayForTransfer:chosenDict];
}

- (void)prepareArrayForTransfer:(NSDictionary *)chosenDict {
    NSArray *arrayOfKeys     = [NSArray arrayWithObject:self.friend];
    self.friendsFullInfo  = [NSMutableDictionary dictionaryWithObject:chosenDict
                                                               forKey:arrayOfKeys];
    NSURL   *bigAvatarURL   = [NSURL URLWithString:self.friend.bigAvatarURLString];
    NSData  *bigAvatarData  = [NSData dataWithContentsOfURL:bigAvatarURL];
    UIImage *bigAvatarImage = [UIImage imageWithData:bigAvatarData];
    self.bigAvatarImage = bigAvatarImage;
    self.friendIDCV = self.friend.friendID;
    NSString *isOnline = [NSString string];
    if([self.friend.online isEqual:[NSNumber numberWithInteger:1]]) {
        isOnline = @"Online";
    } else {
        isOnline = @"Offline";
    }
    NSArray *valuesForRows = [NSArray arrayWithObjects:@"indexForImage",
                              self.friend.firstName, self.friend.lastName,
                              self.friend.bdate, self.friend.mobilePhone,
                              self.friend.homePhone, self.friend.friendsTown,
                              isOnline, nil];
    NSArray *namesForRows = [NSArray arrayWithObjects:@"indexForImage",
                             @"First name:", @"Last name:",
                             @"Birth date:", @"Mobile phone:",
                             @"Home phone:", @"Location:", @"Status:", nil];
    NSString *combinedString = [NSString string];
    self.fullInfoToTV = [NSMutableArray array];
    for(int i = 0; i < valuesForRows.count; i++) {
        combinedString = [NSString stringWithFormat:@"%@ %@", namesForRows[i], valuesForRows[i]];
        [self.fullInfoToTV addObject:combinedString];
    }
}

#pragma mark search

- (IBAction)searchActionButton:(id)sender {
    NSString *searchRequest = [self.searchTextField.text lowercaseString];
    NSLog(@"search %@", searchRequest);
    NSDictionary *chosenDict = [NSDictionary new];
    NSMutableArray *foundDicts = [NSMutableArray new];
    for(int i = 0; i < self.convertWebData.count; i++) {
        self.friend = self.convertWebData[i];
        if([[self.friend.firstName lowercaseString] isEqual:searchRequest]) {
            NSLog(@"find firstName %@", self.friend.firstName);
            chosenDict = self.convertWebData[i];
            [foundDicts addObject:chosenDict];
            [self reloadFoundedInfo:foundDicts];
            NSLog(@"founded %@", foundDicts);
        } else if([[self.friend.lastName lowercaseString] isEqual:searchRequest]) {
            chosenDict = self.convertWebData[i];
            [foundDicts addObject:chosenDict];
            [self reloadFoundedInfo:foundDicts];
        } else if([self.friend.friendID isEqual:searchRequest]) {
            NSLog(@"find ID %@", self.friend.friendID);
        }
    }
}

- (void)reloadFoundedInfo:(NSArray *)foundedDicts {
    [self.friendsListCV clearsContextBeforeDrawing];
    self.searchingDataIsFound = YES;
    self.searchingResults = [NSArray arrayWithArray:foundedDicts];
    [self.friendsListCV reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
