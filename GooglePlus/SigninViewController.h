//
//  SigninViewController.h
//  GooglePlus
//
//  Created by WeTheDevelopers on 19/08/14.
//  Copyright (c) 2014 WeTheDevelopers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GooglePlus/GooglePlus.h>

@class GPPSignInButton;

@interface SigninViewController : UIViewController<GPPSignInDelegate>
{
}


@property (retain, nonatomic) IBOutlet GPPSignInButton *signInButton;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblEmail;
@property (strong, nonatomic) IBOutlet UILabel *lblAuthenticationstatus;
@property (strong, nonatomic) IBOutlet UIButton *btnSignout;
@property (strong, nonatomic) IBOutlet UIButton *btnDisconnect;
- (IBAction)Disconnect_click:(id)sender;
- (IBAction)Signout_click:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imgUseProfile;

@end
