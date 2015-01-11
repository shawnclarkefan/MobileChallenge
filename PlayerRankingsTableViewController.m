//
//  PlayerRankingsTableViewController.m
//  MobileChallenge
//
//  Created by fan gang on 10/1/15.
//  Copyright (c) 2015 Shawn Fan. All rights reserved.
//

#import "PlayerRankingsTableViewController.h"
#import "RankingsTableViewCell.h"
#import "AppDelegate.h"
#import "SWRevealViewController.h"

#define kPlayerRankingsURL [NSURL URLWithString:@"https://www.kimonolabs.com/api/bg6tcuuq?apikey=xgp4nU6xA9UcBWSe0MIHcBVbAWz5v4wR"]


@interface PlayerRankingsTableViewController () {
    
}

@property (nonatomic, strong) NSArray *playerRankings;

@end

@implementation PlayerRankingsTableViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    dispatch_async(kBgQueue, ^{
        NSData *data = [NSData dataWithContentsOfURL:
                        kPlayerRankingsURL];
        [self performSelectorOnMainThread: @selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
    });
    
    /*
    self.rankingsHomeButton.target = self.revealViewController;
    self.rankingsHomeButton.action = @selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be rexrcreated.
}

- (void)fetchedData:(NSData *)responseData {
    NSError* error;
    NSDictionary *json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          options:kNilOptions
                          error:&error];
    
    NSArray *myPlayerRankings = [[json objectForKey:@"results"]objectForKey:@"collection1"];
    self.playerRankings = myPlayerRankings;
    
    [self.tableView reloadData];
    
    NSLog(@"%@", self.playerRankings);

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.playerRankings count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RankingsTableViewCell *cell = (RankingsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = (RankingsTableViewCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    NSDictionary *rankings = [self.playerRankings objectAtIndex: indexPath.row];
    
    NSString *rank = [rankings objectForKey:@"rank"];
    NSString *name = [rankings objectForKey:@"name"];
    NSString *points = [rankings objectForKey:@"points"];
    
    
    cell.playerRank.text = rank;
    cell.playerName.text = name;
    cell.playerPoints.text = [NSString stringWithFormat:@"%@", points];

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
