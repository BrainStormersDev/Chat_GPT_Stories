import 'dart:convert';
import 'dart:io';
import 'package:chat_gpt_stories/utils/MyRepo.dart';
import 'package:chat_gpt_stories/view/Pages/story_category_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';



import 'view/Pages/splash_page.dart';
//lat


// Future<void> backgroundHandler(RemoteMessage message) async {
//   print(message.data.toString());
//   print(message.notification!.title);
// }


// RxInt count =0.obs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  // FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  messageHandler();
  await _localNotification();

  runApp(const MyApp());
}


Future<void> messageHandler() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  messaging.subscribeToTopic('all');
  messaging.getToken().then((token) {
    MyRepo.deviceToken.value = token!;
    print("===D_Token:${MyRepo.deviceToken.value}==");
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
    print("====event: ${event}=====");
    // NotiData notiData =NotiData.fromJson(jsonDecode(event));
    // print("====event:${notiData.title},=====");// main heading
    // print("====event:${notiData.body},=====");//sub heeading
    // print("====event:${notiData.date},=====");//boday



    // count.value++;

    if(Platform.isAndroid){
      await _showNotification(event);
      // await showNotificationBG(event);
    }

  });
}

Future<void> _showNotification(var data) async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  // flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //     onSelectNotification: onSelectNotification);

  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails('your channel id', 'your channel name',
      importance: Importance.max,
      priority: Priority.high,

      ticker: 'ticker');
  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: DarwinNotificationDetails(
      sound: 'default.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    ),
  );

  // _type = data['type'];

  print("===========body:${json.encode(data)}=========");

  // String payload = json.encode(data);
  //
  // await flutterLocalNotificationsPlugin.show(0, "data.notification!.title!", "data.notification!.body", platformChannelSpecifics, payload: payload);
  // await flutterLocalNotificationsPlugin.show(0, data.notification!.title, data.notification!.body, platformChannelSpecifics, payload: payload);
  //
  // print("===========body:${data.toString()}====${data['title'].toString()}=========");
}

_localNotification() {
  var initializationSettingsAndroid =
  const AndroidInitializationSettings('@mipmap/ic_launcher');
  //for IOS
  final DarwinInitializationSettings initializationSettingsIOS =
  DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  _flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: onSelectNotification);
  FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    print("========event.data:${event.notification}=========");

    // Get.to(DashBoard());
    // print("========event.data:${jsonDecode(event.data.toString())}=========");
    // print("========event.data:${event.data}=========");
    // showNotificationBG(event);
    // _showNotification(event);
  });
}


Future onSelectNotification(var payload) async {
  if (payload != null) {
    print("===payload:$payload===");
    // NotiData notiData =NotiData.fromJson(jsonDecode(payload));
    // _type.value =notiData.title;
    // print("====_type.value:${_type.value}=======");
    // print("====_type.value:${notiData.title}=======");
    // gotoRoute(notiData);

  }
}






class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Story Telling',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      scrollBehavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
      home: const GetMaterialApp(
          debugShowCheckedModeBanner: false,

          home:SplashPage()),
    );
  }
}


// import 'package:flutter/material.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   String str = "Hey I'm 1234 and % Rs10";
//   int findLen(String word) {
//     return word.replaceAll(new RegExp(r'[a-zA-Z]'), "").length;
//   }
//
//   var styleOne = const TextStyle(color: Colors.black87, fontSize: 21);
//
//   var styleTwo = const TextStyle(
//       color: Colors.black87, fontWeight: FontWeight.w800, fontSize: 24);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//
//       ),
//       body: RichText(
//         overflow: TextOverflow.ellipsis,
//         textAlign: TextAlign.center,
//         maxLines: 4,
//         text: TextSpan(
//           children: str
//               .split(" ")
//               .map((word) => TextSpan(
//               text: word + " ",
//               style: findLen(word) == word.length ||
//                   word.substring(0, 2).contains("Rs")
//                   ? styleTwo
//                   : styleOne))
//               .toList(),
//         ),
//       ),
//     );
//   }
// }