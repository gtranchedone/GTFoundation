//
//  NSString+Crypto.h
//  Pods
//
//  Created by Gianluca Tranchedone on 05/12/2013.
//
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

@interface NSString (Crypto)

- (NSString *)md5String;

@end
