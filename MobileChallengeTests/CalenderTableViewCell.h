//
//  CalenderTableViewCell.h
//  MobileChallenge
//
//  Created by fan gang on 11/1/15.
//  Copyright (c) 2015 Shawn Fan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalenderTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UITextView *whatTournament;
@property (nonatomic, strong) IBOutlet UITextView *whereTournament;
@property (nonatomic, strong) IBOutlet UITextView *whenTournament;

@end
