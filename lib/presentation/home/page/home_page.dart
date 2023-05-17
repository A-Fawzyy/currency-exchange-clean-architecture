import 'package:currency_exchange/core/di/dependency_injector.dart';
import 'package:currency_exchange/presentation/home/cubits/index.dart';
import 'package:currency_exchange/presentation/home/page/home_content.dart';
import 'package:currency_exchange/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CurrencyListCubit>(
          create: (context) => di()..getCurrencyList(),
        ),
        BlocProvider<CurrencySelectionCubit>(
          create: (context) => di(),
        ),
        BlocProvider<CurrencyConversionCubit>(
          create: (context) => di(),
        ),
        BlocProvider<CurrencyHistoryCubit>(
          create: (context) => di(),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white.color,
          body: const HomeContent(),
        ),
      ),
    );
  }
}
