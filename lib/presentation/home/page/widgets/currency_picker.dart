import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_exchange/domain/entity/currency_list/currency_entity.dart';
import 'package:currency_exchange/presentation/home/cubits/currency_list_cubit/currency_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyPicker extends StatelessWidget {
  const CurrencyPicker({
    super.key,
    required this.selectedCurrency,
    required this.onChanged,
  });

  final CurrencyEntity? selectedCurrency;
  final void Function(CurrencyEntity currencyEntity) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<CurrencyEntity>(
        value: selectedCurrency,
        items: context
            .watch<CurrencyListCubit>()
            .state
            .currencies
            .map(
              (item) => DropdownMenuItem<CurrencyEntity>(
                value: item,
                child: Row(
                  children: [
                    CachedNetworkImage(imageUrl: item.flagUrl),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      '${item.code}',
                    ),
                  ],
                ),
              ),
            )
            .toList(),
        onChanged: (currencyEntity) => onChanged.call(currencyEntity!),
      ),
    );
  }
}
