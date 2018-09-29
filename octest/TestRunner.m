//
//  TestRunner.m
//  octest
//
//  Created by Karl Traunmüller on 29.09.18.
//  Copyright © 2018 microLARGE. All rights reserved.
//

#import "TestRunner.h"

#import <XCTest/XCTest.h>

@implementation TestRunner

- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(bundleDidLoad:)
                                                     name:NSBundleDidLoadNotification
                                                   object:nil];
    }
    return self;
}

- (void)runTestInBundleAtPath:(NSString *)testBundlePath {
    NSBundle *testBundle = [NSBundle bundleWithPath:testBundlePath];
    [testBundle load];
}

- (void)bundleDidLoad:(NSNotification *)notification {
    NSLog(@"bundle did load: %@", notification.object);
    NSArray *loadedClasses = [notification.userInfo objectForKey:NSLoadedClasses];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    NSMutableArray *testClasses = [NSMutableArray new];
    for (NSString *className in loadedClasses) {
        Class class = NSClassFromString(className);
        NSLog(@"found class %@", class);
        if ([class instancesRespondToSelector:@selector(runTest)]) {
            [testClasses addObject:class];
        }
    }
    
    NSLog(@"found %lu test classes", [testClasses count]);
    for (Class testClass in testClasses) {
        XCTestSuite *suite = [XCTestSuite testSuiteForTestCaseClass:testClass];
        NSLog(@"running suite %@ (%lu tests)...", suite, [suite.tests count]);
        [suite runTest];
    }
    NSLog(@"done");
}

@end
