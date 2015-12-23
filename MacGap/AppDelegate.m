//
//  AppDelegate.m
//  MacGap
//
//  Created by Alex MacCaw on 08/01/2012.
//  Copyright (c) 2012 Twitter. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize windowController;


- (void) applicationWillFinishLaunching:(NSNotification *)aNotification
{
[self startAria2];
}

-(BOOL)applicationShouldHandleReopen:(NSApplication*)application
                   hasVisibleWindows:(BOOL)visibleWindows{
    if(!visibleWindows){
        [self.windowController.window makeKeyAndOrderFront: nil];
    }
    return YES;
}

- (void) applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.windowController = [[WindowController alloc] initWithURL: kStartPage];
    [self.windowController showWindow: [NSApplication sharedApplication].delegate];
    self.windowController.contentView.webView.alphaValue = 1.0;
    self.windowController.contentView.alphaValue = 1.0;
    [self.windowController showWindow:self];
}


-(void)applicationWillTerminate:(NSNotification *)notification
{
    [self closeAria2];
}


-(void)startAria2
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"startaria" ofType:@"sh"];
    NSTask *task = [[NSTask alloc] init];
    task.launchPath = @"/bin/sh";
    task.arguments = @[path];
    [task launch];
    //NSArray *arguments = [NSArray arrayWithObjects: @"--enable-rpc=true", @"--check-integrity=true",@"--rpc-listen-all=true", @"--rpc-allow-origin-all", @"--max-connection-per-server=10",@"--max-concurrent-downloads=10",@"--min-split-size=10M",@"--split=10",@"--bt-enable-lpd=true",@"--bt-max-peers=55",@"--bt-require-crypto=true",@"-c",@"-D", @"-d",savePath, nil];
}

-(void)closeAria2
{
    NSArray *arg =[NSArray arrayWithObjects:@"aria2c",nil];
    NSTask *task=[[NSTask alloc] init];
    task.launchPath = @"/usr/bin/killall";
    task.arguments = arg;
    [task launch];
}

@end
