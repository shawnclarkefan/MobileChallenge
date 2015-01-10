//
//  RankingsTableViewCell.h
//  MobileChallenge
//
//  Created by fan gang on 10/1/15.
//  Copyright (c) 2015 Shawn Fan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankingsTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UITextView *playerRank;
@property (nonatomic, strong) IBOutlet UITextView *playerName;
@property (nonatomic, strong) IBOutlet UITextView *playerPoints;


@end
