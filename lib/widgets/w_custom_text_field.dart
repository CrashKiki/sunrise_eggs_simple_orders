import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(this.title, this.onChange,
      {this.initialValue,
      this.icon,
      this.textInputType = TextInputType.text,
      this.startingNumberOfLines = 1,
      this.enabled = true,
      this.validateNotEmpty = false,
      this.isDense,
      this.suffixIcon,
      this.textInputAction});
  final TextInputAction? textInputAction;
  final String? title, initialValue;
  final Function(String)? onChange;
  final Widget? icon;
  final Widget? suffixIcon;
  final TextInputType textInputType;
  final int startingNumberOfLines;
  final bool enabled;
  final bool? isDense;
  final bool validateNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        TextFormField(
          enabled: enabled,
          keyboardType: textInputType,
          initialValue: initialValue,
          validator: !validateNotEmpty
              ? null
              : (value) {
                  if (value == null || value.isEmpty) {
                    return 'Cannot be blank';
                  }
                  return null;
                },
          decoration: InputDecoration(
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade600),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            isDense: isDense,
            suffixIcon: suffixIcon,
            prefixIcon: icon,
            labelText: title,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),
          onChanged: onChange,
          textInputAction: textInputAction ?? TextInputAction.next,
          minLines: startingNumberOfLines,
          maxLines: null,
        ),
      ],
    );
  }
}
