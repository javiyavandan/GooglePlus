//
//  HomeViewController.h
//  GooglePlus
//
//  Created by WeTheDevelopers on 18/08/14.
//  Copyright (c) 2014 WeTheDevelopers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tblViewdata;

@end
