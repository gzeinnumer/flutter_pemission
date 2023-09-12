# flutter_pemission

```dart
permission_handler: ^10.0.0
#  fluttertoast: ^8.2.2
```

```dart
  Future<void> requestStoragePermission() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      showToast("Storage access granted");
    } else if (status.isDenied) {
      showToast("Storage access denied");
    } else if (status.isPermanentlyDenied) {
      showToast("Storage access permanently denied");
    } else {
      showToast("Storage access : ${status.isGranted}");
    }
  }

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      showToast("Location access granted");
    } else if (status.isDenied) {
      showToast("Location access denied");
    } else if (status.isPermanentlyDenied) {
      showToast("Location access permanently denied");
    } else {
      showToast("Location access : ${status.isGranted}");
    }
  }

  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      showToast("Camera access granted");
    } else if (status.isDenied) {
      showToast("Camera access denied");
    } else if (status.isPermanentlyDenied) {
      showToast("Camera access permanently denied");
    } else {
      showToast("Camera access : ${status.isGranted}");
    }
  }
```


```dart
ElevatedButton(
  onPressed: () async {
    var status = await Permission.camera.status;
    showToast("Camera access : ${status}");

    if (status.isGranted) {
      showToast("Camera access granted");
    } else if (!status.isGranted) {
      requestCameraPermission();
    }
  },
  child: const Text("Ask camera permission"),
),
ElevatedButton(
  onPressed: () async {
    var status = await Permission.storage.status;
    showToast("Storage access : ${status}");

    if (status.isGranted) {
      showToast("Storage access granted");
    } else if (!status.isGranted) {
      requestStoragePermission();
    }
  },
  child: const Text("Ask storage permission"),
),
ElevatedButton(
  onPressed: () async {
    var status = await Permission.location.status;
    showToast("Location access : ${status}");

    if (status.isGranted) {
      showToast("Location access granted");
    } else if (!status.isGranted) {
      requestLocationPermission();
    }
  },
  child: const Text("Ask Location permission"),
),
```



```dart
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)

    # Start of the permission_handler configuration
    target.build_configurations.each do |config|

      # You can enable the permissions needed here. For example to enable camera
      # permission, just remove the `#` character in front so it looks like this:
      #
      # ## dart: PermissionGroup.camera
      # 'PERMISSION_CAMERA=1'
      #
      #  Preprocessor definitions can be found in: https://github.com/Baseflow/flutter-permission-handler/blob/master/permission_handler_apple/ios/Classes/PermissionHandlerEnums.h
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
        '$(inherited)',

        ## dart: PermissionGroup.calendar
        'PERMISSION_EVENTS=1',

        ## dart: PermissionGroup.reminders
        # 'PERMISSION_REMINDERS=1',

        ## dart: PermissionGroup.contacts
        # 'PERMISSION_CONTACTS=1',

        ## dart: PermissionGroup.camera
        'PERMISSION_CAMERA=1',

        ## dart: PermissionGroup.microphone
        # 'PERMISSION_MICROPHONE=1',

        ## dart: PermissionGroup.speech
        # 'PERMISSION_SPEECH_RECOGNIZER=1',

        ## dart: PermissionGroup.photos
        # 'PERMISSION_PHOTOS=1',

        ## dart: [PermissionGroup.location, PermissionGroup.locationAlways, PermissionGroup.locationWhenInUse]
        'PERMISSION_LOCATION=1',

        ## dart: PermissionGroup.notification
        # 'PERMISSION_NOTIFICATIONS=1',

        ## dart: PermissionGroup.mediaLibrary
        # 'PERMISSION_MEDIA_LIBRARY=1',

        ## dart: PermissionGroup.sensors
        # 'PERMISSION_SENSORS=1',

        ## dart: PermissionGroup.bluetooth
        # 'PERMISSION_BLUETOOTH=1',

        ## dart: PermissionGroup.appTrackingTransparency
        # 'PERMISSION_APP_TRACKING_TRANSPARENCY=1',

        ## dart: PermissionGroup.criticalAlerts
        # 'PERMISSION_CRITICAL_ALERTS=1'
      ]

    end
    # End of the permission_handler configuration
  end
end
```

```dart
	<key>NSCameraUsageDescription</key>
	<string>We need access to your camera for this feature</string>
	<key>NSPhotoLibraryUsageDescription</key>
	<string>We need access to your photo library for this feature</string>
	<key>NSLocationAlwaysUsageDescription</key>
	<string>Location Needed</string>
	<key>NSLocationWhenInUseUsageDescription</key>
	<string>Location Needed</string>
	<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
	<string>Location Needed</string>
```

```dart
    <uses-feature
        android:name="android.hardware.camera"
        android:required="false"
        tools:targetApi="eclair" />

    <uses-permission android:name="android.permission.CAMERA"/>
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
```
