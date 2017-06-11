//
//  AuthWebView.m
//  InfoTable
//
//  Created by Abdushev Sergey on 28.03.17.
//  Copyright © 2017 Abdushev Sergey. All rights reserved.
//

#import "AuthWebView.h"
#import "VKApiManager.h"
#import "PersonsInfoVC.h"

@interface AuthWebView () <UIWebViewDelegate>

@property (strong, nonatomic) VKApiManager *VKApi;
@property (assign, nonatomic) NSInteger methodIndicator;
@property (strong, nonatomic) NSString *authURL;
@property (strong, nonatomic) NSString *userAccessToken;
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) NSArray *messagesFromJSON;
@property (strong, nonatomic) NSArray *messagesWithInfo;

@end

@implementation AuthWebView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getAuth];
}

- (IBAction)toCV:(id)sender {
    [self initSegueBackToPersonsInfo];
}

- (void)getAuth {
    [self.authWebView loadRequest:[self passAuthRequest]];
    self.methodIndicator = 1;
}

- (NSURLRequest *)passAuthRequest {
    NSString *authAdress = @"https://oauth.vk.com/authorize?client_id=5935443&display=touch&redirect_uri=https://oauth.vk.com/blank.html&scope=messages&response_type=token&v=5.52";
    NSURL *authURL = [NSURL URLWithString:authAdress];
    NSURLRequest *downloadAuthPage = [NSURLRequest requestWithURL:authURL];
    return downloadAuthPage;
}

- (void)parseAuthData:(NSString *)authURLString {
    NSMutableDictionary *userData = [[NSMutableDictionary alloc] init];
    NSRange textRange =[[authURLString lowercaseString] rangeOfString:[@"access_token" lowercaseString]];
    if(textRange.location != NSNotFound) {
        NSArray *authData = [authURLString
                             componentsSeparatedByCharactersInSet:
                             [NSCharacterSet characterSetWithCharactersInString:@"=&"]];
        [userData setObject:[authData objectAtIndex:1] forKey:@"access_token"];
        [userData setObject:[authData objectAtIndex:3] forKey:@"expires_in"];
        [userData setObject:[authData objectAtIndex:5] forKey:@"user_id"];
        self.userAccessToken = authData[1];
        [self refreshTokenTimer:[authData[3] integerValue]];
        self.userID          = authData[5];
        if(authData == nil) {
            UIAlertController *errorAlert = [UIAlertController
                                             alertControllerWithTitle:@"Connection error"
                                             message:@"Check your internet connection"
                                             preferredStyle:UIAlertControllerStyleAlert];
            [errorAlert addAction:
             [UIAlertAction actionWithTitle:@"Send"
                                      style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction *action){}]];
            [self presentViewController:errorAlert animated:YES completion:nil];
        } else {
            [self getFriendsInfo];
        }
    }
}

- (void)refreshTokenTimer:(NSInteger)tokenExpiresIn {
    [NSTimer scheduledTimerWithTimeInterval:tokenExpiresIn
                                     target:self
                                   selector:@selector(getAuth)
                                   userInfo:nil
                                    repeats:NO];
}

#pragma mark friends

- (void)getFriendsInfo {
    NSURLRequest *getFriendsInfoRequest = [[VKApiManager sharedInstance]getFriendsInfoRequest:self.userAccessToken];
    [self.authWebView loadRequest:getFriendsInfoRequest];
    self.methodIndicator = 2;
}

- (void)parseFriendsInfo:(NSString *)currentURL {
    [[VKApiManager sharedInstance] parseFriendsInfo:currentURL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)webView:(UIWebView *)webView
    shouldStartLoadWithRequest:(nonnull NSURLRequest *)request
                navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.activityIndicator = [[UIActivityIndicatorView alloc]
                              initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicator.center=self.view.center;
    [self.activityIndicator startAnimating];
    [self.view addSubview:self.activityIndicator];
}

- (void)initSegueBackToPersonsInfo {
    [self performSegueWithIdentifier:@"toVC" sender:self];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *currentURL = webView.request.URL.absoluteString;
    NSLog(@"CURRENTURL %@", currentURL);
    if(self.methodIndicator == 1) {
        [self parseAuthData:currentURL];
    } else if(self.methodIndicator == 2) {
        [self parseFriendsInfo:currentURL];
        [self.activityIndicator stopAnimating];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initSegueBackToPersonsInfo) name:@"ready" object:nil];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.activityIndicator stopAnimating];
    UIAlertController *errorAlert = [UIAlertController
                                     alertControllerWithTitle:@"Connection error"
                                     message:@"Check your internet connection"
                                     preferredStyle:UIAlertControllerStyleAlert];
    [errorAlert addAction:
     [UIAlertAction actionWithTitle:@"Ok"
                              style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction *action){}]];
    [self presentViewController:errorAlert animated:YES completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
