# Gamepad keyCode 0 and back-button issues with android webview and crosswalk

## USAGE

1. Build without crosswalk by commenting-out the following line in config.xml:
     `<plugin name="cordova-plugin-crosswalk-webview" version="1.2.0" />`
2. Load the app on a Nexus/FireTV/Shield/Android TV with a gamepad;
3. Hit various buttons (`A`, `B`, `back`), notice that the B button logs a
     [backbutton] event;
4. Build with crosswalk (un-comment the plugin reference);
5. Load the app as per #2;
6. Hit various buttons (`A`, `B`, `back`), notice that the B button does NOT log a
     `[backbutton]` event at all.

## DETAILS

This example cordova app illustrates that when crosswalk is used, the B
button on a gamepad will not fire the backbutton event. Without crosswalk,
the backbutton event will fire upon release of the B button (keyup can be
used to prevent the backbutton event from being fired).

That being said, keyup (and keydown) cannot discern the difference between
most buttons except for d-pad -- they are all reported as having keyCode 0.
This is the case both with and without crosswalk, so is not specific to
crosswalk.

By implementing gamepad code manually using gamepadconnected etc, this code
is then responsible for triggering events on button presses. Browsers will
not recognize these events as having been "user-initiated". Mobile browsers
commonly use this heuristic to prevent things like on-screen keyboards or
autoplay features from being triggered without user-initiated actions.