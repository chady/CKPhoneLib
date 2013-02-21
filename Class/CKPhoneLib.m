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


-(NSString *)_normalize:(NSString *)number {
    NSString *condensed = [[number componentsSeparatedByCharactersInSet:
                                   [[NSCharacterSet characterSetWithCharactersInString:@"+0123456789"]
                                    invertedSet]]
                                  componentsJoinedByString:@""];
    
    return condensed;
}

-(NSInteger)_countryCodePosition:(NSString *)normalizedNumber {
    
  
    NSDictionary * precompiled =
  @{@"6":@{@"6":@0,@"3":@0,@"7":@{@"6":@0,@"3":@0,@"7":@0,@"9":@0,@"2":@0,@"8":@0,@"1":@0,@"4":@0,@"0":@0,@"5":@0},@"9":@{@"6":@0,@"3":@0,@"7":@0,@"9":@0,@"2":@0,@"8":@0,@"1":@0,@"4":@0,@"0":@0,@"5":@0},@"2":@0,@"8":@{@"6":@0,@"3":@0,@"7":@0,@"9":@0,@"2":@0,@"8":@0,@"1":@0,@"4":@0,@"0":@0,@"5":@0},@"1":@0,@"4":@0,@"0":@0,@"5":@0},@"3":@{@"6":@0,@"3":@0,@"7":@{@"6":@0,@"3":@0,@"7":@0,@"9":@0,@"2":@0,@"8":@0,@"1":@0,@"4":@0,@"0":@0,@"5":@0},@"9":@0,@"2":@0,@"8":@{@"6":@0,@"3":@0,@"7":@0,@"9":@0,@"2":@0,@"8":@0,@"1":@0,@"4":@0,@"0":@0,@"5":@0},@"1":@0,@"4":@0,@"0":@0,@"5":@{@"6":@0,@"3":@0,@"7":@0,@"9":@0,@"2":@0,@"8":@0,@"1":@0,@"4":@0,@"0":@0,@"5":@0}},@"7":@0,@"9":@{@"6":@{@"6":@0,@"3":@0,@"7":@0,@"9":@0,@"2":@0,@"8":@0,@"1":@0,@"4":@0,@"0":@0,@"5":@0},@"3":@0,@"7":@{@"6":@0,@"3":@0,@"7":@0,@"9":@0,@"2":@0,@"8":@0,@"1":@0,@"4":@0,@"0":@0,@"5":@0},@"9":@{@"6":@0,@"3":@0,@"7":@0,@"9":@0,@"2":@0,@"8":@0,@"1":@0,@"4":@0,@"0":@0,@"5":@0},@"2":@0,@"8":@0,@"1":@0,@"4":@0,@"0":@0,@"5":@0},@"2":@{@"6":@{@"6":@0,@"3":@0,@"7":@0,@"9":@0,@"2":@0,@"8":@0,@"1":@0,@"4":@0,@"0":@0,@"5":@0},@"3":@{@"6":@0,@"3":@0,@"7":@0,@"9":@0,@"2":@0,@"8":@0,@"1":@0,@"4":@0,@"0":@0,@"5":@0},@"7":@0,@"9":@{@"6":@0,@"3":@0,@"7":@0,@"9":@0,@"2":@0,@"8":@0,@"1":@0,@"4":@0,@"0":@0,@"5":@0},@"2":@{@"6":@0,@"3":@0,@"7":@0,@"9":@0,@"2":@0,@"8":@0,@"1":@0,@"4":@0,@"0":@0,@"5":@0},@"8":@{@"6":@0,@"3":@0,@"7":@0,@"9":@0,@"2":@0,@"8":@0,@"1":@0,@"4":@0,@"0":@0,@"5":@0},@"1":@{@"6":@0,@"3":@0,@"7":@0,@"9":@0,@"2":@0,@"8":@0,@"1":@0,@"4":@0,@"0":@0,@"5":@0},@"4":@{@"6":@0,@"3":@0,@"7":@0,@"9":@0,@"2":@0,@"8":@0,@"1":@0,@"4":@0,@"0":@0,@"5":@0},@"0":@0,@"5":@{@"6":@0,@"3":@0,@"7":@0,@"9":@0,@"2":@0,@"8":@0,@"1":@0,@"4":@0,@"0":@0,@"5":@0}},@"8":@{@"6":@0,@"3":@{@"6":@0,@"3":@0,@"7":@0,@"9":@0,@"2":@0,@"8":@0,@"1":@0,@"4":@0,@"0":@0,@"5":@0},@"7":@{@"6":@0,@"3":@0,@"7":@0,@"9":@0,@"2":@0,@"8":@0,@"1":@0,@"4":@0,@"0":@0,@"5":@0},@"9":@{@"6":@0,@"3":@0,@"7":@0,@"9":@0,@"2":@0,@"8":@0,@"1":@0,@"4":@0,@"0":@0,@"5":@0},@"2":@0,@"8":@{@"6":@0,@"3":@0,@"7":@0,@"9":@0,@"2":@0,@"8":@0,@"1":@0,@"4":@0,@"0":@0,@"5":@0},@"1":@0,@"4":@0,@"0":@{@"6":@0,@"3":@0,@"7":@0,@"9":@0,@"2":@0,@"8":@0,@"1":@0,@"4":@0,@"0":@0,@"5":@0},@"5":@{@"6":@0,@"3":@0,@"7":@0,@"9":@0,@"2":@0,@"8":@0,@"1":@0,@"4":@0,@"0":@0,@"5":@0}},@"1":@0,@"4":@{@"6":@0,@"3":@0,@"7":@0,@"9":@0,@"2":@{@"6":@0,@"3":@0,@"7":@0,@"9":@0,@"2":@0,@"8":@0,@"1":@0,@"4":@0,@"0":@0,@"5":@0},@"8":@0,@"1":@0,@"4":@0,@"0":@0,@"5":@0},@"5":@{@"6":@0,@"3":@0,@"7":@0,@"9":@{@"6":@0,@"3":@0,@"7":@0,@"9":@0,@"2":@0,@"8":@0,@"1":@0,@"4":@0,@"0":@0,@"5":@0},@"2":@0,@"8":@0,@"1":@0,@"4":@0,@"0":@{@"6":@0,@"3":@0,@"7":@0,@"9":@0,@"2":@0,@"8":@0,@"1":@0,@"4":@0,@"0":@0,@"5":@0},@"5":@0}};

    // start with first letter.
    // very first character is assumed to be +, otherwsie, we shouldn't reach here.
    NSString * c = [NSString stringWithFormat:@"%c", [normalizedNumber characterAtIndex:1]];
    
    id res = [precompiled objectForKey:c];
    if (res) {
        // if it's a number, then we's a single digit country code.
        if ([res isKindOfClass:[NSNumber class]]) {
            return 2;
        } else {
            NSDictionary * res1 = (NSDictionary *)res;
            // check the second character
            c = [NSString stringWithFormat:@"%c", [normalizedNumber characterAtIndex:2]];
            res = [res1 objectForKey:c];
            if ([res isKindOfClass:[NSNumber class]]) {
                return 3;
            } else {
                res1 = (NSDictionary *)res;
                
                c = [NSString stringWithFormat:@"%c", [normalizedNumber characterAtIndex:3]];
                res = [res1 objectForKey:c];
                if ([res isKindOfClass:[NSNumber class]]) {
                    return 4;
                } else {
                    return 0;
                }
            }

        }
        
    }
    
  
    
    return 0; // This is an error.
}

-(NSDictionary *)extractPhoneComponents:(NSString *)number {
    
    NSString * normalized = [self _normalize:number];
    
    NSString * countryCode = self.fallbackCountryCode;
    NSString * phoneNumber = normalized;
    
    NSInteger total = [normalized length];
    if (total > 4) { // at least 4 characters to start checking
        // does the number contain an embedded country code?
        BOOL hasCountry = NO;
        if ([normalized characterAtIndex:0] == '+') {
            hasCountry = YES;
        } else {
            if ([normalized characterAtIndex:0] == '0') {
                if ([normalized characterAtIndex:1] == '0') {
                    hasCountry = YES;
                    
                    // replace the two zeros at the start with a + 
                    normalized = [normalized stringByReplacingCharactersInRange:NSMakeRange(0, 2) withString:@"+"];
                    total--;
                    
                }
            }
        }
        
        if (hasCountry) {
            // we need to scan the number for the correct country code.
            
            NSInteger pos = [self _countryCodePosition:normalized];
            countryCode = [normalized substringToIndex:pos];
            phoneNumber = [normalized substringFromIndex:pos];
            
        }
    
    }
    return @{@"countryCode":countryCode, @"phoneNumber":phoneNumber};
}

@end