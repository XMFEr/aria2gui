#import <Cocoa/Cocoa.h>
#import "ContentView.h"

@interface WindowController : NSWindowController {
    
}

- (id) initWithURL:(NSString *) url; //WindowController方法1
- (id) initWithRequest: (NSURLRequest *)request; //WindowController方法2

@property (retain) NSURL * url;
@property (retain) IBOutlet ContentView *contentView;

@end
