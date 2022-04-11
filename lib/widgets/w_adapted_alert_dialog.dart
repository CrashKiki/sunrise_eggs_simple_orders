import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveLeaveDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme.of(context).platform == TargetPlatform.iOS
        ? CupertinoAlertDialog(
            title: const Text('Do you want to leave without saving?'),
            actions: [
              CupertinoDialogAction(
                child: const Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              ),
              CupertinoDialogAction(
                child: const Text('Leave'),
                onPressed: () => Navigator.pop(context, true),
              )
            ],
          )
        : AlertDialog(
            title: const Text('Do you want to leave without saving?'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Leave')),
            ],
          );
  }
}
