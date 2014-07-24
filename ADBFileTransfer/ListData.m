//
//  ListData.m
//  ADBFileTransfer
//
//  Created by Saurabh Joshi on 7/21/14.
//  Copyright (c) 2014 CollegeCODE. All rights reserved.
//

#import "ListData.h"

@implementation ListData

- (id)initWithTitle:(NSString*)title type:(int)type {
    if ((self = [super init])) {
        self.title = title;
        self.type = type;
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.title forKey:@"Title"];
    [encoder encodeObject:[NSNumber numberWithInt:self.type] forKey:@"Type"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class varsx
        self.title = [decoder decodeObjectForKey:@"Title"];
        self.type = [((NSNumber*)[decoder decodeObjectForKey:@"Type"]) intValue];
    }
    return self;
}

@end

