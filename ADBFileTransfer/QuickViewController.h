//
//  QuickViewController.h
//  ADBFileTransfer
//
//  Created by Saurabh Joshi on 7/22/14.
//  Copyright (c) 2014 CollegeCODE. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface QuickViewController : NSViewController

@property (strong) NSIndexSet *file_list;
@property (weak) IBOutlet NSTextField *lbl_items_num;

@end