import 'package:cube_app/login/login_screen.dart';
import 'package:cube_app/remote_service.dart';
import 'package:cube_app/select_role/select_role_screen.dart';
import 'package:cube_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
//import 'package:device_preview/device_preview.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  bool isLoggedIn = RemoteServices.gs.read('login') ?? false;
  runApp(
    MyApp(
      isLoggedIn: isLoggedIn,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isLoggedIn});
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(
        builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);

          // SizeConfig.initWithConstraints(constraints, orientation);

          return GetMaterialApp(
            // locale: DevicePreview.locale(context),
            // builder: DevicePreview.appBuilder,
            debugShowCheckedModeBanner: false,
            home: isLoggedIn ? SelectRoleScreen() : LoginScreen(),
          );
        },
      );
    });
  }
}
