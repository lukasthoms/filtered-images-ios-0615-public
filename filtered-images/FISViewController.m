//
//  FISViewController.m
//  filtered-images
//
//  Created by Joe Burgess on 7/23/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISViewController.h"
#import "UIImage+Filters.h"
#import <MBProgressHUD.h>

@interface FISViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)vignetterTapped:(id)sender;

@end

@implementation FISViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imageView.image = [UIImage imageNamed:@"Mickey.jpg"];

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)vignetterTapped:(id)sender {
    [self transformImageWithFilter:UIImageFilterTypeVignette];

}

- (IBAction)sepiaTapped:(id)sender {
    [self transformImageWithFilter:UIImageFilterTypeSepia];

}

- (IBAction)invertedTapped:(id)sender {
    [self transformImageWithFilter:UIImageFilterTypeColorInvert];
}

-(void)transformImageWithFilter: (UIImageFilterType) kFilterType {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        UIImage *filtered = [[UIImage imageNamed:@"Mickey.jpg"] imageWithFilter:kFilterType];
        NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
        [mainQueue addOperationWithBlock:^{
            self.imageView.image = filtered;
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }];
        
    }];
}



@end
