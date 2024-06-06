import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mobile_version_bloc/pages/myApp.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() {
  //Remove this method to stop OneSignal Debugging
  WidgetsFlutterBinding.ensureInitialized();

  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize("6d459651-5737-4aaa-bc2f-11eddcdc48e7");

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);
  runApp(MyApp());
}
