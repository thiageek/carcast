# CarCast

## Setup steps

* Install XCode
* Install Ionic and its dependencies (npm, brew, grunt...)
* Install Ford AppLink SDK
* Install Ford AppLink Emulator (ALE)
	* Configure the project to run on 127.0.0.1 with the port 12345. No need to update "IDs used in the settings bundle" section
	* Seems like PREFS_PROTOCOL has to be tcps for offline testing and iap for iOS cable test on SYNC TDK 3.0


## Debug

* http://ionicframework.com/blog/live-reload-all-things-ionic-cli/


## Documentation

* http://cordova.apache.org/docs/en/edge/guide_platforms_ios_plugin.md.html#iOS%20Plugins

## Inbox

	Plugins with long-running requests, background activity such as media playback, listeners, or that maintain internal state should implement the onReset method to clean up those activities. The method runs when the UIWebView navigates to a new page or refreshes, which reloads the JavaScript.