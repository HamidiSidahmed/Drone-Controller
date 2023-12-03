import 'package:drone_control/Settings.dart';
import 'package:flutter/material.dart';
import 'package:drone_control/Home.dart';
import 'package:drone_control/Controller.dart';
import 'package:flutter/services.dart';
import 'package:drone_control/MPU_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
WidgetsFlutterBinding.ensureInitialized();
SystemChrome.setPreferredOrientations([
  DeviceOrientation.landscapeLeft,
  DeviceOrientation.landscapeRight
]);
SystemChrome.setEnabledSystemUIMode(
  SystemUiMode.immersiveSticky
  
);
  runApp(
     ScreenUtilInit(
    designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
       builder: (context , child) {
    return MaterialApp(debugShowCheckedModeBanner: false,
initialRoute: "/home",
      routes: {
      "/home":(context) => Home(),
      "/MPU" :(context) => data(),
      "/controller":(context) => Joystick(),
      "/settings":(context) => setting(),

      },
  );
       }
  ));
}
