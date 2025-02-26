import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'components/app_routes.dart';
import 'components/app_theme.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug, //TODO change for Release
  );
  await Hive.initFlutter();
  await Hive.openBox('settings');
  await Hive.openBox('servers');
  await Hive.box('servers').delete('servers_list');

  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box('settings').listenable(),
      builder: (context, settings, widget) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: AppTheme.getThemeMode(
          settings.get(
            'hiveThemeMode',
            defaultValue: 'light',
          ),
        ),
        routes: AppRoutes.getRoutes(context),
        initialRoute: AppRoutes.initialRoute,
      ),
    );
  }
}
