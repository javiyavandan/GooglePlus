//
//  ShareViewController.h
//  GooglePlus
//
//  Created by WeTheDevelopers on 21/08/14.
//  Copyright (c) 2014 WeTheDevelopers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GooglePlus/GooglePlus.h>
#import <GoogleOpenSource/GoogleOpenSource.h>
@interface ShareViewController : UIViewController<GPPShareDelegate>
@property (strong, nonatomic) IBOutlet UIButton *btnSharebutton;
@property (strong, nonatomic) IBOutlet UILabel *lblUserstatus;
@property (strong, nonatomic) IBOutlet UILabel *lblShare;

@end
