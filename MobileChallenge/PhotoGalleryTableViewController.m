//
//  PhotoGalleryTableViewController.m
//  MobileChallenge
//
//  Created by fan gang on 5/1/15.
//  Copyright (c) 2015 Shawn Fan. All rights reserved.
//

#import "PhotoGalleryTableViewController.h"
#define API_KEY @"xgp4nU6xA9UcBWSe0MIHcBVbAWz5v4wR"

@interface PhotoGalleryTableViewController ()
{
    NSMutableArray *myObject;
    NSDictionary *dictionary;
    NSString *description;
    NSString *photo;
    
}

@end

@implementation PhotoGalleryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    photo = @"photo";
    description = @"description";
    
    myObject = [[NSMutableArray alloc] init];
    
    
    NSString *urlAsString = [ NSString stringWithFormat:@"https://www.kimonolabs.com/api/2v35aqn0?apikey=xgp4nU6xA9UcBWSe0MIHcBVbAWz5v4wR"];
    NSData *jsonSource = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlAsString]];
    NSLog(@"%@", jsonSource);
    
    id jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonSource
                                                     options:NSJSONReadingMutableContainers
                                                       error:nil];
    
    for(NSDictionary *dataDict in jsonObjects) {
        NSString *photo_data = [dataDict objectForKey:@"photo"];
        NSString *description_data = [dataDict objectForKey:@"description"];
        
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                      photo_data, photo,
                      description_data, description,
                      nil];
        
        [myObject addObject:dictionary];
    }
    
    

    


    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

-( NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return myObject.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier= @"item";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    
    NSDictionary *tmpDict = [myObject objectAtIndex:indexPath.row];
    
    NSMutableString *text= [NSString stringWithFormat:@"%@",
                          [tmpDict objectForKeyedSubscript:description]];
    
    NSMutableString *images;
    images = [NSMutableString stringWithFormat:@"%@",
              [tmpDict objectForKey:photo]];
    
    NSURL *url = [NSURL URLWithString:[tmpDict objectForKey:photo]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    
    cell.textLabel.text = text;
    cell.imageView.frame = CGRectMake(0, 0, 80, 70);
    cell.imageView.image = img;

   
    
    // Configure the cell...
    
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
