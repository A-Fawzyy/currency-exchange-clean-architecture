import 'package:currency_exchange/presentation/home/cubits/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin CurrencyConversionMixin {


  void convertAmount(
      BuildContext context, {
        required GlobalKey<FormState> formKey,
        required double amount,
        required void Function() onSuccess,
      }) {
    final currencyConversionCubit = context.read<CurrencyConversionCubit>();
    final currencySelectionCubit = context.read<CurrencySelectionCubit>();
    final fromCurrency = currencySelectionCubit.state.selectedFromCurrency;
    final toCurrency = currencySelectionCubit.state.selectedToCurrency;
    final canConvertAmount = formKey.currentState!.validate() && amount > 0  && fromCurrency != null && toCurrency != null;
    if (canConvertAmount) {
      return currencyConversionCubit.convertCurrency(
        fromCurrency: fromCurrency,
        toCurrency: toCurrency,
        amount: amount,
        onSuccess: onSuccess,
      );
    }
  }

  void resetConversionState(BuildContext context) {
    final currencyConversionCubit = context.read<CurrencyConversionCubit>();
    currencyConversionCubit.resetState();
  }
}
