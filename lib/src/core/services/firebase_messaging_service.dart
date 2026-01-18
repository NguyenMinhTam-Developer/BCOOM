// import 'dart:io';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:pharmacom/src/features/notifications/domain/entities/notification_register_entity.dart';
// import 'package:pharmacom/src/features/notifications/domain/usecases/register_notification_usecase.dart';

// // Top-level function for background message handling
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // Ensure Firebase is initialized
//   await Firebase.initializeApp();

//   print('Handling a background message: ${message.messageId}');

//   // Handle background message data
//   if (message.data.isNotEmpty) {
//     print('Background message data: ${message.data}');
//   }
// }

// class FirebaseMessagingService extends GetxService {
//   final FirebaseMessaging _messaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

//   String? _fcmToken;
//   bool _isInitialized = false;

//   String? get fcmToken => _fcmToken;
//   bool get isInitialized => _isInitialized;

//   @override
//   void onInit() {
//     super.onInit();
//     _initializeFirebaseMessaging();
//   }

//   Future<void> _initializeFirebaseMessaging() async {
//     try {
//       print('Initializing Firebase Messaging Service');
//       // Set background message handler
//       FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//       print('Initializing local notifications');
//       // Initialize local notifications
//       await _initializeLocalNotifications();

//       print('Requesting permission');
//       // Request permission (iOS & Web)
//       await _requestPermission();

//       print('Getting FCM token');
//       // Get FCM token
//       await _getFCMToken();

//       print('Setting up message handlers');
//       // Set up message handlers
//       _setupMessageHandlers();

//       print('Firebase Messaging Service initialized successfully');

//       _isInitialized = true;
//     } catch (e) {
//       print('Error initializing Firebase Messaging Service: $e');
//       // Set initialized to true even on error to prevent infinite waiting
//       _isInitialized = true;
//     }
//   }

//   Future<void> _initializeLocalNotifications() async {
//     const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

//     const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
//       requestAlertPermission: false,
//       requestBadgePermission: false,
//       requestSoundPermission: false,
//     );

//     const InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );

//     await _localNotifications.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: _onNotificationTapped,
//     );
//   }

//   Future<void> _requestPermission() async {
//     if (Platform.isIOS || kIsWeb) {
//       NotificationSettings settings = await _messaging.requestPermission(
//         alert: true,
//         announcement: false,
//         badge: true,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false,
//         sound: true,
//       );

//       print('User granted permission: ${settings.authorizationStatus}');
//     }
//   }

//   Future<void> _getFCMToken() async {
//     print('Getting FCM token');
//     try {
//       if (Platform.isIOS) {
//         _fcmToken = await _messaging.getAPNSToken();
//       } else {
//         _fcmToken = await _messaging.getToken();
//       }

//       print('FCM Token: $_fcmToken');

//       // Listen for token refresh
//       _messaging.onTokenRefresh.listen((token) {
//         _fcmToken = token;
//         print('FCM Token refreshed: $token');
//         // You can call your API to update the token on your server
//       });
//     } catch (e) {
//       print('Error getting FCM token: $e');
//     }
//   }

//   void _setupMessageHandlers() {
//     // Handle foreground messages
//     FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

//     // Handle when app is opened from notification
//     FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

//     // Handle initial message when app is terminated
//     _messaging.getInitialMessage().then((message) {
//       if (message != null) {
//         _handleInitialMessage(message);
//       }
//     });
//   }

//   void _handleForegroundMessage(RemoteMessage message) {
//     print('Got a message whilst in the foreground!');
//     print('Message data: ${message.data}');

//     if (message.notification != null) {
//       print('Message also contained a notification: ${message.notification}');
//       _showLocalNotification(message);
//     }
//   }

//   void _handleMessageOpenedApp(RemoteMessage message) {
//     print('App opened from notification: ${message.data}');
//     // Handle navigation based on message data
//     _handleNotificationNavigation(message);
//   }

