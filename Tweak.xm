#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SBUserAgent.h"

%group iOS5Hooks

%hook SpringBoard

- (void)_openURLCore:(id)arg1 display:(id)arg2 publicURLsOnly:(BOOL)arg3 animating:(BOOL)arg4 additionalActivationFlag:(unsigned int)arg5 {
    NSURL *url = arg1;
    if ([url.absoluteString rangeOfString:@"youtube.com"].location != NSNotFound) {
        NSString *URL = [url.absoluteString stringByReplacingOccurrencesOfString:@"http://" withString:@"protube://"];
        [(SBUserAgent *)[%c(SBUserAgent) sharedUserAgent] openURL:[NSURL URLWithString:URL] animateIn:YES scale:0.0f start:0.0f duration:0.3f animateOut:YES];

    }
    else if ([url.absoluteString rangeOfString:@"youtube:"].location != NSNotFound) {
        NSString *URL = [@"protube://m.youtube.com/watch?v=" stringByAppendingString:[url.absoluteString stringByReplacingOccurrencesOfString:@"youtube:" withString:@""]];
        [(SBUserAgent *)[%c(SBUserAgent) sharedUserAgent] openURL:[NSURL URLWithString:URL] animateIn:YES scale:0.0f start:0.0f duration:0.3f animateOut:YES];
    }
    else {
        %orig;
    }
}

%end

%end



%group iOS6Hooks

%hook SpringBoard

- (void)_openURLCore:(id)arg1 display:(id)arg2 animating:(BOOL)arg3 sender:(id)arg4 additionalActivationFlags:(id)arg5 {
    NSURL *url = arg1;
    if ([url.absoluteString rangeOfString:@"youtube.com"].location != NSNotFound) {
        NSString *URL = [url.absoluteString stringByReplacingOccurrencesOfString:@"http://" withString:@"protube://"];
        [(SBUserAgent *)[%c(SBUserAgent) sharedUserAgent] openURL:[NSURL URLWithString:URL] animateIn:YES scale:0.0f start:0.0f duration:0.3f animateOut:YES];
        
    }
    else if ([url.absoluteString rangeOfString:@"youtube:"].location != NSNotFound) {
        NSString *URL = [@"protube://m.youtube.com/watch?v=" stringByAppendingString:[url.absoluteString stringByReplacingOccurrencesOfString:@"youtube:" withString:@""]];
        [(SBUserAgent *)[%c(SBUserAgent) sharedUserAgent] openURL:[NSURL URLWithString:URL] animateIn:YES scale:0.0f start:0.0f duration:0.3f animateOut:YES];
    }
    else {
        %orig;
    }
}

%end

%end



%group main

%hook SpringBoard

- (id)init {
    self = %orig;
    if (self) {
        if ([UIDevice currentDevice].systemVersion.floatValue >= 6.0f) {
            %init(iOS6Hooks);
        }
        else {
            %init(iOS5Hooks);
        }
    }
    return self;
}

%end



%end

%ctor {
    @autoreleasepool {
        %init(main);
    }
}