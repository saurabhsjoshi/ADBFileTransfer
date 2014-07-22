//
//  ViewController.m
//  ADBFileTransfer
//
//  Created by Saurabh Joshi on 7/21/14.
//  Copyright (c) 2014 CollegeCODE. All rights reserved.
//

#import "ViewController.h"
#import "ListData.h"
#import "ListDataDoc.h"
#import "AdbHelper.h"

@implementation ViewController

// NO need of self.tableView everywhere :)
@synthesize tableView = _tableView;
@synthesize lbl_cur = lbl_path;
@synthesize prg_loading = progressBar;

NSString* cur_path = @"\'/sdcard/\'";
int offset = 0;

- (void) populateAtPath {
    [_tableView setEnabled:NO];
    [progressBar startAnimation:nil];
    [progressBar setHidden:NO];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^ {
        ADBHelper *helper = [[ADBHelper alloc]init];
        [helper getAdbVersion];
        
        NSString *all_files = [helper getFileList:cur_path];
        
        NSArray *files = [all_files componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        NSMutableArray *list_data = [[NSMutableArray alloc] init];
        
        //Add the back button if necessary
        if(offset != 0){
            ListDataDoc *goBack = [[ListDataDoc alloc] initWithTitle:@"..." type:0
                                                          thumbImage:[NSImage imageNamed:@"folder.png"]];
            [list_data addObject:goBack];
        }
        int i = 0;
        
        for(NSString* f in files){
            if([f isNotEqualTo:@""]){
                
                if([f isNotEqualTo:@"INTERNALEND"]){
                    ListDataDoc *dat;
                    if(i == 0){
                        dat = [[ListDataDoc alloc] initWithTitle:[f substringToIndex:[f length]-1] type:0
                                                      thumbImage:[NSImage imageNamed:@"folder.png"]];
                    }
                    else{
                        dat = [[ListDataDoc alloc] initWithTitle:f type:1 thumbImage:[NSImage
                                                                                      imageNamed:@"file.png"]];
                    }
                    [list_data addObject:dat];
                }
                else{
                    i = 1;
                }
            }
        }
        
        [lbl_path setStringValue:cur_path];
        self.list_data = list_data;
        dispatch_async(dispatch_get_main_queue(), ^ {
            [_tableView reloadData];
            [progressBar stopAnimation:nil];
            [progressBar setHidden:YES];
            [_tableView setEnabled:YES];
        });
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Insert code here to initialize your application
    
    [self.btn_home setImage:[NSImage imageNamed:@"home.png"]];
    
    self.hist = [[NSMutableArray alloc] init];
    [self populateAtPath];

}



- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
                                    
    // Update the view, if already loaded
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    // Get a new ViewCell
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    
    
    if( [tableColumn.identifier isEqualToString:@"col1"] )
    {
        ListDataDoc *listDoc = [self.list_data objectAtIndex:row];
        cellView.imageView.image = listDoc.thumbImage;
        cellView.textField.stringValue = listDoc.data.title;
        return cellView;
    }
    return cellView;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [self.list_data count];
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    return @"hello world";
}

- (void) changeCurPath:(NSString*)to_add{
    //Remove the colons
    cur_path = [cur_path stringByReplacingOccurrencesOfString:@"\'" withString:@""];
    //Add the path and the colons
    cur_path = [NSString stringWithFormat:@"%@%@%@%@", @"\'", cur_path, to_add, @"/\'"];
}

- (void)doubleClick:(id)object {
    
    NSInteger rowNumber = [_tableView clickedRow];
    
    //Check if in the limits of file list
    if( rowNumber >=0 && self.list_data.count > rowNumber )
    {
        ListDataDoc *selectedItem = [self.list_data objectAtIndex:rowNumber];
        if(selectedItem.data.type != 1){
            if(rowNumber == 0 && offset != 0){
                offset -= 1;
                cur_path = [self.hist lastObject];
                
                //If it is original remove everything from hist
                if(offset == 0)
                    [self.hist removeAllObjects];
                else
                    [self.hist removeLastObject];
                
                [self populateAtPath];
            }
            else{
                offset += 1;
                //Add current path to history
                [self.hist addObject:cur_path];
                //Change current path
                [self changeCurPath:selectedItem.data.title];
                //Populate
                [self populateAtPath];
            }
            
        }
        
    }
}
- (void)mouseDown:(NSEvent *)event {
    offset = 0;
    cur_path = @"\'/sdcard/\'";
    [self populateAtPath];
}
- (void)awakeFromNib {
    [_tableView setTarget:self];
    [_tableView setDoubleAction:@selector(doubleClick:)];
    [self.btn_home setAction:@selector(mouseDown:)];
}


@end
