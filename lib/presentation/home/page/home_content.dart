import 'package:currency_exchange/core/base/base_widgets/index.dart';
import 'package:currency_exchange/presentation/home/cubits/index.dart';
import 'package:currency_exchange/presentation/home/page/widgets/index.dart';
import 'package:currency_exchange/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<CurrencyListCubit, CurrencyListState>(
      onSuccess: (context, state) => Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.blue.color,
            ),
            height: MediaQuery.of(context).size.height * .3,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      'Convert any\nCurrency',
                      textAlign: TextAlign.start,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: AppColors.white.color,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                const CurrencyConverterCard(),
                const SizedBox(
                  height: 35,
                ),
            Visibility(
              visible: context
                  .watch<CurrencySelectionCubit>()
                  .state
                  .isReadyToConvert,
                  child: ConvertedAmountWidget(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
