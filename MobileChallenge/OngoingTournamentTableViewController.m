//
//  OngoingTournamentTableViewController.m
//  MobileChallenge
//
//  Created by fan gang on 11/1/15.
//  Copyright (c) 2015 Shawn Fan. All rights reserved.
//

#import "OngoingTournamentTableViewController.h"
#import "AppDelegate.h"

#define kOngoingTournamentURL [NSURL URLWithString:@"https://www.kimonolabs.com/api/d4leq2cs?apikey=xgp4nU6xA9UcBWSe0MIHcBVbAWz5v4wR"]


@interface OngoingTournamentTableViewController ()

@property (nonatomic, strong) NSArray *ongoingTournament;

@end

@implementation OngoingTournamentTableViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_async(kBgQueue, ^{
        NSData *data = [NSData dataWithContentsOfURL:kOngoingTournamentURL];
        [self performSelectorOnMainThread:@selector(fetchedTournamentData:)
                               withObject:data waitUntilDone:YES];
    });
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchedTournamentData:(NSData *)tournamentResponseData {
    NSError *error;
    NSDictionary *json = [NSJSONSerialization
                          JSONObjectWithData:tournamentResponseData
                          options:kNilOptions
                          error:&error];
    
    NSArray *myOngoingTournament = [[json objectForKey:@"results"] objectForKey:@"collection1"];
    
    self.ongoingTournament = myOngoingTournament;
    
    [self.tableView reloadData];
    
    NSLog(@"%@", self.ongoingTournament);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.ongoingTournament count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tournamentCell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"tournamentCell"];
    }
    
    NSDictionary *tournaments = [self.ongoingTournament objectAtIndex:indexPath.row];
    
    NSString *title = [[tournaments objectForKey:@"Title"] objectForKey:@"text"];
    NSString *venue = [tournaments objectForKey:@"Venue"];
    
    cell.textLabel.text = title;
    cell.detailTextLabel.text = venue;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
