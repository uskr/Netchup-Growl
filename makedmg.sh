hdiutil create -fs HFS+ -volname "NotifyMyAndroid 1.0.0" -srcfolder \
"./build/Release" "./NotifyMyAndroid-1.0.0.dmg"
hdiutil internet-enable -yes "NotifyMyAndroid-1.0.0.dmg"
