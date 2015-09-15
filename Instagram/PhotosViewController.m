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
@property (nonatomic,strong) NSURLSession *session;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property(nonatomic,retain) NSArray *images;

@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"in view load");
    
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    
    UINib *movieCellNib = [UINib nibWithNibName:@"MyTableViewCell" bundle:nil];
    [self.myTableView registerNib:movieCellNib forCellReuseIdentifier:@"MyTableViewCell"];
    
    NSURL *url = [NSURL URLWithString:@"https://api.instagram.com/v1/media/popular?client_id=68f79eddb25342a595f46befb3efe00e"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSLog(@"response: %@", responseDictionary);
        self.images = responseDictionary[@"data"];
        [self.myTableView reloadData];
    }];
}

- (long)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"com.yahoo.example"];
    
    NSString *imageUrl = self.images[indexPath.row][@"images"][@"low_resolution"][@"url"];
    
    // Image resizing test 1
    // NSFL *height = [self.images[indexPath.row][@"images"][@"low_resolution"][@"height"] floatValue];
    // float *width = self.images[indexPath.row][@"images"][@"low_resolution"][@"width"];
    // [cell.imageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"test.png"]];
    
    // Image resizing test 2
    // CGFloat imageRatio = [width / height float];
    // cell.imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * imageRatio);
    
    [cell.myImageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"test.png"]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Image resizing test 3
    // CGSize imageSize = [[UIImage imageNamed:self.theData[indexPath.row]] size];
    // CGFloat height = [self.images[indexPath.row][@"images"][@"low_resolution"][@"height"] floatValue]/[self.images[indexPath.row][@"images"][@"low_resolution"][@"width"] floatValue] * (tableView.frame.size.width - 16);
    return 180;
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSLog(@"In segue");

    if ([segue.identifier isEqualToString:@"showPhotoDetail"]) {
        PhotoDetailsViewController *photoDetailsViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [self.myTableView indexPathForSelectedRow];
        photoDetailsViewController.url = self.images[indexPath.row][@"images"][@"low_resolution"][@"url"];
     }
}
@end
