//
//  GooglePlusFriendsViewController.m
//  GooglePlus
//
//  Created by WeTheDevelopers on 21/08/14.
//  Copyright (c) 2014 WeTheDevelopers. All rights reserved.
//

#import "GooglePlusFriendsViewController.h"

@interface GooglePlusFriendsViewController ()

@end

@implementation GooglePlusFriendsViewController
{
    NSMutableArray *arrTbldata;
}

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
    //arrTbldata = [[NSMutableArray alloc] initWithObjects:@"Signin",@"Share",@"People", nil];
    GTLServicePlus* plusService = [[GTLServicePlus alloc] init] ;
    plusService.retryEnabled = YES;
    [plusService setAuthorizer:[GPPSignIn sharedInstance].authentication];
    
    GTLQueryPlus *query =
    [GTLQueryPlus queryForPeopleListWithUserId:@"me"
                                    collection:kGTLPlusCollectionVisible];
    [plusService executeQuery:query
            completionHandler:^(GTLServiceTicket *ticket,
                                GTLPlusPeopleFeed *peopleFeed,
                                NSError *error) {
                if (error) {
                    GTMLoggerError(@"Error: %@", error);
                } else {
                    // Get an array of people from GTLPlusPeopleFeed
                    arrTbldata = [peopleFeed.items mutableCopy] ;
                    [self.tblPeoples reloadData];
                }
            }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews {
    [self.tblPeoples setFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height )];
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



#pragma Tableview methods
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrTbldata count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kCellIdentifier = @"Cell";
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:kCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    GTLPlusPerson *person = [arrTbldata objectAtIndex:indexPath.row];
    cell.textLabel.text = person.displayName;
    dispatch_queue_t backgroundQueue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                              0);
    dispatch_async(backgroundQueue, ^{
        NSData *imageData = nil;
        NSString *imageURLString = person.image.url;
        if (imageURLString) {
            NSURL *imageURL = [NSURL URLWithString:imageURLString];
            imageData = [NSData dataWithContentsOfURL:imageURL];
        }
        
        cell.imageView.image = [[UIImage alloc]
                                initWithData:imageData];
    });

    return cell;
}

@end
