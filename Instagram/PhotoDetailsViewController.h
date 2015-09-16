//
//  PhotoDetailsViewController.h
//  Instagram
//
//  Created by Puneet Makkar on 9/14/15.
//  Copyright © 2015 Puneet Makkar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoDetailsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSString *url;
//@property (nonatomic, strong) NSDictionary *selectedMovie;
@property (nonatomic, strong) NSString *synopsis;
@end
