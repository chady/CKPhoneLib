//
//  CKPhoneLib.h
//  CKPhoneLibTest
//
//  Created by Chady Kassouf on 2/20/13.
//  Copyright (c) 2013 Chady Kassouf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CKPhoneLib : NSObject

@property (nonatomic, strong) NSString * fallbackCountryCode;

+(CKPhoneLib *)sharedClient;

-(NSDictionary *)parseNumber:(NSString *)number;

@end

