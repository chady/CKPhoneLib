//
//  CKPhoneLib.m
//  CKPhoneLibTest
//
//  Created by Chady Kassouf on 2/20/13.
//  Copyright (c) 2013 Chady Kassouf. All rights reserved.
//

#import "CKPhoneLib.h"


@interface CKPhoneLib () {
    
    
    
}

@end

@implementation CKPhoneLib


+ (CKPhoneLib *)sharedClient {
    static CKPhoneLib *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[CKPhoneLib alloc] init];
    });
    
    return _sharedClient;
}



-(NSDictionary *)parseNumber:(NSString *)number {
    
    
    return @{};
}

@end