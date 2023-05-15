import 'package:currency_exchange/core/base/index.dart';
import 'package:currency_exchange/presentation/home/cubits/currency_conversion_cubit/index.dart';
import 'package:currency_exchange/presentation/home/cubits/currency_selection/index.dart';
import 'package:currency_exchange/presentation/home/page/mixins/currency_conversion_mixin.dart';
import 'package:currency_exchange/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConvertButton extends StatelessWidget with CurrencyConversionMixin {
  final GlobalKey<FormState> formKey;

  const ConvertButton({required this.formKey});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: ElevatedButton(
        onPressed: () => onConvertPressed(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.blue.color,
          foregroundColor: AppColors.white.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.white.color,
                fontWeight: FontWeight.bold,
              ),
        ),
        child: BlocBuilder<CurrencyConversionCubit, CurrencyConversionState>(
          builder: (context, state) {
            if (state.status == CubitStatus.loading) {
              return SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: AppColors.white.color,
                ),
              );
            } else {
              return const Text('Convert');
            }
          },
        ),
      ),
    );
  }

  void onConvertPressed(BuildContext context) {
    final conversionCubit = context.read<CurrencyConversionCubit>();
    if (conversionCubit.state.status != CubitStatus.loading) {
      convertAmount(
        context,
        formKey: formKey,
        amount: 10,
        onSuccess: () => context
            .read<CurrencySelectionCubit>()
            .updateShouldConvertLocally(true),
      );
    }
  }
}
