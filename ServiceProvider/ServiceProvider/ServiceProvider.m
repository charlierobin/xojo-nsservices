//
//  ServiceProvider.m
//  ServiceProvider
//
//  Created by charlie on 16/06/2022.
//

//  https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/SysServices/introduction.html

#import "ServiceProvider.h"

typedef NSString * (*handler)(NSString *, NSString *, NSString *);

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
        
        NSString *crap = g_CallbackFunction(@"", @"",*error);
        
        return;
    }
    
    NSString *pboardString = [pboard stringForType:NSPasteboardTypeString];
    
    NSString *newString = g_CallbackFunction(pboardString, userData,@"");
    
    [pboard clearContents];
    [pboard writeObjects:[NSArray arrayWithObject:newString]];
}

- (void)handlerMethodName2:(NSPasteboard *)pboard userData:(NSString *)userData error:(NSString **)error
{
    // https://stackoverflow.com/questions/4362484/can-you-get-full-paths-from-the-pasteboard-when-drag-and-dropping
    
    // https://developer.apple.com/documentation/appkit/nsfilenamespboardtype/
    
    if ([[pboard types] containsObject:NSFilenamesPboardType])
    {
        NSData* data = [pboard dataForType:NSFilenamesPboardType];
        if (data)
        {
            NSString* errorDescription;
            NSArray* filenames = [NSPropertyListSerialization
                propertyListFromData:data
                mutabilityOption:kCFPropertyListImmutable
                format:nil
                errorDescription:&errorDescription];

            for (id filename in filenames)
            {
                //NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"file://localhost%@", filename]];

                //NSLog(@"Adding URL: %@", url);
                
                NSString *crap = g_CallbackFunction(filename, userData,@"");
            }
        }
    }
}

@end

void init( handler xojoAddressOf )
{
    g_CallbackFunction = xojoAddressOf;
    
    NSRegisterServicesProvider([ServiceProvider new], @"ServiceProviderTester");
}
