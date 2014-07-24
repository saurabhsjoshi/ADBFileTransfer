//
//  ViewController.h
//  ADBFileTransfer
//
//  Created by Saurabh Joshi on 7/21/14.
//  Copyright (c) 2014 CollegeCODE. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ViewController : NSViewController

@property (strong) NSMutableArray *hist;
@property (strong) NSMutableArray *list_data;
@property (strong) NSWindowController *QuickViewWindow;
@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSProgressIndicator *prg_loading;
@property (weak) IBOutlet NSTextField *lbl_cur;
@property (weak) IBOutlet NSButton *btn_home;
@property (weak) IBOutlet NSButton *btn_ref;
@property (weak) IBOutlet NSButton *btn_forward;
@property (weak) IBOutlet NSButton *btn_back;

- (void)doubleClick:(id)nid;
- (void) keyDown: (NSEvent *) event;
- (void) populateAtPath;

@end

