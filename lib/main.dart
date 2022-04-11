import 'package:flutter/material.dart';
import 'package:sunrise_eggs_simple_orders/models/order.dart';
import 'package:sunrise_eggs_simple_orders/models/prefs.dart';
import 'package:sunrise_eggs_simple_orders/screens/home/s_home.dart';
import 'package:sunrise_eggs_simple_orders/screens/profile/s_profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.initialise();
  Order.loadOrder();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Prefs.accountCode == '' ? ProfileScreen() : HomeScreen(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange),
      ),
    );
  }
}
