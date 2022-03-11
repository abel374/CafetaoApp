import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery_app/Back4app/back4app.dart';
import 'package:food_delivery_app/pages/Home/home_screen.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'pages/registration_screens/login_screen.dart';

void main() {
  Back4app.initialize();


  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.orange,
      systemNavigationBarColor: Colors.white,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<bool> hasUserLogged() async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser == null) {
      return false;
    }
    final ParseResponse? parseResponse =
        await ParseUser.getCurrentUserFromServer(currentUser.sessionToken!);

    if (parseResponse?.success == null || !parseResponse!.success) {
      await currentUser.logout();
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cafetão',
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        fontFamily: "Poppins",
      ),
      // home: const LoginScreen(),

      ///so quando ter dados vamos descomentar ele
      home: FutureBuilder<bool>(
          future: hasUserLogged(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Scaffold(
                  body: Center(
                    child: SizedBox(
                        width: 100,
                        height: 100,
                        child:   CircularProgressIndicator()),
                  ),
                );
              default:
                if (snapshot.hasData && snapshot.data!) {
                  return const HomeScreen();
                } else {
                  return const LoginScreen();//LoginScreen(); // so teste mesmo LoginScreen
                }
            }
          },),
    );
  }
}
 



