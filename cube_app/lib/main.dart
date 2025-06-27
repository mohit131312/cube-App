import 'package:cube_app/login/login_screen.dart';
import 'package:cube_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  //runApp(const MyApp());
  runApp(
    DevicePreview(
      enabled: true, // Set to false in release mode if needed
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(
        builder: (context, orientation) {
          //SizeConfig().init(constraints, orientation);
          //   SizeConfig().init(context);
          SizeConfig.initWithConstraints(constraints, orientation);

          return GetMaterialApp(
            locale: DevicePreview.locale(context), //  Add this
            builder: DevicePreview.appBuilder, //  And this
            debugShowCheckedModeBanner: false,
            home: LoginScreen(),
          );
        },
      );
    });
  }
}
