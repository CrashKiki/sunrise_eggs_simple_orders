import 'package:flutter/material.dart';
import 'package:sunrise_eggs_simple_orders/widgets/w_chip_checkbox.dart';

import '../../models/order.dart';
import '../../widgets/w_adapted_alert_dialog.dart';
import '../../widgets/w_custom_button.dart';

class OrderTemplateScreen extends StatelessWidget {
  const OrderTemplateScreen();

  @override
  Widget build(BuildContext context) {
    List<String> categories = Order.stock.keys.toList();

    return WillPopScope(
      onWillPop: () async {
        if (!Order.templateChanged) return true;
        final bool? leave = await showDialog(
          context: context,
          builder: (context) => AdaptiveLeaveDialog(),
        );
        if (leave == true) return true;
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.orange.shade50,
        appBar: AppBar(
          title: const Text('Order Template'),
          backgroundColor: Colors.yellowAccent.shade100,
          // elevation: 0,
        ),
        persistentFooterButtons: [
          CustomButton(
            'SAVE',
            onPress: () {
              Order.saveTemplate();
              Navigator.pop(context, true);
            },
            hasBorder: true,
            thickPadding: true,
          )
        ],
        body: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) =>
              OrderTemplateExpansionTile(categories[index]),
        ),
      ),
    );
  }
}

class OrderTemplateExpansionTile extends StatelessWidget {
  const OrderTemplateExpansionTile(this.category);

  final String category;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        category,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      textColor: Colors.orange.shade900,
      childrenPadding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: Wrap(
            runSpacing: 5,
            spacing: 10,
            children: Order.stock[category]!.keys
                .map((e) => OrderTemplateSubcategoryChip(category, e))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class OrderTemplateSubcategoryChip extends StatelessWidget {
  const OrderTemplateSubcategoryChip(this.category, this.subcategory);

  final String category;
  final String subcategory;

  bool? get value => Order.template[category]?[subcategory];
  set value(bool? value) => Order.template[category]?[subcategory] = value;

  @override
  Widget build(BuildContext context) {
    return ChipCheckbox(
        title: Order.stock[category]![subcategory]!,
        onTap: () {
          if (value == true) {
            value = null;
          } else {
            value = true;
          }
          Order.templateChanged = true;
        },
        isSelected: () => Order.template[category]?[subcategory] == true);
  }
}
