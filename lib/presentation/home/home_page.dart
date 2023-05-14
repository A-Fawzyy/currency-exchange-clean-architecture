import 'package:currency_exchange/core/base/base_widgets/index.dart';
import 'package:currency_exchange/presentation/home/cubits/currency_list/currency_list_cubit.dart';
import 'package:currency_exchange/util/environment_keys.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: BaseBlocConsumer<CurrencyListCubit, CurrencyListState>(
            onSuccess: (context, state) => const Text('Success'),

          ),
        ),
      ),
    );
  }
}
