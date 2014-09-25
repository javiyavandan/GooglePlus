//
//  ShareViewController.m
//  GooglePlus
//
//  Created by WeTheDevelopers on 21/08/14.
//  Copyright (c) 2014 WeTheDevelopers. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareViewController ()

@end

@implementation ShareViewController

@synthesize btnSharebutton,lblUserstatus,lblShare;

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
    lblShare.hidden = YES;
    [GPPShare sharedInstance].delegate = self;
    if ([GPPSignIn sharedInstance].authentication) {
        GTLPlusPerson *person = [GPPSignIn sharedInstance].googlePlusUser;
        lblUserstatus.text = [NSString stringWithFormat:@"Logged in as : %@",person.displayName];
        [btnSharebutton setEnabled:YES];
    } else {
        // To authenticate, use Google+ sign-in button.
        lblUserstatus.text = @"Please login to Use nativdialog share function.";
        //[btnSharebutton setEnabled:NO];
    }
    // Configure share button graphics.
    [[btnSharebutton layer] setCornerRadius:5];
    [[btnSharebutton layer] setMasksToBounds:YES];
    UIColor *borderColor = [UIColor colorWithWhite:203.0f/255.0f
                                             alpha:1.0];
    [[btnSharebutton layer] setBorderColor:[borderColor CGColor]];
    [[btnSharebutton layer] setBorderWidth:1.0];
    [btnSharebutton addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)shareClick:(id)sender {
    
    if ([GPPSignIn sharedInstance].authentication)
    {
    id<GPPNativeShareBuilder> shareBuilder = [[GPPShare sharedInstance] nativeShareDialog];
    [shareBuilder setURLToShare:[NSURL URLWithString:@"https://javiyavandan.blogspot.com/"]];
    [shareBuilder setPrefillText:@"Thank You for contact.I am just testing app."];
    
//    NSString *fileName1 = @"samplemedia1";
//    NSString *extension = @"mov";
//    NSURL *filePath = [[NSBundle mainBundle] URLForResource:fileName1 withExtension:extension];
    //[shareBuilder attachVideoURL:filePath];
    
    //NSString *fileName = @"samplemedia2";
    //[shareBuilder attachImage:[UIImage imageNamed:fileName]];
    [shareBuilder setPreselectedPeopleIDs:@[@"113991760623964005904",@"101629493187570199036"]];
        [shareBuilder setContentDeepLinkID:@"rest=2345145454"];
    [shareBuilder setTitle:@"GooglePlus Testing!" description:@"I have just completed new record."        thumbnailURL:[NSURL URLWithString:@"https://javiyavandan.blogspot.com"]];
     
    //[shareBuilder setCallToActionButtonWithLabel:@"ACCEPT"                                               URL:[NSURL URLWithString:@"https://javiyavandan.blogspot.com/"]                                         deepLinkID:@"rest=2345145454"];
    [shareBuilder open];
    }
    else
    {
        id<GPPShareBuilder> shareBuilder = [[GPPShare sharedInstance] shareDialog];
        
        // This line will fill out the title, description, and thumbnail from
        // the URL that you are sharing and includes a link to that URL.
        [shareBuilder setURLToShare:[NSURL URLWithString:@"https://javiyavandan.blogspot.com"]];
        
        // Optionally attach a deep link ID for your mobile app
        [shareBuilder setContentDeepLinkID:@"GooglePlus=23451"];
        
        [shareBuilder open];
        
    }
}


#pragma mark - GPPShareDelegate

- (void)finishedSharingWithError:(NSError *)error {
    NSString *text;
    if (!error) {
        text = @"Success";
    } else if (error.code == kGPPErrorShareboxCanceled) {
        text = @"Canceled";
    } else {
        text = [NSString stringWithFormat:@"Error (%@)", [error localizedDescription]];
    }
    lblShare.hidden = NO;
    lblShare.text = [NSString stringWithFormat:@"Status: %@", text];
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

@end
