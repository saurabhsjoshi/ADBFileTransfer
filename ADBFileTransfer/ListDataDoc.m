//
//  ListDataDoc.m
//  ADBFileTransfer
//
//  Created by Saurabh Joshi on 7/21/14.
//  Copyright (c) 2014 CollegeCODE. All rights reserved.
//

#import "ListDataDoc.h"
#import "ListData.h"

@implementation ListDataDoc

- (id)initWithTitle:(NSString *)title size:(float)size thumbImage:(NSImage *)thumbImage{
    if ((self = [super init])) {
        self.data = [[ListData alloc] initWithTitle:title size:size];
        self.thumbImage = thumbImage;
    }
    return self;
}

@end