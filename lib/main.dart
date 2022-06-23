import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uza_sales/app/app.dart';
import 'package:uza_sales/app/orderBooker/provider/booker_order_provider.dart';
import 'package:uza_sales/app/orderBooker/provider/stock_availability_provider.dart';
import 'package:uza_sales/app/retailer/provider/ads_provider.dart';
import 'package:uza_sales/app/retailer/provider/auth_provider.dart';
import 'package:uza_sales/app/retailer/provider/cart_provider.dart';
import 'package:uza_sales/app/retailer/provider/category_provider.dart';
import 'package:uza_sales/app/retailer/provider/locale_provider.dart';
import 'package:uza_sales/app/retailer/provider/order_provider.dart';
import 'package:uza_sales/app/sales/provider/route_provider.dart';
import 'package:uza_sales/app/sales/provider/salesOrder_provider.dart';
import 'package:uza_sales/app/sales/provider/stock_availability_provider.dart';
import 'package:uza_sales/app/sales/provider/target_provider.dart';
import 'package:uza_sales/app/sales/provider/visibility_provider.dart';
import 'package:uza_sales/app/sales/provider/visit_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

int initScreen;

// Future<void> _messageHandler(RemoteMessage message) async {
//   print('background message ${message.notification.body}');
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // FirebaseMessaging messaging;

  // String firebaseToken = "";
  // messaging = FirebaseMessaging.instance;
  // messaging.getToken().then((value) {
  //   print(
  //       "============================   firebase messaging   =========================");
  //   print(value);
  //   firebaseToken = value;
  //   print("==================================================================");
  // });
  // FirebaseMessaging.onBackgroundMessage(_messageHandler);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // prefs.setString("firebaseToken", firebaseToken);
  initScreen = prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);

  print('initScreen $initScreen');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => StockAvailabilityProvider()),
    ChangeNotifierProvider(create: (_) => LocaleProvider()),
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => CategoryProvider()),
    ChangeNotifierProvider(create: (_) => CartProvider()),
    ChangeNotifierProvider(create: (_) => OrderProvider()),
    ChangeNotifierProvider(create: (_) => AdsProvider()),
    ChangeNotifierProvider(create: (_) => RouteProvider()),
    ChangeNotifierProvider(create: (_) => CategoryBookerProvider()),
    ChangeNotifierProvider(create: (_) => TargetProvider()),
    ChangeNotifierProvider(create: (_) => VisitProvider()),
    ChangeNotifierProvider(create: (_) => SalesOrderProvider()),
    ChangeNotifierProvider(create: (_) => BookerOrderProvider()),
    ChangeNotifierProvider(create: (_) => VisibilityProvider()),
  ], child: MyApp()));
}
