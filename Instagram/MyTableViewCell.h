//
//  MyTableViewCell.h
//  Instagram
//
//  Created by Puneet Makkar on 9/14/15.
//  Copyright © 2015 Puneet Makkar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *myMovieLabel;
@property (weak, nonatomic) IBOutlet UILabel *myDurationLabel;

@end
