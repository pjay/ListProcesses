//
//  UIDevice+ProcessesAdditions.m
//  ListProcesses
//
//  Created by Philippe Jayet on 15.03.12.
//  Copyright (c) 2012 Easybox Technologies Sarl. All rights reserved.
//

#import "UIDevice+ProcessesAdditions.h"
#import <sys/sysctl.h>

// Source code from http://forrst.com/posts/UIDevice_Category_For_Processes-h1H

@implementation UIDevice (ProcessesAdditions)

- (NSArray *)runningProcesses {
	int mib[4] = {CTL_KERN, KERN_PROC, KERN_PROC_ALL, 0};
	size_t miblen = 4;
	
	size_t size;
	int st = sysctl(mib, miblen, NULL, &size, NULL, 0);
	
	struct kinfo_proc *process = NULL;
	struct kinfo_proc *newprocess = NULL;
	
	do {
		size += size / 10;
		newprocess = realloc(process, size);
		
		if (!newprocess) {
			if (process) {
				free(process);
			}
			
			return nil;
		}
		
		process = newprocess;
		st = sysctl(mib, miblen, process, &size, NULL, 0);
	} while (st == -1 && errno == ENOMEM);
	
	if (st == 0) {
		if (size % sizeof(struct kinfo_proc) == 0) {
			int nprocess = size / sizeof(struct kinfo_proc);
			
			if (nprocess) {
				NSMutableArray * array = [[NSMutableArray alloc] init];
				
				for (int i = nprocess - 1; i >= 0; i--) {
					NSString *processID = [[NSString alloc] initWithFormat:@"%d", process[i].kp_proc.p_pid];
					NSString *processName = [[NSString alloc] initWithFormat:@"%s", process[i].kp_proc.p_comm];
					
					NSDictionary *dict = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:processID, processName, nil] 
																	   forKeys:[NSArray arrayWithObjects:@"ProcessID", @"ProcessName", nil]];
					[processID release];
					[processName release];
					[array addObject:dict];
					[dict release];
				}
				
				free(process);
				return [array autorelease];
			}
		}
	}
	
	return nil;
}

@end
