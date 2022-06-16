//
//  ServiceProvider.m
//  ServiceProvider
//
//  Created by charlie on 16/06/2022.
//

//  https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/SysServices/introduction.html

#import "ServiceProvider.h"

typedef NSString * (*handler)(NSString *, NSString *);

static handler g_CallbackFunction;

@implementation ServiceProvider

- (void)handlerMethodName:(NSPasteboard *)pboard userData:(NSString *)userData error:(NSString **)error
{
    // Test for strings on the pasteboard.
    NSArray *classes = [NSArray arrayWithObject:[NSString class]];
    NSDictionary *options = [NSDictionary dictionary];
    
    if (![pboard canReadObjectForClasses:classes options:options])
    {
        *error = NSLocalizedString(@"Error: couldn’t call Xojo handler.", @"pboard couldn’t give string.");
        return;
    }
    
    NSString *pboardString = [pboard stringForType:NSPasteboardTypeString];
    
    NSString *newString = g_CallbackFunction(pboardString, userData);
    
    [pboard clearContents];
    [pboard writeObjects:[NSArray arrayWithObject:newString]];
}

@end

void init( handler xojoAddressOf )
{
    g_CallbackFunction = xojoAddressOf;
    
    NSRegisterServicesProvider([ServiceProvider new], @"ServiceProviderTester");
}
