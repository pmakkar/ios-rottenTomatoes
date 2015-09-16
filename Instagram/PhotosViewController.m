//
//  PhotosViewController.m
//  Instagram
//
//  Created by Puneet Makkar on 9/14/15.
//  Copyright © 2015 Puneet Makkar. All rights reserved.
//

#import "PhotosViewController.h"
#import "PhotoDetailsViewController.h"
#import "MyTableViewCell.h"
#import "UIImageView+AFNetworking.h"


@interface PhotosViewController ()
//@property (nonatomic,strong) NSURLSession *session;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property(nonatomic,retain) NSArray *images;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
//@property (strong, nonatomic) IBOutlet UIView *errorView;

@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"in view load");
    
    // Getting refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.myTableView insertSubview:self.refreshControl atIndex:0];
    //[self onRefresh];
    
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    
    // Instagram
    // NSURL *url = [NSURL URLWithString:@"https://api.instagram.com/v1/media/popular?client_id=68f79eddb25342a595f46befb3efe00e"];
    
    // rotten tomatoes
    NSURL *url = [NSURL URLWithString:@"https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile1.json"];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSLog(@"response: %@", responseDictionary);
        
        // instagram
        //self.images = responseDictionary[@"data"];
        
        // rotten
        self.images = responseDictionary[@"movies"];
        
        [self.myTableView reloadData];
    }];
}

- (long)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return 5;
    return [self.images count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"com.yahoo.example"];
    
    // Instagram
    // NSString *imageUrl = self.images[indexPath.row][@"images"][@"low_resolution"][@"url"];
    
    // Rotten
    NSString *imageUrl = self.images[indexPath.row][@"posters"][@"thumbnail"];
    NSRange range = [imageUrl rangeOfString:@".*cloudfront.net/" options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        imageUrl = [imageUrl stringByReplacingCharactersInRange:range withString:@"https://content6.flixster.com/"];
    }
    
    cell.myMovieLabel.text = self.images[indexPath.row][@"title"];
    NSInteger i = (int) self.images[indexPath.row][@"runtime"];
    NSString *myString = [NSString stringWithFormat:@"%ld",i];
    cell.myDurationLabel.text = myString;
    
    
    [cell.myImageView setImageWithURL:[NSURL URLWithString:imageUrl]];
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
- (void)onRefresh {
    // Showing a loading state while waiting for movies API
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 240);
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
    [spinner startAnimating];
    
    NSURL *url = [NSURL URLWithString:@"https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47..."];
    
    // NSLog(@"Response %@", url);
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            // add the new view as a subview to an existing one (e.g. self.view)
            //[self.view addSubview:self.errorView];
            
        } else {
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.images = responseDictionary[@"movies"];
            [self.myTableView reloadData];
        }
        // End refreshing control
        [self.refreshControl endRefreshing];
        
        // Stop the loading animation
        [spinner stopAnimating];
    }];
}*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSLog(@"In segue");

    if ([segue.identifier isEqualToString:@"showPhotoDetail"]) {
        PhotoDetailsViewController *photoDetailsViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [self.myTableView indexPathForSelectedRow];
        // instagram
        // photoDetailsViewController.url = self.images[indexPath.row][@"images"][@"low_resolution"][@"url"];
        
        
        photoDetailsViewController.url = self.images[indexPath.row][@"posters"][@"detailed"];
        photoDetailsViewController.synopsis = self.images[indexPath.row][@"synopsis"];

     }
}
@end
