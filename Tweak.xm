#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SBUserAgent.h"

static NSString *getVideoID(NSString *string) {
    NSRange range = [string rangeOfString:@"?v="];
    if (range.location == NSNotFound) {
        range = [string rangeOfString:@"&v="];
    }
    if (range.location != NSNotFound && string.length >= range.location+range.length+11) {
        return [string substringWithRange:NSMakeRange(range.location+range.length, 11)];
    }
    return nil;
}

static BOOL isYouTubeURL(NSString *url) {
    return (url.length > 0 && ([url rangeOfString:@"youtube."].location != NSNotFound || [url hasPrefix:@"youtube:"]));
}

static BOOL canDirectlyOpen(NSString *url) {
    return ([url hasPrefix:@"protube://"]);
}

static BOOL proTubeAvailable() {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"protube://"]];
}

%group iOS5Hooks

%hook SpringBoard

- (void)_openURLCore:(id)arg1 display:(id)arg2 publicURLsOnly:(BOOL)arg3 animating:(BOOL)arg4 additionalActivationFlag:(unsigned int)arg5 {
    NSString *url = [arg1 absoluteString];
    if (canDirectlyOpen(url) && proTubeAvailable()) {
        [(SBUserAgent *)[%c(SBUserAgent) sharedUserAgent] openURL:arg1 animateIn:YES scale:0.0f start:0.0f duration:0.3f animateOut:YES];
    }
    else if (isYouTubeURL(url) && proTubeAvailable()) {
        NSString *videoID = getVideoID(url);
        NSMutableString *final = nil;
        if (videoID.length) {
            final = (NSMutableString *)[NSString stringWithFormat:@"protube://m.youtube.com/watch?v=%@", videoID];
        }
        else {
            final = [url mutableCopy];
            NSRange http = [final rangeOfString:@"http://"];
            if (http.location != NSNotFound) {
                [final deleteCharactersInRange:http];
            }
            else {
                if (![final hasPrefix:@"youtube://"] && ![final hasPrefix:@"youtube:/"] && [final hasPrefix:@"youtube:"]) { //made so that it correctly parses youtube:.... urls from iOS 5 and youtube://... urls
                    [final deleteCharactersInRange:[final rangeOfString:@"youtube:"]];
                    final = (NSMutableString *)[NSString stringWithFormat:@"protube://m.youtube.com/watch?v=%@", final];
                }
                else if ([final hasPrefix:@"youtube:/"]) {
                    [final deleteCharactersInRange:[final rangeOfString:@"youtube:/"]];
                    while ([final hasPrefix:@"/"]) {
                        [final deleteCharactersInRange:NSMakeRange(0, 1)];
                    }
                    [final insertString:@"protube://" atIndex:0];
                }
                else {
                    final = (NSMutableString *)@"protube://m.youtube.com";
                }
            }
        }
        [(SBUserAgent *)[%c(SBUserAgent) sharedUserAgent] openURL:[NSURL URLWithString:final] animateIn:YES scale:0.0f start:0.0f duration:0.3f animateOut:YES];
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
    NSString *url = [arg1 absoluteString];
    if (canDirectlyOpen(url) && proTubeAvailable()) {
        [(SBUserAgent *)[%c(SBUserAgent) sharedUserAgent] openURL:arg1 animateIn:YES scale:0.0f start:0.0f duration:0.3f animateOut:YES];
    }
    else if (isYouTubeURL(url) && proTubeAvailable()) {
        NSString *videoID = getVideoID(url);
        NSMutableString *final = nil;
        if (videoID.length) {
            final = (NSMutableString *)[NSString stringWithFormat:@"protube://m.youtube.com/watch?v=%@", videoID];
        }
        else {
            final = [url mutableCopy];
            NSRange http = [final rangeOfString:@"http://"];
            if (http.location != NSNotFound) {
                [final deleteCharactersInRange:http];
            }
            else {
                if (![final hasPrefix:@"youtube://"] && ![final hasPrefix:@"youtube:/"] && [final hasPrefix:@"youtube:"]) { //made so that it correctly parses youtube:.... urls from iOS 5 and youtube://... urls
                    [final deleteCharactersInRange:[final rangeOfString:@"youtube:"]];
                    final = (NSMutableString *)[NSString stringWithFormat:@"protube://m.youtube.com/watch?v=%@", final];
                }
                else if ([final hasPrefix:@"youtube:/"]) {
                    [final deleteCharactersInRange:[final rangeOfString:@"youtube:/"]];
                    while ([final hasPrefix:@"/"]) {
                        [final deleteCharactersInRange:NSMakeRange(0, 1)];
                    }
                    [final insertString:@"protube://" atIndex:0];
                }
                else {
                    final = (NSMutableString *)@"protube://m.youtube.com";
                }
            }
        }
        [(SBUserAgent *)[%c(SBUserAgent) sharedUserAgent] openURL:[NSURL URLWithString:final] animateIn:YES scale:0.0f start:0.0f duration:0.3f animateOut:YES];
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