//  AdbHelper.h
//  ADBFileTransfer
//
//  Created by Saurabh Joshi on 7/21/14.
//  Copyright (c) 2014 CollegeCODE. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ADBHelper;

@interface ADBHelper : NSObject
- (NSString *) getAdbVersion;
- (NSString *) runTask:(NSArray*)args;
- (NSString *)getFileList: (NSString*)path;
@end


