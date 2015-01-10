//
//  OngoingTournamentViewController.h
//  MobileChallenge
//
//  Created by fan gang on 5/1/15.
//  Copyright (c) 2015 Shawn Fan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OngoingTournamentViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *tableData;
    IBOutlet UIBarButtonItem *returnButton;
}
@end
