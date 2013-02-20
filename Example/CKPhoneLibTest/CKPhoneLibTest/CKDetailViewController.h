//
//  CKDetailViewController.h
//  CKPhoneLibTest
//
//  Created by Chady Kassouf on 2/20/13.
//  Copyright (c) 2013 Chady Kassouf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CKDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
