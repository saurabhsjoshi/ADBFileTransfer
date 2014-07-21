//
//  ListData.h
//  ADBFileTransfer
//
//  Created by Saurabh Joshi on 7/21/14.
//  Copyright (c) 2014 CollegeCODE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListData : NSObject

@property (strong) NSString *title;
@property (assign) float size;

- (id)initWithTitle:(NSString*)title size:(float)rating;

@end