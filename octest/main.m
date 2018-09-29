//
//  main.m
//  octest
//
//  Created by Karl Traunmüller on 29.09.18.
//  Copyright © 2018 microLARGE. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TestRunner.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *testBundlePath = [NSString stringWithCString:argv[1] encoding:NSUTF8StringEncoding];

        TestRunner *runner = [TestRunner new];
        [runner runTestInBundleAtPath:testBundlePath];
    }
    return 0;
}
