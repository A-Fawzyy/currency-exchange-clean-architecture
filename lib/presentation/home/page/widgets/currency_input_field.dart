import 'package:currency_exchange/styles/colors.dart';
import 'package:flutter/material.dart';

typedef OnTextChanged = void Function(String value);

class CurrencyInputField extends StatelessWidget {
  final String? hint;
  final OnTextChanged onTextChange;

  const CurrencyInputField({
    super.key,
    this.hint,
    required this.onTextChange,
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.black.color,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(25),
      ),
    );
    return TextFormField(
      keyboardType: TextInputType.number,
      onChanged: (value) => onTextChange(value),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => value!.isEmpty ? 'Please enter an amount' : null,
      decoration: InputDecoration(
        isDense: true,
        hintText: hint,
        enabledBorder: border,
        border: border,
        focusedBorder: border.copyWith(
          borderSide: BorderSide(
            width: 2,
            color: AppColors.blue.color,
          ),
        ),
      ),
    );
  }
}
