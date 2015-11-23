#import "WindowController.h"


@interface WindowController() {

}

-(void) notificationCenter;

@end

@implementation WindowController

@synthesize  contentView, url;

- (id) initWithURL:(NSString *) relativeURL{
    self = [super initWithWindowNibName:@"Window"];
    self.url = [NSURL URLWithString:relativeURL relativeToURL:[[NSBundle mainBundle] resourceURL]];
    
    [self.window setFrameAutosaveName:@"MacGapWindow"];
    [self notificationCenter];

    return self;
}

-(id) initWithRequest: (NSURLRequest *)request{
    self = [super initWithWindowNibName:@"Window"];
    [self notificationCenter];
    [[self.contentView.webView mainFrame] loadRequest:request];
    
    return self;
}

-(void) notificationCenter{
    [[NSNotificationCenter defaultCenter] addObserver:self.contentView 
                                             selector:@selector(windowResized:) 
                                                 name:NSWindowDidResizeNotification 
                                               object:[self window]];   
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    if (self.url != nil) {
        [self.contentView.webView setMainFrameURL:[self.url absoluteString]];
    }
    
    
    //set savepath
    NSString *savePath = [@"~/Downloads/" stringByExpandingTildeInPath];
    
    
    //run aria2
    NSArray *arguments = [NSArray arrayWithObjects: @"--enable-rpc=true", @"--check-integrity=true",@"--rpc-listen-all=true", @"--rpc-allow-origin-all", @"--max-connection-per-server=10",@"--max-concurrent-downloads=10",@"--min-split-size=10M",@"--split=10",@"--bt-enable-lpd=true",@"--bt-max-peers=55",@"--bt-require-crypto=true",@"-c",@"-D", @"-d",savePath, nil];
    NSString *resourcesPath = [[NSBundle mainBundle] resourcePath];
    NSString *exePath = [NSString stringWithFormat:@"%@/aria2c",resourcesPath];
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:exePath];
    [task setArguments:arguments];
    [task launch];

}

@end
