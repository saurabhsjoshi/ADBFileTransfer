//
//  ViewController.h
//  ADBFileTransfer
//
//  Created by Saurabh Joshi on 7/21/14.
//  Copyright (c) 2014 CollegeCODE. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "KPCScaleToFillNSImageView.h"

@interface ViewController : NSViewController

@property (strong) NSMutableArray *hist;
@property (strong) NSMutableArray *list_data;

@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSProgressIndicator *prg_loading;
@property (weak) IBOutlet NSTextField *lbl_cur;
@property (weak) IBOutlet KPCScaleToFillNSImageView *btn_home;

- (void)doubleClick:(id)nid;
- (void) populateAtPath;

@end

