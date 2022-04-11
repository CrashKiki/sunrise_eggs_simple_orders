import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  /// Row => Expanded => TextButton (rounded)
  const CustomButton(this.title,
      {required this.onPress,
      this.thickPadding = false,
      this.iconData,
      this.flex = 1,
      this.hasBorder = false,
      this.onlyBorder = false,
      this.wrapInRowWidget = true})
      : assert(
            onlyBorder == false || (onlyBorder == true && hasBorder == true));

  final Function() onPress;
  final String title;
  final IconData? iconData;
  final bool hasBorder;
  final bool wrapInRowWidget;
  final bool thickPadding;
  final bool onlyBorder;
  final int flex;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.all(thickPadding ? 16 : 10)),
      foregroundColor: onlyBorder
          ? MaterialStateProperty.all<Color>(Colors.orange.shade500)
          : MaterialStateProperty.all<Color>(Colors.deepOrange.shade50),
      backgroundColor: onlyBorder
          ? null
          : MaterialStateProperty.all<Color>(Colors.deepOrange),
      shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: hasBorder
              ? BorderSide(color: Colors.orange.shade500)
              : BorderSide.none)),
    );

    Widget getChild() {
      if (iconData != null) {
        return Expanded(
          flex: flex,
          child: TextButton.icon(
            onPressed: onPress,
            style: buttonStyle,
            icon: Icon(iconData),
            label: Text(title),
          ),
        );
      }
      return Expanded(
        flex: flex,
        child: TextButton(
          onPressed: onPress,
          style: buttonStyle,
          child: Text(title),
        ),
      );
    }

    if (wrapInRowWidget) {
      return Row(
        children: [getChild()],
      );
    }
    return getChild();
  }
}
