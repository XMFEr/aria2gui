//
//  AppDelegate.m
//  MG
//
//  Created by Tim Debo on 5/19/14.
//
//

#import "AppDelegate.h"
#import "WindowController.h"

@implementation AppDelegate

- (void)applicationWillFinishLaunching:(NSNotification *)aNotification
{
    //create directory aira2
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *theDestination  = [[NSHomeDirectory() stringByAppendingPathComponent:@"downloads"] stringByAppendingPathComponent:@"aria2"];
    [fileManager createDirectoryAtPath: theDestination withIntermediateDirectories:YES attributes:nil error:nil];
    
    //设置默认路径
    NSString *savePath = [@"~/Downloads/aria2" stringByExpandingTildeInPath];
    
    
    //RUN ARIA2
    NSArray *arguments = [NSArray arrayWithObjects: @"--enable-rpc", @"--rpc-listen-all=true", @"--rpc-allow-origin-all", @"-c", @"-D", @"-d",savePath, nil];
    NSString *resourcesPath = [[NSBundle mainBundle] resourcePath];
    NSString *exePath = [NSString stringWithFormat:@"%@/aria2c",resourcesPath];
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:exePath];
    [task setArguments:arguments];
    [task launch];
}

-(BOOL)applicationShouldHandleReopen:(NSApplication*)application
                   hasVisibleWindows:(BOOL)visibleWindows{
    if(!visibleWindows){
        [self.windowController.window makeKeyAndOrderFront: nil];
    }
    return YES;
}

- (void) applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.windowController = [[WindowController alloc] initWithURL: kStartPage];
    [self.windowController setWindowParams];
    [self.windowController showWindow:self];
    [[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:self];
}

- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center
     shouldPresentNotification:(NSUserNotification *)notification
{
    return YES;
}
@end
