//
//  PhotoGalleryTableViewController.m
//  MobileChallenge
//
//  Created by fan gang on 11/1/15.
//  Copyright (c) 2015 Shawn Fan. All rights reserved.
//

#import "PhotoGalleryTableViewController.h"
#import "AppDelegate.h"

#define kPhotoGalleryURL [NSURL URLWithString:@"https://www.kimonolabs.com/api/2v35aqn0?apikey=xgp4nU6xA9UcBWSe0MIHcBVbAWz5v4wR"]


@interface PhotoGalleryTableViewController ()

@property (nonatomic, strong) NSArray *photoGallery;

@end

@implementation PhotoGalleryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    dispatch_async(kBgQueue, ^{
        NSData *data = [NSData dataWithContentsOfURL:kPhotoGalleryURL];
        [self performSelectorOnMainThread:@selector(fetchedGalleryData:) withObject:data waitUntilDone:YES];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

-(void)fetchedGalleryData:(NSData *)galleryResponseData {
    NSError *error;
    NSDictionary *json = [NSJSONSerialization
                          JSONObjectWithData:galleryResponseData
                          options:kNilOptions
                          error:&error];
    NSArray *myPhotoGallery = [[json objectForKey:@"results"]objectForKey:@"collection1"];
    myPhotoGallery = self.photoGallery;
    NSLog(@"%@", self.photoGallery);
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.photoGallery count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"galleryCell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"galleryCell"];
    }
    
    NSDictionary *galleries = [self.photoGallery objectAtIndex:indexPath.row];
    
    NSString *description = [[galleries objectForKey:@"description"] objectForKey:@"text"];
    NSMutableString *images = [[galleries objectForKey:@"photo"] objectForKey:@"src"];
    
    NSURL *imageURL = [NSURL URLWithString:images];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *img = [[UIImage alloc] initWithData:imageData];
    
    cell.textLabel.text = description;
    cell.imageView.image = img;
    
    
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
