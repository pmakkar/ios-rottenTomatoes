//
//  PhotoDetailsViewController.m
//  Instagram
//
//  Created by Puneet Makkar on 9/14/15.
//  Copyright © 2015 Puneet Makkar. All rights reserved.
//

#import "PhotoDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface PhotoDetailsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *MyTableView;

@end

@implementation PhotoDetailsViewController

@synthesize url;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.MyTableView.dataSource = self;
    self.MyTableView.delegate = self;
    
    NSLog(@"Detail view loaded: %@", self.url );
    // Do any additional setup after loading the view.
}


- (long)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    [cell.imageView setImageWithURL:[NSURL URLWithString:self.url] placeholderImage:[UIImage imageNamed:@"test.png"]];
    
    return cell;
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
