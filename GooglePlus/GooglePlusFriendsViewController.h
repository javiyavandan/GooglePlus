//
//  GooglePlusFriendsViewController.h
//  GooglePlus
//
//  Created by WeTheDevelopers on 21/08/14.
//  Copyright (c) 2014 WeTheDevelopers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GooglePlus/GooglePlus.h>
#import <GoogleOpenSource/GoogleOpenSource.h>

@interface GooglePlusFriendsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tblPeoples;

@end
