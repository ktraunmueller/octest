//
//  TestRunner.h
//  octest
//
//  Created by Karl Traunmüller on 29.09.18.
//  Copyright © 2018 microLARGE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestRunner : NSObject

- (void)runTestInBundleAtPath:(NSString *)testBundlePath;

@end
