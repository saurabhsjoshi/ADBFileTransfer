//
//  ListData.m
//  ADBFileTransfer
//
//  Created by Saurabh Joshi on 7/21/14.
//  Copyright (c) 2014 CollegeCODE. All rights reserved.
//

#import "ListData.h"

@implementation ListData

- (id)initWithTitle:(NSString*)title size:(float)size {
    if ((self = [super init])) {
        self.title = title;
        self.size = size;
    }
    return self;
}

@end

