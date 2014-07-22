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

// NO need of self everywhere :)
@synthesize tableView = _tableView;
@synthesize lbl_cur = lbl_path;
@synthesize prg_loading = progressBar;
@synthesize btn_back = btn_back;
@synthesize btn_forward = btn_forward;
@synthesize btn_ref = btn_ref;

NSString* cur_path = @"\'/sdcard/\'";
int offset = 0;

- (void) populateAtPath {
    [_tableView setEnabled:NO];
    [progressBar startAnimation:nil];
    [progressBar setHidden:NO];
    
    if(offset == 0)
        [btn_back setEnabled:NO];
    
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
    
    [self.btn_home setTarget:self];
    [btn_ref setTarget:self];
    [btn_back setTarget:self];
    [btn_forward setTarget:self];
    
    [self.btn_home setAction:@selector(goHome:)];
    [btn_back setAction:@selector(goBack:)];
    [btn_forward setAction:@selector(goForward:)];
    
    
    self.hist = [[NSMutableArray alloc] init];
    //Add home to stack
    [self.hist addObject:cur_path];
    
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
    //TODO: Improve this jugaad (http://en.wikipedia.org/wiki/Jugaad) code!
    
    NSInteger rowNumber = [_tableView clickedRow];
    
    //Check if in the limits of file list
    if( rowNumber >=0 && self.list_data.count > rowNumber )
    {
        ListDataDoc *selectedItem = [self.list_data objectAtIndex:rowNumber];
        
        //Check if not File
        if(selectedItem.data.type != 1){
            
            //If first row then go back
            if(rowNumber == 0 && offset != 0)
                [self goBack:nil];
            
            //We are moving forward
            else{
                //If not back to home then enable back
                if(offset == 0)
                    [btn_back setEnabled:YES];
                
                //Go one index ahead
                offset += 1;
                
                //Change current path to selected
                [self changeCurPath:selectedItem.data.title];
                
                //Check if we are moving to new territory
                if((offset+1) > [self.hist count]){
                    //Add current path to history at the current offset
                    [self.hist addObject:cur_path];
                    [btn_forward setEnabled:NO];
                }
                // Moving around inside stack
                else{
                    //Check if we are moving from home
                    if((offset-1) == 0 && self.hist.count != 1){
                        //Check if user has switched from stack
                        if([self.hist objectAtIndex:1] != cur_path){
                            [self.hist removeAllObjects];
                            //Add the home back in there
                            [self.hist addObject:@"\'/sdcard/\'"];
                            //Now add the current path in to create new stack
                            [self.hist addObject:cur_path];
                            //Disable forward as new stack duh!
                            [btn_forward setEnabled:NO];
                        }
                        else{
                            if((offset+1) == self.hist.count)
                                [btn_forward setEnabled:NO];
                        }
                    }
                    //Rolling in the deep folders
                    else{
                        //We have reached limit can't go forward
                        if((offset+1) == self.hist.count)
                            [btn_forward setEnabled:NO];
                        
                        //Now check if we are still in same stack
                        if([self.hist objectAtIndex:offset] != cur_path){
                            //ooo we are somewhere new! Remove other crap
                            NSRange r;
                            r.location = offset;
                            r.length = [self.hist count] - offset;
                            [self.hist removeObjectsInRange:r];
                            //Replace to new location
                            [self.hist addObject:cur_path];}
                    }
                }
                
                //Populate
                [self populateAtPath];
            }
            
        }
        
    }
}


- (void)goHome:(NSEvent *)event {
    offset = 0;
    cur_path = @"\'/sdcard/\'";
    [self.hist removeAllObjects];
    [self.hist addObject:cur_path];
    [self populateAtPath];
}

- (void)goForward:(NSEvent *)event {
    if(offset == 0)
        [btn_back setEnabled:YES];
    offset += 1;
    if((offset+1) == self.hist.count)
        [btn_forward setEnabled:NO];
    cur_path = [self.hist objectAtIndex:offset];
    [self populateAtPath];
}


- (void)goBack:(NSEvent *)event {
    offset -= 1;
    [btn_forward setEnabled:YES];
    cur_path = [self.hist objectAtIndex:offset];
    [self populateAtPath];
}

- (void)awakeFromNib {
    [_tableView setTarget:self];
    [_tableView setDoubleAction:@selector(doubleClick:)];
}


@end
