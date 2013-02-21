//
//  CKDetailViewController.m
//  CKPhoneLibTest
//
//  Created by Chady Kassouf on 2/20/13.
//  Copyright (c) 2013 Chady Kassouf. All rights reserved.
//

#import "CKDetailViewController.h"
#import "CKPhoneLib.h"

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
        
        CKPhoneLib * phoneLib = [CKPhoneLib sharedClient];
        phoneLib.fallbackCountryCode = @"+961";
        
        NSString * phones = @"";
        NSArray * numbers = [self.detailItem objectForKey:@"numbers"];
        for (NSString * phone in numbers) {
            
            NSDictionary * num = [phoneLib extractPhoneComponents:phone];
            
            phones = [phones stringByAppendingFormat:@"\n\n%@\n - Country Code: %@\n - Phone Number:%@", phone, [num objectForKey:@"countryCode" ], [num objectForKey:@"phoneNumber" ]];
            
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
