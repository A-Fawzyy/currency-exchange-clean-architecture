import 'package:bloc_test/bloc_test.dart';
import 'package:currency_exchange/domain/entity/index.dart';
import 'package:currency_exchange/presentation/home/cubits/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late CurrencyEntity currencyUSD;
  late CurrencyEntity currencyEuro;

  setUpAll(() {
    currencyUSD = const CurrencyEntity(
      code: 'USD',
      name: 'United States Dollar',
      symbol: '\$',
    );
    currencyEuro = const CurrencyEntity(
      code: 'EUR',
      name: 'Euro',
      symbol: '€',
    );
    registerFallbackValue(currencyUSD);
  });

  Future<void> getCurrencyHistory({
    required CurrencyEntity? fromCurrency,
    required CurrencyEntity? toCurrency,
  }) async {}

  group('CurrencySelectionCubit', () {
    late CurrencySelectionCubit currencySelectionCubit;

    setUp(() {
      currencySelectionCubit = CurrencySelectionCubit();
    });

    blocTest<CurrencySelectionCubit, CurrencySelectionState>(
      'selectFromCurrency sets the "from" currency',
      build: () => currencySelectionCubit,
      act: (cubit) {
        cubit.selectFromCurrency(
          currencyUSD,
          getCurrencyHistory,
        );
      },
      expect: () => [
        isA<CurrencySelectionState>().having(
          (p0) => p0.selectedFromCurrency,
          'selectedFromCurrency',
          equals(currencyUSD),
        ),
      ],
    );

    blocTest<CurrencySelectionCubit, CurrencySelectionState>(
      'selectToCurrency sets the "to" currency',
      build: () => currencySelectionCubit,
      act: (cubit) {
        cubit.selectToCurrency(
          currencyEuro,
          getCurrencyHistory,
        );
      },
      expect: () => [
        isA<CurrencySelectionState>().having(
          (p0) => p0.selectedToCurrency,
          'selectedToCurrency',
          equals(currencyEuro),
        ),
      ],
    );
  });
}
