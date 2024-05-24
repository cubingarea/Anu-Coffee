import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/features/route/route_name.dart';
import 'package:restaurant_app/features/route/route_pages.dart';
import 'package:restaurant_app/features/services/notif_service.dart';
import 'package:restaurant_app/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.initializeNotif();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getDefaultTheme(),
      // home: SplashScreen(),
      getPages: RoutePages().routes,
      initialRoute: RouteName.splashScreen,
    );
  }
}
