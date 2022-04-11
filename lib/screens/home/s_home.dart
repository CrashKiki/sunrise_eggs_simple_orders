import 'package:flutter/material.dart';
import 'package:sunrise_eggs_simple_orders/models/order.dart';
import 'package:sunrise_eggs_simple_orders/screens/home/widgets/w_category_card.dart';
import 'package:sunrise_eggs_simple_orders/screens/order_template/s_order_template.dart';
import 'package:sunrise_eggs_simple_orders/screens/profile/s_profile_screen.dart';
import 'package:sunrise_eggs_simple_orders/widgets/w_custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellowAccent.shade100,
      child: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Scaffold(
            backgroundColor: Colors.orange.shade50,
            persistentFooterButtons: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomButton(
                    'Share',
                    iconData: Icons.share,
                    onPress: () {
                      Order.shareOrder();
                    },
                    hasBorder: true,
                    thickPadding: true,
                    wrapInRowWidget: false,
                  ),
                  const SizedBox(width: 8),
                  CustomButton(
                    'Email',
                    iconData: Icons.email_outlined,
                    onPress: () {Order.emailOrder();},
                    hasBorder: true,
                    thickPadding: true,
                    wrapInRowWidget: false,
                  ),
                ],
              ),
            ],
            body: SafeArea(
              child: ListView.builder(
                itemCount: Order.orderList.length + 2,
                itemBuilder: (_, index) {
                  if (index == 0) {
                    return Image.asset('assets/header.jpeg');
                  }
                  if (index == 1) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 100,
                          child: CustomButton(
                            'Template',
                            hasBorder: true,
                            onlyBorder: true,
                            onPress: () async {
                              Order.loadTemplate();
                              Order.templateChanged = false;
                              final bool? saved = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const OrderTemplateScreen()));
                              if (saved == true) {
                                setState(() {
                                  Order.loadOrder();
                                });
                              }
                            },
                          ),
                        ),
                        IconButton(
                            onPressed: () => launch(K.privacyPolicyURL),
                            icon: const Icon(
                              Icons.lock_outline,
                              color: Colors.orange,
                            )),
                        SizedBox(
                          width: 100,
                          child: CustomButton('Profile',
                              hasBorder: true, onlyBorder: true, onPress: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileScreen()));
                          }),
                        ),
                      ],
                    );
                  }
                  return CategoryCard(Order.orderList[index - 2]);
                },
                // padding: const EdgeInsets.all(8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
