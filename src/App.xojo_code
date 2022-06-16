#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub Open()
		  const dylib = "@executable_path/../Frameworks/libServiceProvider.dylib"
		  
		  declare sub init lib dylib ( handler as Ptr )
		  
		  init( AddressOf App.callback )
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Shared Function callback(s as CFStringRef, NSUserData as CFStringRef) As CFStringRef
		  // MessageBox( NSUserData )
		  
		  select case NSUserData
		    
		  case "Method1"
		    
		    return "Hello from Xojo’s Method1"
		    
		    
		  case "Method2"
		    
		    return "This is from Method2"
		    
		  else
		    
		    MessageBox( "Unrecognised NSUserData: " + NSUserData )
		    
		  end select
		  
		  
		End Function
	#tag EndMethod


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
