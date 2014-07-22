//
//  AppDelegate.h
//  ADBFileTransfer
//
//  Created by Saurabh Joshi on 7/21/14.
//  Copyright (c) 2014 CollegeCODE. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ListDataDoc.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
+ (NSOperationQueue *)connectionQueue;
@end

