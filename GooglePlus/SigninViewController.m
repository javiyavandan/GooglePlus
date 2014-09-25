//
//  SigninViewController.m
//  GooglePlus
//
//  Created by WeTheDevelopers on 19/08/14.
//  Copyright (c) 2014 WeTheDevelopers. All rights reserved.
//

#import "SigninViewController.h"
#import <GoogleOpenSource/GoogleOpenSource.h>

@interface SigninViewController ()

@end

@implementation SigninViewController
@synthesize signInButton,lblAuthenticationstatus,lblEmail,lblName,btnDisconnect,btnSignout,imgUseProfile;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ///Intilization of App Sigin Button
    [GPPSignInButton class];
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
    signIn.shouldFetchGoogleUserEmail = YES;  // Uncomment to get the user's email

    
    // Uncomment one of these two statements for the scope you chose in the previous step
    signIn.scopes = @[ kGTLAuthScopePlusLogin ];  // "https://www.googleapis.com/auth/plus.login" scope
    //signIn.scopes = @[ @"profile" ];            // "profile" scope
    
    // Optional: declare signIn.actions, see "app activities"
    signIn.delegate = self;
    // Do any additional setup after loading the view.
    
    //Signin Button Cutomization
    signInButton.colorScheme = kGPPSignInButtonColorSchemeLight;
    signInButton.style = kGPPSignInButtonStyleWide;
    
    //Userimage
    imgUseProfile.layer.cornerRadius = 50.0;
    imgUseProfile.layer.masksToBounds = YES;
    imgUseProfile.layer.borderColor = [UIColor whiteColor].CGColor;
    imgUseProfile.layer.borderWidth = 1.0;
}

- (void)viewWillAppear:(BOOL)animated {
     [[GPPSignIn sharedInstance] trySilentAuthentication];
    [self reportAuthStatus];
    [self updateButtons];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error {
    
    if (error) {
        lblAuthenticationstatus.text =
        [NSString stringWithFormat:@"Status: Authentication error: %@", error];
        return;
    }
    [self reportAuthStatus];
    [self updateButtons];
}

- (void)presentSignInViewController:(UIViewController *)viewController {
    // This is an example of how you can implement it if your app is navigation-based.
    [[self navigationController] pushViewController:viewController animated:YES];
}

- (void)didDisconnectWithError:(NSError *)error {
    if (error) {
        lblAuthenticationstatus.text =
        [NSString stringWithFormat:@"Status: Failed to disconnect: %@", error];
    } else {
        lblAuthenticationstatus.text =
        [NSString stringWithFormat:@"Status: Disconnected"];
    }
    [self refreshUserInfo];
    [self updateButtons];
}

- (IBAction)Disconnect_click:(id)sender {
    [[GPPSignIn sharedInstance] disconnect];
}

- (IBAction)Signout_click:(id)sender {
    [[GPPSignIn sharedInstance] signOut];
}

- (void)reportAuthStatus {
    if ([GPPSignIn sharedInstance].authentication) {
        lblAuthenticationstatus.text = @"Status: Authenticated";
    } else {
        // To authenticate, use Google+ sign-in button.
        lblAuthenticationstatus.text = @"Status: Not authenticated";
    }
    [self refreshUserInfo];
}

- (void)refreshUserInfo {
    if ([GPPSignIn sharedInstance].authentication == nil) {
        lblName.text = @"Name";
        lblEmail.text = @"EMail";
        self.imgUseProfile.image = [UIImage imageNamed:@""];
        return;
    }
    
    self.lblEmail.text = [GPPSignIn sharedInstance].userEmail;
    
    // The googlePlusUser member will be populated only if the appropriate
    // scope is set when signing in.
    GTLPlusPerson *person = [GPPSignIn sharedInstance].googlePlusUser;
    if (person == nil) {
        return;
    }
    
    self.lblName.text = person.displayName;
    
    // Load avatar image asynchronously, in background
    dispatch_queue_t backgroundQueue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(backgroundQueue, ^{
        NSData *avatarData = nil;
        NSString *imageURLString = person.image.url;
        if (imageURLString) {
            NSURL *imageURL = [NSURL URLWithString:imageURLString];
            avatarData = [NSData dataWithContentsOfURL:imageURL];
        }
        
        if (avatarData) {
            // Update UI from the main thread when available
            dispatch_async(dispatch_get_main_queue(), ^{
                imgUseProfile.image = [UIImage imageWithData:avatarData];
            });
        }
    });
}

-(void)updateButtons {
    BOOL authenticated = ([GPPSignIn sharedInstance].authentication != nil);
    
    signInButton.enabled = !authenticated;
    btnSignout.enabled = authenticated;
    btnDisconnect.enabled = authenticated;

    
    if (authenticated) {
        self.signInButton.alpha = 0.5;
        self.btnSignout.alpha = self.btnDisconnect.alpha = 1.0;
    } else {
        self.signInButton.alpha = 1.0;
        self.btnSignout.alpha = self.btnDisconnect.alpha = 0.5;
    }
}

@end
