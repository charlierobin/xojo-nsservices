# Integrating Services menu items with a Xojo app

The Services menu usually lives just above the hide/show options in an app’s app menu, just to the right of the Apple menu:

<img width="550" alt="Screenshot 2023-04-19 at 09 38 28" src="https://user-images.githubusercontent.com/10506323/233003334-60a44bcf-b041-4bbf-8825-9dedfab93ac0.png">

It changes depending on what the user is doing, what they have selected etc.

It also appears at the bottom of the contextual menu that appears when the user right clicks (or control clicks) on text, a file in the Finder – anywhere the contextual menu can be accessed:

<img width="670" alt="Screenshot 2023-04-19 at 09 40 59" src="https://user-images.githubusercontent.com/10506323/233005390-869166b4-8f00-4a2f-963c-01993cb2f1a7.png">

So an app that supports the Services menu (via NSServices) can be quite a useful little gizmo, publishing functionality that can then be shared even across different applications.

(For instance, your app can be called from within another app, can transform text that has been highlighted/selected, and then return it to replace the original text. Trivial examples would be a service for transforming case, sorting multiple lines, etc.)

https://developer.apple.com/documentation/bundleresources/information_property_list/nsservices

This repository contains two items: the Xcode project for a dylib that can then be incorporated into the second item: a Xojo app that can then do something when invoked.

It demonstrates the addition of menu items to the macOS services menu. (In this case, available when the user has a compatible text selection active.)

<img width="509" alt="Screenshot 2023-04-19 at 09 29 14" src="https://user-images.githubusercontent.com/10506323/233001118-c1e20d37-878b-43c9-961e-0ef12fdac4e7.png">

Selecting the menu item launches the Xojo app (if it’s not already running) and sends the appropriate text data to a shared handler in the App object:

`Shared Function callback(s as CFStringRef, NSUserData as CFStringRef, error as CFStringRef) As CFStringRef`

Note that (as with a lot – all? – of callbacks to Xojo) the callback handler has to be a shared method, **not** an instance one.

The third service menu item is only available when there is a suitable file selected in the Finder:

<img width="446" alt="Screenshot 2023-04-19 at 09 34 26" src="https://user-images.githubusercontent.com/10506323/233002500-6d355c3b-9d07-4cd8-b5ec-5ccb1464d929.png">

In this case, the appropriate file details are passed to the Xojo handler.

The complete handler looks like this:

```
Shared Function callback(s as CFStringRef, NSUserData as CFStringRef, error as CFStringRef) As CFStringRef

    if error <> "" then
		    
        MessageBox( error )
		    
        return ""
		    
    end if
		  
    select case NSUserData
		    
    case "Method1"
		    
        return "Hello from Xojo’s Method1"
		    
    case "Method2"
		    
        return "This is from Xojo’s Method2"
		    
    case "Method3"
		    
        MessageBox( "file: " + s )
		    
    else
		    
        MessageBox( "Unrecognised NSUserData: " + NSUserData )
		    
    end select
		  
End Function
```

As well as the plumbing in the dylib, and the handling in the callback, you need to make sure that your app’s Info.plist file is updated so that macOS knows about the services your app wants to provide and what data they handle.

So you’ll need to update this file with the correct information:

https://github.com/charlierobin/xojo-nsservices/blob/main/src/NSServices-keys.plist
