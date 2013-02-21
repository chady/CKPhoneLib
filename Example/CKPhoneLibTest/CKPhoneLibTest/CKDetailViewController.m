//
//  CKDetailViewController.m
//  CKPhoneLibTest
//
//  Created by Chady Kassouf on 2/20/13.
//  Copyright (c) 2013 Chady Kassouf. All rights reserved.
//

#import "CKDetailViewController.h"

@interface CKDetailViewController ()
- (void)configureView;
@end

@implementation CKDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
       
        self.nameLabel.text = [self.detailItem objectForKey:@"name"];
        
        NSString * phones = @"";
        NSArray * numbers = [self.detailItem objectForKey:@"numbers"];
        for (NSString * phone in numbers) {
            
            phones = [phones stringByAppendingFormat:@"\n%@ -> (%@) (%@)", phone, @"blah", @"foo"];
            
        }
        
        self.phonesView.text = phones;
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