//   void _handleInitialMessage(RemoteMessage message) {
//     print('App opened from terminated state: ${message.data}');
//     // Handle navigation based on message data
//     _handleNotificationNavigation(message);
//   }

//   void _handleNotificationNavigation(RemoteMessage message) {
//     // You can implement navigation logic here based on message data
//     // For example, navigate to a specific screen
//     if (message.data.containsKey('screen')) {
//       final screen = message.data['screen'];
//       // Navigate based on screen parameter
//       print('Navigate to screen: $screen');
//     }
//   }

//   Future<void> _showLocalNotification(RemoteMessage message) async {
//     if (message.notification == null) return;

//     const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'pharmacom_channel',
//       'PharmaCom Notifications',
//       channelDescription: 'Channel for PharmaCom app notifications',
//       importance: Importance.max,
//       priority: Priority.high,
//       showWhen: true,
//     );

//     const DarwinNotificationDetails iOSPlatformChannelSpecifics = DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//     );

//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iOSPlatformChannelSpecifics,
//     );

//     await _localNotifications.show(
//       message.hashCode,
//       message.notification!.title,
//       message.notification!.body,
//       platformChannelSpecifics,
//       payload: message.data.toString(),
//     );
//   }

//   void _onNotificationTapped(NotificationResponse response) {
//     print('Notification tapped: ${response.payload}');
//     // Handle notification tap
//   }

//   // Method to register device with your server
//   Future<void> registerDeviceWithServer({
//     required String deviceIdentifier,
//     required String platform,
//     required RegisterNotificationUseCase registerNotificationUseCase,
//   }) async {
//     if (_fcmToken == null) {
//       print('FCM token not available');
//       return;
//     }

//     try {
//       final request = NotificationRegisterEntity(
//         imei: deviceIdentifier,
//         token: _fcmToken!,
//         platform: platform,
//       );

//       final result = await registerNotificationUseCase(request);
//       result.fold(
//         (failure) {
//           print('Failed to register device: ${failure.message}');
//         },
//         (_) {
//           print('Device registered successfully with server');
//         },
//       );
//     } catch (e) {
//       print('Error registering device: $e');
//     }
//   }

//   // Method to subscribe to topics
//   Future<void> subscribeToTopic(String topic) async {
//     try {
//       await _messaging.subscribeToTopic(topic);
//       print('Subscribed to topic: $topic');
//     } catch (e) {
//       print('Error subscribing to topic: $e');
//     }
//   }

//   // Method to unsubscribe from topics
//   Future<void> unsubscribeFromTopic(String topic) async {
//     try {
//       await _messaging.unsubscribeFromTopic(topic);
//       print('Unsubscribed from topic: $topic');
//     } catch (e) {
//       print('Error unsubscribing from topic: $e');
//     }
//   }

//   // Method to get device platform
//   String getDevicePlatform() {
//     if (Platform.isAndroid) {
//       return 'android';
//     } else if (Platform.isIOS) {
//       return 'ios';
//     } else if (kIsWeb) {
//       return 'web';
//     }
//     return 'unknown';
//   }

//   // Method to get device identifier
//   Future<String> getDeviceIdentifier() async {
//     try {
//       final deviceInfo = DeviceInfoPlugin();

//       if (Platform.isAndroid) {
//         final androidInfo = await deviceInfo.androidInfo;
//         return androidInfo.id; // Android device ID
//       } else if (Platform.isIOS) {
//         final iosInfo = await deviceInfo.iosInfo;
//         return iosInfo.identifierForVendor ?? 'ios_${DateTime.now().millisecondsSinceEpoch}';
//       } else if (kIsWeb) {
//         return 'web_${DateTime.now().millisecondsSinceEpoch}';
//       }

//       return 'device_${DateTime.now().millisecondsSinceEpoch}';
//     } catch (e) {
//       print('Error getting device identifier: $e');
//       return 'device_${DateTime.now().millisecondsSinceEpoch}';
//     }
//   }
// }
