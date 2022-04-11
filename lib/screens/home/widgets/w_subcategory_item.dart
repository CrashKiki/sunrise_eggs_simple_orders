import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sunrise_eggs_simple_orders/models/order.dart';

class SubcategoryItem extends StatefulWidget {
  const SubcategoryItem(this.category, this.subcategory);
  final String category;
  final String subcategory;

  @override
  State<SubcategoryItem> createState() => _SubcategoryItemState();
}

class _SubcategoryItemState extends State<SubcategoryItem> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int get value => Order.order[widget.category]![widget.subcategory]!;
  String get name => Order.stock[widget.category]![widget.subcategory]!;
  set value(int v) => Order.order[widget.category]![widget.subcategory] = v;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 50,
          child: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.orange.shade700,
            ),
          ),
        ),
        IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: () {
              if (value != 0) {
                _controller.text = (value - 1).toString();
                value--;
              }
            },
            icon: const Icon(Icons.remove),
            color: Colors.deepOrange),
        Container(
          width: 60,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.orange.shade100,
            borderRadius: const BorderRadius.all(
              Radius.circular(50),
            ),
            border: Border.all(color: Colors.deepOrange),
          ),
          child: TextField(
            controller: _controller,
            style: const TextStyle(fontWeight: FontWeight.bold),
            onChanged: (text) => value = int.tryParse(text) ?? 0,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 4,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            textAlign: TextAlign.right,
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
              counterText: '',
            ),
          ),
        ),
        IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: () {
              _controller.text = (value + 1).toString();
              value++;
            },
            icon: const Icon(Icons.add),
            color: Colors.deepOrange),
      ],
    );
  }
}
