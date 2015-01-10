//
//  CalenderTableViewCell.h
//  MobileChallenge
//
//  Created by fan gang on 8/1/15.
//  Copyright (c) 2015 Shawn Fan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalenderTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UITextField *whatText;
@property (strong, nonatomic) IBOutlet UITextField *whereText;
@property (strong, nonatomic) IBOutlet UITextField *whenText;

@end
