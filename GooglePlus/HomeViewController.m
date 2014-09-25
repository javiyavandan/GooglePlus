//
//  HomeViewController.m
//  GooglePlus
//
//  Created by WeTheDevelopers on 18/08/14.
//  Copyright (c) 2014 WeTheDevelopers. All rights reserved.
//

#import "HomeViewController.h"
#import "SigninViewController.h"
#import "ShareViewController.h"
#import "GooglePlusFriendsViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
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
    self.tblViewdata.delegate = self;
    self.tblViewdata.dataSource = self;
    arrTbldata = [[NSMutableArray alloc] initWithObjects:@"Signin",@"Share",@"People", nil];
    // Do any additional setup after loading the view.
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
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [arrTbldata objectAtIndex:indexPath.row];
    //NSString *text = [NSString stringWithCharacters:<#(const unichar *)#> length:<#(NSUInteger)#>]

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0)
    {
        SigninViewController *signIn = (SigninViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"SigninViewController"];
        [self.navigationController pushViewController:signIn animated:YES];
    }
    else if(indexPath.row == 1)
    {
        ShareViewController *share = (ShareViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ShareViewController"];
        [self.navigationController pushViewController:share animated:YES];
    }
    else if (indexPath.row == 2)
    {
        if([GPPSignIn sharedInstance].authentication)
        {
            GooglePlusFriendsViewController *people = (GooglePlusFriendsViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"GooglePlusFriendsViewController"];
            [self.navigationController pushViewController:people animated:YES];
            
        }
        else
        {
            UIAlertView *alertToshow = [[UIAlertView alloc]initWithTitle:@"GooglePlus" message:@"Signin to Find people" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertToshow show];
        }
    }
}

#pragma SignIN Delegate
- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error {
    NSLog(@"Received error %@ and auth object %@",error, auth);
}

- (void)presentSignInViewController:(UIViewController *)viewController {
    // This is an example of how you can implement it if your app is navigation-based.
    [[self navigationController] pushViewController:viewController animated:YES];
}

@end
