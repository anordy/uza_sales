import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/retailer/onboarding/onboarding_screen.dart';
import 'package:uza_sales/app/retailer/pages/auth/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:uza_sales/app/retailer/provider/locale_provider.dart';
import 'package:uza_sales/l10n/l10n.dart';

import '../main.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    //   print("message recieved");
    //   print(event.notification.body);
    //   Fluttertoast.showToast(msg: event.notification.body);
    // });
    // FirebaseMessaging.onMessageOpenedApp.listen((message) {
    //   print('Message clicked!');
    // });
  }

  @override
  Widget build(BuildContext context) {
    final _localeProvider = Provider.of<LocaleProvider>(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return OKToast(
      child: MaterialApp(
        locale: _localeProvider.locale,
        supportedLocales: L10n.all,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        title: 'Uza App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.light,
          primaryColor: const Color(0xFFED1E65),
          // primaryColor: const Color(0xFF75CFB8),
          primaryColorLight: const Color(0xfffcfcfc),
          // Define the default font family.
          fontFamily: 'Poppin',

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: const TextTheme(
              // headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              // headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
              // bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),

              ),
        ),
        // home: SplashScreen(),
        initialRoute: initScreen == 0 || initScreen == null ? "first" : "/",
        routes: {
          "/": (context) => SplashScreen(),
          "first": (context) => Scaffold(body: OnBoardingScreen())
        },
      ),
    );
  }
}
