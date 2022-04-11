import 'package:flutter/material.dart';
import 'package:sunrise_eggs_simple_orders/screens/home/widgets/w_subcategory_item.dart';

import '../../../models/order.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(this.category);

  final String category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        child: Card(
          color: Colors.white,
          elevation: 5,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.orange.shade700,
                      fontWeight: FontWeight.bold),
                ),
                const Divider(),
                ...Order.order[category]!.keys
                    .map((e) => SubcategoryItem(category, e))
                    .toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
