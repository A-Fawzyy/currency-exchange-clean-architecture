import 'package:currency_exchange/domain/entity/currency_list/index.dart';
import 'package:currency_exchange/presentation/home/cubits/currency_selection/index.dart';
import 'package:currency_exchange/presentation/home/page/mixins/currency_conversion_mixin.dart';
import 'package:currency_exchange/presentation/home/page/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencySelectionRow extends StatelessWidget with CurrencyConversionMixin {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CurrencyPicker(
          selectedCurrency: context
              .watch<CurrencySelectionCubit>()
              .state
              .selectedFromCurrency,
          onChanged: (value) => onCurrencyFromUpdated(context, value),
        ),
        const SizedBox(width: 32),
        const Text(
          'to',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 32),
        CurrencyPicker(
          selectedCurrency:
          context.watch<CurrencySelectionCubit>().state.selectedToCurrency,
          onChanged: (value) =>
              context.read<CurrencySelectionCubit>().selectToCurrency(value),
        ),
      ],
    );
  }

  void onCurrencyFromUpdated(BuildContext context, CurrencyEntity value) {
    resetConversionState(context);
    context.read<CurrencySelectionCubit>().selectFromCurrency(value);
  }
}
