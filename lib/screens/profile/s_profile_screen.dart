import 'package:flutter/material.dart';
import 'package:sunrise_eggs_simple_orders/models/constants.dart';
import 'package:sunrise_eggs_simple_orders/models/prefs.dart';
import 'package:sunrise_eggs_simple_orders/screens/home/s_home.dart';
import 'package:sunrise_eggs_simple_orders/widgets/w_adapted_alert_dialog.dart';
import 'package:sunrise_eggs_simple_orders/widgets/w_custom_text_field.dart';

import '../../widgets/w_custom_button.dart';

class ProfileScreen extends StatelessWidget {
  final openingScreen = Prefs.accountCode == '';
  final profile = Profile();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final oldProfile = Profile();
        if (profile.number == oldProfile.number &&
            profile.accountCode == oldProfile.accountCode) return true;
        final bool? leave = await showDialog(
          context: context,
          builder: (context) => AdaptiveLeaveDialog(),
        );
        if (leave == true) return true;
        return false;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          backgroundColor: Colors.orange.shade50,
          appBar: AppBar(
            title: const Text('Profile'),
            backgroundColor: Colors.yellowAccent.shade100,
            // elevation: 0,
          ),
          persistentFooterButtons: [
            CustomButton(
              'SAVE',
              onPress: () {
                if (_formKey.currentState?.validate() ?? false) {
                  Prefs.accountCode = profile.accountCode;
                  Prefs.number = profile.number;
                  if (openingScreen) {
                    K.replaceScreen(context, () => HomeScreen());
                  } else {
                    Navigator.pop(context, true);
                  }
                }
              },
              hasBorder: true,
              thickPadding: true,
            )
          ],
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    'Account Code',
                    (value) => profile.accountCode = value,
                    validateNotEmpty: true,
                    initialValue: profile.accountCode,
                    icon: const Icon(Icons.account_box_outlined),
                  ),
                  CustomTextField(
                    'Contact Number',
                    (value) => profile.number = value,
                    validateNotEmpty: true,
                    initialValue: profile.number,
                    icon: const Icon(Icons.phone),
                    textInputType: TextInputType.phone,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Profile {
  String accountCode = Prefs.accountCode;
  String number = Prefs.number;
}
