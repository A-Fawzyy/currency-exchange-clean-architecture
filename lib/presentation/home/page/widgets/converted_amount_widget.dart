import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_exchange/presentation/home/cubits/index.dart';
import 'package:currency_exchange/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConvertedAmountWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currencySelectionState = context.watch<CurrencySelectionCubit>().state;
    final currencyConversionState = context.watch<CurrencyConversionCubit>().state;
    final selectedToCurrency = currencySelectionState.selectedToCurrency;
    final selectedFromCurrency = currencySelectionState.selectedFromCurrency;
    final convertedAmount = currencyConversionState.convertedAmount?.toStringAsFixed(2) ?? '0.00';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CachedNetworkImage(
          imageUrl: selectedToCurrency?.flagUrl ?? '',
          height: 35,
        ),
        Column(
          children: [
            Text(
              convertedAmount,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.black.color,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '1 ${selectedFromCurrency?.code} = $convertedAmount ${selectedToCurrency?.code}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
