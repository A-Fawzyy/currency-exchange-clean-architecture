import 'package:currency_exchange/presentation/home/cubits/index.dart';
import 'package:currency_exchange/presentation/home/page/mixins/currency_conversion_mixin.dart';
import 'package:currency_exchange/presentation/home/page/widgets/index.dart';
import 'package:currency_exchange/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CurrencyConverterCard extends HookWidget with CurrencyConversionMixin {
  const CurrencyConverterCard({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());

    return SizedBox(
      height: 225,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.white.color,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.color.withOpacity(.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Flexible(
                    child: CurrencySelectionRow(),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: formKey,
                    child: CurrencyInputField(
                      hint: 'amount',
                      onTextChange: (value) => onTextChange(context, value),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: ConvertButton(formKey: formKey),
          ),
        ],
      ),
    );
  }

  void onTextChange(BuildContext context, String value) {
    final conversionCubit = context.read<CurrencyConversionCubit>();
    conversionCubit.updateAmount(value);
  }
}
