//
//  OngoingTournamentViewController.m
//  MobileChallenge
//
//  Created by fan gang on 5/1/15.
//  Copyright (c) 2015 Shawn Fan. All rights reserved.
//

#import "OngoingTournamentViewController.h"
#import "SWRevealViewController.h"
#define API_KEY @"xgp4nU6xA9UcBWSe0MIHcBVbAWz5v4wR"

@interface OngoingTournamentViewController (){
    NSMutableArray *myObject;
    NSDictionary *dictionary;
    
    NSString *title;
    NSString *deadline;
    NSString *duration;
    NSString *venue;

}

@end

@implementation OngoingTournamentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    title = @"Title";
    deadline = @"Deadline";
    duration = @"Duration";
    venue = @"Venue";
    
    myObject = [[NSMutableArray alloc] init];
    
    NSData *jsonSource = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://www.kimonolabs.com/api/d4leq2cs?key=&@"]];
    
    id jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonSource options:NSJSONReadingMutableContainers error:nil];
    
    for (NSDictionary *dataDict in myObject) {
        NSString *titleData = [dataDict objectForKey:@"Title"];
        NSString *deadlineData = [dataDict objectForKey:@"Deadline"];
        NSString *durationData = [dataDict objectForKey:@"Duration"];
        NSString *venueData = [dataDict objectForKey:@"Venue"];
        
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                      titleData, title,
                      deadlineData,deadline,
                      durationData, duration,
                      venueData, venue,
                      nil];
        
        [myObject addObject:dictionary];
        
        returnButton.target = self.revealViewController;
        returnButton.action = @selector(revealToggle:);
        
                      
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UITableView methods

-(NSInteger *)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return myObject.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"item";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *tmpDict = [myObject objectAtIndex:indexPath.row];
    
    NSMutableString *text;
    text = [NSMutableString stringWithFormat:@"%@",
            [tmpDict objectForKeyedSubscript:title]];
    NSMutableString *durationDetail;
    durationDetail = [NSMutableString stringWithFormat:@"%@",
            [tmpDict objectForKey:duration]];
    NSMutableString *deadlineDetail;
    deadlineDetail = [NSMutableString stringWithFormat:@"%@",
                      [tmpDict objectForKey:deadline]];
    NSMutableString *venueDetail;
    venueDetail = [NSMutableString stringWithFormat:@"%@",
                   [tmpDict objectForKey:venue]];
    
    
    [cell.textLabel setText:text];
    
    
    return cell;
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
