//
//  QuickViewController.m
//  ADBFileTransfer
//
//  Created by Saurabh Joshi on 7/22/14.
//  Copyright (c) 2014 CollegeCODE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuickViewController.h"
#import "ListData.h"

@implementation QuickViewController

/*- (id)init:{
    self = [self.storyboard instantiateControllerWithIdentifier:@"QuickViewControllerWindow"];
    return self;
}*/

- (id) initWithView:(NSString*)stuff{
    self = [super init];
    if(self){
        NSLog(@"%@", stuff);
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *selected_list = [defaults objectForKey:@"SELECTED_ITEMS"];
    for (NSData* d in selected_list){
        NSData *encodedObject = [NSKeyedUnarchiver unarchiveObjectWithData:d];
        ListData *dat = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
        
        //NSLog(((ListData*)[NSKeyedUnarchiver unarchiveObjectWithData:encodedObject]).title);
    }
    
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    // Update the view, if already loaded
}

- (void)awakeFromNib {}


@end