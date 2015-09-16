//
//  PhotoDetailsViewController.m
//  Instagram
//
//  Created by Puneet Makkar on 9/14/15.
//  Copyright © 2015 Puneet Makkar. All rights reserved.
//

#import "PhotoDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "MyDetailTableViewCell.h"

@interface PhotoDetailsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
//@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

//@property (weak, nonatomic) IBOutlet UILabel *Summary;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@end

@implementation PhotoDetailsViewController

@synthesize url;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    
    NSLog(@"url: %@", self.url );
    NSLog(@"synopsis: %@", self.synopsis );
    //self.Summary.text = self.summary;
    self.synopsisLabel.text = self.synopsis;
    [self.myTableView reloadData];
    // Do any additional setup after loading the view.
}


- (long)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"DetailTableItem";
    
    MyDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    NSString *imageUrl = self.url;
    NSRange range = [imageUrl rangeOfString:@".*cloudfront.net/" options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        imageUrl = [imageUrl stringByReplacingCharactersInRange:range withString:@"https://content6.flixster.com/"];
    }
    [cell.myDetailImageView setImageWithURL:[NSURL URLWithString:imageUrl]];
    //self.Summary.text = self.summary;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"Section: %ld", indexPath.row);
    //[self performSegueWithIdentifier:@"showPhotoDetail" sender:self];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
