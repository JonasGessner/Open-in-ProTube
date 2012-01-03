/* How to Hook with Logos
Hooks are written with syntax similar to that of an Objective-C @implementation.
You don't need to #include <substrate.h>, it will be done automatically, as will
the generation of a class list and an automatic constructor.

%hook ClassName

// Hooking a class method
+ (id)sharedInstance {
	return %orig;
}

// Hooking an instance method with an argument.
- (void)messageName:(int)argument {
	%log; // Write a message about this call, including its class, name and arguments, to the system log.

	%orig;; // Call through to the original function with its original arguments.
	%orig;(nil); // Call through to the original function with a custom argument.

	// If you use %orig;(), you MUST supply all arguments (except for self and _cmd, the automatically generated ones.)
}

// Hooking an instance method with no arguments.
- (id)noArguments {
	%log;
	id awesome = %orig;
	[awesome doSomethingElse];

	return awesome;
}

// Always make sure you clean up after yourself; Not doing so could have grave consequences!
%end
*/
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SBApplication.h"
%hook SpringBoard

/*- (void)applicationOpenURL:(id)arg1 {
    NSURL *url = arg1;
    if ([url.absoluteString rangeOfString:@"youtube.com"].location != NSNotFound) {
        [[objc_getClass("UIApplication") sharedApplication] openURL:[NSURL URLWithString:[@"protube://" stringByAppendingString:url.absoluteString]]];
    }
    else {
        %orig;
    }
    UIAlertView *al = [[objc_getClass("UIAlertView") alloc] initWithTitle:@"openurlcore:" message:url.absoluteString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [al show];
    [al release];
}

- (void)applicationOpenURL:(id)arg1 publicURLsOnly:(BOOL)arg2 {
    NSURL *url = arg1;
    if ([url.absoluteString rangeOfString:@"youtube.com"].location != NSNotFound) {
        [[objc_getClass("UIApplication") sharedApplication] openURL:[NSURL URLWithString:[@"protube://" stringByAppendingString:url.absoluteString]]];
    }
    else {
        %orig;
    }
    UIAlertView *al = [[objc_getClass("UIAlertView") alloc] initWithTitle:@"openurlcore:" message:url.absoluteString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [al show];
    [al release];
}
- (void)applicationOpenURL:(id)arg1 publicURLsOnly:(BOOL)arg2 animating:(BOOL)arg3 {
    NSURL *url = arg1;
    if ([url.absoluteString rangeOfString:@"youtube.com"].location != NSNotFound) {
        [[objc_getClass("UIApplication") sharedApplication] openURL:[NSURL URLWithString:[@"protube://" stringByAppendingString:url.absoluteString]]];
    }
    else {
    UIAlertView *al = [[objc_getClass("UIAlertView") alloc] initWithTitle:@"openurlcore:" message:@"else" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [al show];
    [al release];
        %orig;
    }
    UIAlertView *al = [[objc_getClass("UIAlertView") alloc] initWithTitle:@"openurlcore:" message:url.absoluteString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [al show];
    [al release];
}
- (void)applicationOpenURL:(id)arg1 publicURLsOnly:(BOOL)arg2 animating:(BOOL)arg3 sender:(id)arg4 {
    NSURL *url = arg1;
    if ([url.absoluteString rangeOfString:@"youtube.com"].location != NSNotFound) {
        [[objc_getClass("UIApplication") sharedApplication] openURL:[NSURL URLWithString:[@"protube://" stringByAppendingString:url.absoluteString]]];
    }
    else {
    UIAlertView *al = [[objc_getClass("UIAlertView") alloc] initWithTitle:@"openurlcore:" message:@"else" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [al show];
    [al release];
        %orig;
    }
    UIAlertView *al = [[objc_getClass("UIAlertView") alloc] initWithTitle:@"openurlcore:" message:url.absoluteString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [al show];
    [al release];
}
- (void)applicationOpenURL:(id)arg1 publicURLsOnly:(BOOL)arg2 animating:(BOOL)arg3 additionalActivationFlag:(unsigned int)arg4 {
    NSURL *url = arg1;
        UIAlertView *al = [[objc_getClass("UIAlertView") alloc] initWithTitle:@"openurlcore:" message:url.absoluteString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [al show];
    [al release];
   if ([url.absoluteString rangeOfString:@"youtube.com"].location != NSNotFound) {
        [[objc_getClass("UIApplication") sharedApplication] openURL:[NSURL URLWithString:[@"protube://" stringByAppendingString:url.absoluteString]]];
    }
    else {
    UIAlertView *alt = [[objc_getClass("UIAlertView") alloc] initWithTitle:@"openurlcore:" message:@"else" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alt show];
    [alt release];
        %orig;
    }
    UIAlertView *alt = [[objc_getClass("UIAlertView") alloc] initWithTitle:@"openurlcore:" message:url.absoluteString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alt show];
    [alt release];
}
- (void)applicationOpenURL:(id)arg1 publicURLsOnly:(BOOL)arg2 animating:(BOOL)arg3 sender:(id)arg4 additionalActivationFlag:(unsigned int)arg5 {
    NSURL *url = arg1;
        UIAlertView *al = [[objc_getClass("UIAlertView") alloc] initWithTitle:@"openurlcore:" message:url.absoluteString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [al show];
    [al release];
    if ([url.absoluteString rangeOfString:@"youtube.com"].location != NSNotFound) {
        [[objc_getClass("UIApplication") sharedApplication] openURL:[NSURL URLWithString:[@"protube://" stringByAppendingString:url.absoluteString]]];
    }
    else {
    UIAlertView *alt = [[objc_getClass("UIAlertView") alloc] initWithTitle:@"openurlcore:" message:@"else" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alt show];
    [alt release];
        %orig;
    }
    UIAlertView *alt = [[objc_getClass("UIAlertView") alloc] initWithTitle:@"openurlcore:" message:url.absoluteString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alt show];
    [alt release];
}*/
- (void)_openURLCore:(id)arg1 display:(id)arg2 publicURLsOnly:(BOOL)arg3 animating:(BOOL)arg4 additionalActivationFlag:(unsigned int)arg5 {
    NSURL *url = arg1;
        UIAlertView *al = [[objc_getClass("UIAlertView") alloc] initWithTitle:@"openurlcore:" message:url.absoluteString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [al show];
    [al release];
    if ([url.absoluteString rangeOfString:@"youtube.com"].location != NSNotFound) {
    NSString *URL = [url.absoluteString stringByReplacingOccurrencesOfString:@"http://" withString:@"protube://"];
            UIAlertView *alt = [[objc_getClass("UIAlertView") alloc] initWithTitle:@"youtube.com" message:URL delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alt show];
    [alt release];
    [c performSelector:@selector(openURL:) withObject:URL];
    }
    else if ([url.absoluteString rangeOfString:@"youtube:"].location != NSNotFound) {
    NSString *URL = [@"protube://m.youtube.com/watch?v=" stringByAppendingString:[url.absoluteString stringByReplacingOccurrencesOfString:@"youtube:" withString:@""]];
        UIAlertView *alt = [[objc_getClass("UIAlertView") alloc] initWithTitle:@"youtube:" message:URL delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alt show];
    [alt release];
    [c performSelector:@selector(openURL:) withObject:URL];
    }
    else {
    UIAlertView *alt = [[objc_getClass("UIAlertView") alloc] initWithTitle:@"openurlcore:" message:@"else" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alt show];
    [alt release];
        %orig;
    }
    UIAlertView *alt = [[objc_getClass("UIAlertView") alloc] initWithTitle:@"openurlcore:" message:url.absoluteString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alt show];
    [alt release];
}
%new(c)
- (void)openURL:(NSString *)URL {
    UIAlertView *alt = [[objc_getClass("UIAlertView") alloc] initWithTitle:@"recieved" message:URL delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alt show];
    [alt release];
	//[[objc_getClass("UIApplication") sharedApplication] openURL:[NSURL URLWithString:URL]];
}
%end