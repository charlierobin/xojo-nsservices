# Integrating NSServices menu items with a Xojo app

An Xcode project for a dylib that can then be incorporated into a Xojo app.

Allows the addition of menu items to the macOS services menu. (In this case, available when the user has a compatible text selection active.)

<img width="509" alt="Screenshot 2023-04-19 at 09 29 14" src="https://user-images.githubusercontent.com/10506323/233001118-c1e20d37-878b-43c9-961e-0ef12fdac4e7.png">

Selecting the menu item launches the Xojo app (if it’s not already running) and sends the appropriate text data to a shared handler in the App object:

`Shared Function callback(s as CFStringRef, NSUserData as CFStringRef, error as CFStringRef) As CFStringRef`

Note that (as with a lot – all? — of callbacks to Xojo) the callback handler has to be a shared method, **not** an instance one.

The third service menu item is inly available when there is a suitable file selected in the Finder:

<img width="446" alt="Screenshot 2023-04-19 at 09 34 26" src="https://user-images.githubusercontent.com/10506323/233002500-6d355c3b-9d07-4cd8-b5ec-5ccb1464d929.png">

In this case, the appropriate file details are passed to the Xojo handler.
