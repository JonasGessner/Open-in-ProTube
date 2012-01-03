#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SpringBoard.h"
%hook SpringBoard

- (void)_openURLCore:(id)arg1 display:(id)arg2 publicURLsOnly:(BOOL)arg3 animating:(BOOL)arg4 additionalActivationFlag:(unsigned int)arg5 {
    NSURL *url = arg1;
    if ([url.absoluteString rangeOfString:@"youtube.com"].location != NSNotFound) {
        NSString *URL = [url.absoluteString stringByReplacingOccurrencesOfString:@"http://" withString:@"protube://"];
        [(SpringBoard *)[objc_getClass("SpringBoard") sharedApplication] applicationOpenURL:[NSURL URLWithString:URL]];
    }
    else if ([url.absoluteString rangeOfString:@"youtube:"].location != NSNotFound) {
        NSString *URL = [@"protube://m.youtube.com/watch?v=" stringByAppendingString:[url.absoluteString stringByReplacingOccurrencesOfString:@"youtube:" withString:@""]];
        [(SpringBoard *)[objc_getClass("SpringBoard") sharedApplication] applicationOpenURL:[NSURL URLWithString:URL]];
    }
    else {
        %orig;
    }
}
%end