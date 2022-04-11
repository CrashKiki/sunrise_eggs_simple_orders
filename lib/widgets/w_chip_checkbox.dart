import 'package:flutter/material.dart';

class ChipCheckbox extends StatefulWidget {
  const ChipCheckbox(
      {required this.title,
      required this.onTap,
      required this.isSelected,
      this.trailing,
      this.useBorder = false,
      this.useLeadingCheck = true});

  final String title;
  final void Function() onTap;
  final bool Function() isSelected;
  final Widget? trailing;
  final bool useBorder;
  final bool useLeadingCheck;

  @override
  _ChipCheckboxState createState() => _ChipCheckboxState();
}

class _ChipCheckboxState extends State<ChipCheckbox> {
  @override
  Widget build(BuildContext context) {
    Widget text() => Text(
          widget.title,
          style: TextStyle(
            fontWeight:
                widget.isSelected() ? FontWeight.w900 : FontWeight.normal,
            color: widget.isSelected() ? Colors.black : Colors.grey.shade700,
          ),
        );

    return GestureDetector(
      onTap: () => setState(() {
        widget.onTap();
      }),
      child: Chip(
          elevation: 5,
          avatar: !widget.useLeadingCheck
              ? null
              : CircleAvatar(
                  child: const Icon(
                    Icons.check,
                    size: 15,
                    color: Colors.white,
                  ),
                  backgroundColor:
                      widget.isSelected() ? Colors.orange : Colors.white,
                  radius: 10,
                ),
          label: widget.trailing == null
              ? text()
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    text(),
                    const SizedBox(width: 5),
                    Opacity(
                        opacity: widget.isSelected() ? 1 : 0.4,
                        child: widget.trailing!),
                  ],
                ),
          backgroundColor: widget.isSelected()
              ? Colors.orange.shade100
              : Colors.orange.shade50,
          shape: !widget.useBorder
              ? null
              : RoundedRectangleBorder(
                  side: BorderSide(
                      color: widget.isSelected()
                          ? Colors.deepOrange
                          : Colors.transparent,
                      width: 2),
                  borderRadius: BorderRadius.circular(20),
                )),
    );
  }
}
