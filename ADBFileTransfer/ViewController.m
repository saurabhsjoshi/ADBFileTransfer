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

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Insert code here to initialize your application
    
    ListDataDoc *dat1 = [[ListDataDoc alloc] initWithTitle:@"Folder1" size:10.1 thumbImage:[NSImage
                                                                                            imageNamed:@"folder.png"]];
    ListDataDoc *dat2 = [[ListDataDoc alloc] initWithTitle:@"File" size:10.1 thumbImage:[NSImage
                                                                                         imageNamed:@"file.png"]];
    
    ListDataDoc *dat3 = [[ListDataDoc alloc] initWithTitle:@"Folder2" size:10.1 thumbImage:[NSImage
                                                                                            imageNamed:@"folder.png"]];
    
    NSMutableArray *list_data = [NSMutableArray arrayWithObjects:dat1, dat2, dat3, nil];
    self.list_data = list_data;
    
    
                                
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
                                    
    // Update the view, if already loaded
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    // Get a new ViewCell
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    
    
    
    // Since this is a single-column table view, this would not be necessary.
    // But it's a good practice to do it in order by remember it when a table is multicolumn.
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



@end
