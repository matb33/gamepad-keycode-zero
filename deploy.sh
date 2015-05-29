#!/bin/bash

cd app

( set -e; echo -n "Building..."
	../cordova build android
); if [[ $? > 0 ]]; then echo -e "\033[0;31m FAIL\033[0m"; exit 1; else echo -e "\033[0;32m OK\033[0m"; fi

( set -e; echo -n "Copying..."
	cp -f platforms/android/build/outputs/apk/android-debug.apk ../gamepad-keycode-zero.apk
); if [[ $? > 0 ]]; then echo -e "\033[0;31m FAIL\033[0m"; exit 1; else echo -e "\033[0;32m OK\033[0m"; fi

( set -e; echo -n "Connecting..."
	adb connect 192.168.100.15:5555
); if [[ $? > 0 ]]; then echo -e "\033[0;31m FAIL\033[0m"; exit 1; else echo -e "\033[0;32m OK\033[0m"; fi

( set -e; echo -n "Installing..."
	adb -s 192.168.100.15:5555 install -r ../gamepad-keycode-zero.apk
); if [[ $? > 0 ]]; then echo -e "\033[0;31m FAIL\033[0m"; exit 1; else echo -e "\033[0;32m OK\033[0m"; fi
