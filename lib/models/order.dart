import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sunrise_eggs_simple_orders/models/prefs.dart';

class Order {
  static const splitter = '^';
  static Map<String, Map<String, int>> order = {};
  static List<String> orderList = [];
  static Map<String, Map<String, bool?>> template = {};
  static bool templateChanged = false;
  static String orderString = '';
  static const stock = {
    '30 Open Case': {
      'SM30OC': 'M',
      'SL30OC': 'L',
      'SXL30OC': 'XL',
      'SJ30C': 'J',
      'SSJ30C': 'SJ',
    },
    '30 Free Range Open Case': {
      'SL30FROC': 'L',
      'SXL30FROC': 'XL',
      'SJ30FROC': 'J',
    },
    'Cracks': {
      'SCASE-CRACKS': 'Case',
    },
    'Pulp': {
      'EGG-PULP2': '2L',
    },
  };

  static void loadOrder() {
    order = {};
    final strings = Prefs.visibleItems;
    for (var s in strings) {
      var list = s.split(splitter);
      final category = list.first;
      list.removeAt(0);
      Map<String, int> mapOrder = {};
      for (var sub in list) {
        mapOrder[sub] = 0;
      }
      order[category] = mapOrder;
    }
    orderList = order.keys.toList();
  }

  static void loadTemplate() {
    template = {};
    for (var key in stock.keys) {
      template[key] = {};
    }
    for (var key in order.keys) {
      for (var subKey in order[key]!.keys) {
        template[key]![subKey] = true;
      }
    }
  }

  static void saveTemplate() {
    List<String> visibleItems = [];
    for (var key in template.keys) {
      String formattedString = key;
      if (template[key]?.isNotEmpty ?? false) {
        for (var subKey in template[key]!.keys) {
          if (template[key]![subKey] != null) {
            formattedString += splitter + subKey;
          }
        }
      }
      if (formattedString.contains(splitter)) visibleItems.add(formattedString);
    }
    Prefs.visibleItems = visibleItems;
  }

  static void shareOrder() async {
    Share.shareFiles([await getOrderPath()],
        subject: '${Prefs.accountCode} - Order',
        text: '''
    Order for ${Prefs.accountCode}:
    ''');
  }

  static void emailOrder() async {
    final Email email = Email(
      attachmentPaths: [await getOrderPath()],
      body: orderString,
      subject: '${Prefs.accountCode} - Order',
      recipients: ['admin@suneggs.co.za'],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }

  static Future<String> getOrderPath() async {
    List<List> csvList = [
      ['Code', 'Qty']
    ];

    orderString = '';

    for (var category in order.keys) {
      for (var sub in order[category]!.keys) {
        if (order[category]![sub]! > 0) {
          csvList.add([
            sub,
            order[category]![sub]!,
          ]);
          orderString +=
              '\n${order[category]![sub]!} x ${stock[category]![sub]!} $category';
        }
      }
    }

    final directoryPath = (await getTemporaryDirectory()).path;
    final path = '$directoryPath/${Prefs.accountCode}.csv';
    final file = File(path);
    await file.writeAsString(const ListToCsvConverter().convert(csvList));
    return path;
  }
}
