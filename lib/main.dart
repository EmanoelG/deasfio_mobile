import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wey_commerce_app/src/pages/pages_routes/app_pages.dart';

import 'core/routes/routes_name.dart';
import 'src/init_bindings.dart';

// import 'package:flutter_notifications/firebase_options.dart';
final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  // await FirebaseApi().initNotifications();
    runApp(MyApp());
}
// emanoelgalvao42@gmail.com 232300pit
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

        return GetMaterialApp(
          title: 'Teste',
          debugShowCheckedModeBanner: false,
          initialBinding: InitBindings(),
          initialRoute: RoutesName.homeTab,
          getPages: AppPages.page,
    );
  }
}


