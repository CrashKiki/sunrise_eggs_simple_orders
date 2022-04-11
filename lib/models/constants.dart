import 'package:flutter/material.dart';

class K {
  static const privacyPolicyURL =
      'https://www.freeprivacypolicy.com/live/f6fde65e-e149-4ab2-8f66-c8a6e3aed3b9';

  static Future<dynamic> goTo(
          BuildContext context, Widget Function() returnWidget) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (builder) => returnWidget(),
        ),
      );

  static Future<dynamic> replaceScreen(
          BuildContext context, Widget Function() returnWidget) =>
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (builder) => returnWidget(),
        ),
      );
}
