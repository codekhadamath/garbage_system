import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:garbage_system/apis/notification_api.dart';
import 'package:garbage_system/contstants/style.dart';
import 'package:garbage_system/firebase_options.dart';
import 'package:garbage_system/router/router.dart';
import 'package:garbage_system/services/notification_service.dart';
import 'package:garbage_system/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationService.instance.start();
  NotificationApi.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _initialize = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: AppColor.primarySwatch,
          inputDecorationTheme: InputDecorationTheme(
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
              ))),
      home: FutureBuilder(
          future: _initialize,
          builder: (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const Wrapper();
            }
            return const CircularProgressIndicator();
          }),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
