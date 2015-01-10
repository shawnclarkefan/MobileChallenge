//
//  PlayerRankingsTableViewController.m
//  MobileChallenge
//
//  Created by fan gang on 10/1/15.
//  Copyright (c) 2015 Shawn Fan. All rights reserved.
//

#import "PlayerRankingsTableViewController.h"
#import "RankingsTableViewCell.h"

#define kBgQueue dispatch_get_global_queue (DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define kPlayerRankingsURL [NSURL URLWithString:@"https://www.kimonolabs.com/api/bg6tcuuq?apikey=xgp4nU6xA9UcBWSe0MIHcBVbAWz5v4wR"]


@interface PlayerRankingsTableViewController (){
    NSArray *playerRankings;
}



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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchedData:(NSData *)responseData {
    NSError* error;
    NSDictionary *json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          options:kNilOptions
                          error:&error];
    
    NSArray *playerRankings = [[json objectForKey:@"results"]objectForKey:@"collection1"];
    NSLog(@"%@", playerRankings);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [playerRankings count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RankingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    NSDictionary *rankings = [playerRankings objectAtIndex:indexPath.row];
    
    NSString *rank = [rankings objectForKey:@"rank"];
    NSString *name = [rankings objectForKey:@"name"];
    NSString *points = [rankings objectForKey:@"points"];
    
    [cell.playerRank setText:rank];
    cell.playerName.text = name;
    cell.playerPoints.text = points;


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
