//
//  ListDataDoc.h
//  ADBFileTransfer
//
//  Created by Saurabh Joshi on 7/21/14.
//  Copyright (c) 2014 CollegeCODE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListData.h"
@class ListDataDoc;

@interface ListDataDoc : NSObject

@property (strong) ListData *data;
@property (strong) NSImage *thumbImage;

- (id)initWithTitle:(NSString*)title size:(float)size thumbImage:(NSImage *)thumbImage;

@end