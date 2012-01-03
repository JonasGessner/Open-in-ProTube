#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SBUserAgent.h"
%hook SpringBoard

- (void)_openURLCore:(id)arg1 display:(id)arg2 publicURLsOnly:(BOOL)arg3 animating:(BOOL)arg4 additionalActivationFlag:(unsigned int)arg5 {
    NSURL *url = arg1;
    if ([url.absoluteString rangeOfString:@"youtube.com"].location != NSNotFound) {
        NSString *URL = [url.absoluteString stringByReplacingOccurrencesOfString:@"http://" withString:@"protube://"];
        [(SBUserAgent *)[objc_getClass("SBUserAgent") sharedUserAgent] openURL:[NSURL URLWithString:URL] animateIn:YES scale:1 start:0 duration:0.3 animateOut:YES];

    }
    else if ([url.absoluteString rangeOfString:@"youtube:"].location != NSNotFound) {
        NSString *URL = [@"protube://m.youtube.com/watch?v=" stringByAppendingString:[url.absoluteString stringByReplacingOccurrencesOfString:@"youtube:" withString:@""]];
        [(SBUserAgent *)[objc_getClass("SBUserAgent") sharedUserAgent] openURL:[NSURL URLWithString:URL] animateIn:YES scale:1 start:0 duration:0.3 animateOut:YES];
    }
    else {
        %orig;
    }
}
%end