//
//  ProcessesViewController.m
//  ListProcesses
//
//  Created by Philippe Jayet on 15.03.12.
//  Copyright (c) 2012 Easybox Technologies Sarl. All rights reserved.
//

#import "ProcessesViewController.h"
#import "UIDevice+ProcessesAdditions.h"

@interface ProcessesViewController ()

@property (nonatomic, retain) NSArray *processes;

@end

@implementation ProcessesViewController

@synthesize processes;

- (id)initWithStyle:(UITableViewStyle)style {
	if (!(self = [super initWithStyle:style])) return self;
	
	self.processes = [[UIDevice currentDevice] runningProcesses];
	
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload {
	[super viewDidUnload];
	// Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.processes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"ProcessCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (!cell) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	NSDictionary *process = [self.processes objectAtIndex:indexPath.row];
	cell.textLabel.text = [process objectForKey:@"ProcessName"];
	cell.detailTextLabel.text = [NSString stringWithFormat:@"PID %@", [process objectForKey:@"ProcessID"]];
	
	return cell;
}

@end
