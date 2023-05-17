import 'package:bloc_test/bloc_test.dart';
import 'package:currency_exchange/core/base/index.dart';
import 'package:currency_exchange/core/error_handling/failure.dart';
import 'package:currency_exchange/domain/entity/index.dart';
import 'package:currency_exchange/domain/use_case/get_currency_history_use_case.dart';
import 'package:currency_exchange/presentation/home/cubits/index.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCurrencyHistoryUseCase extends Mock implements GetCurrencyHistoryUseCase {}

void main() {
  late CurrencyHistoryCubit sut;
  late MockGetCurrencyHistoryUseCase mockGetCurrencyHistoryUseCase;

  setUpAll(() {
    registerFallbackValue(const HistoryCurrencyRequestEntity());
  });

  setUp(() {
    mockGetCurrencyHistoryUseCase = MockGetCurrencyHistoryUseCase();
    sut = CurrencyHistoryCubit(mockGetCurrencyHistoryUseCase);
  });

  tearDown(() {
    sut.close();
  });

  group('CurrencyHistoryCubit', () {
    const testCurrencyEntityFrom = CurrencyEntity(
      code: 'USD',
      name: 'US Dollar',
    );

    const testCurrencyEntityTo = CurrencyEntity(
      code: 'EUR',
      name: 'Euro',
    );

    final testCurrencyHistoryList = [
      const CurrencyHistoryDayEntity(
        date: '2022-04-02',
        name: 'EUR',
        value: 0.76,
      ),
    ];

    blocTest<CurrencyHistoryCubit, CurrencyHistoryState>(
      'getCurrencyHistory - success scenario',
      build: () {
        when(() => mockGetCurrencyHistoryUseCase(any()))
            .thenAnswer((_) async => Right(CurrencyHistoryListEntity(
          currencyHistoryList: testCurrencyHistoryList,
        ),),);
        return sut;
      },
      act: (cubit) => cubit.getCurrencyHistory(
        fromCurrency: testCurrencyEntityFrom,
        toCurrency: testCurrencyEntityTo,
      ),
      expect: () => [
        const CurrencyHistoryState(status: CubitStatus.loading),
        CurrencyHistoryState(
          status: CubitStatus.success,
          currencyHistoryList: testCurrencyHistoryList,
        ),
      ],
    );

    blocTest<CurrencyHistoryCubit, CurrencyHistoryState>(
      'getCurrencyHistory - failure scenario',
      build: () {
        when(() => mockGetCurrencyHistoryUseCase(any()))
            .thenAnswer((_) async => Left(UnexpectedFailure('Error happened')));
        return sut;
      },
      act: (cubit) => cubit.getCurrencyHistory(
        fromCurrency: testCurrencyEntityFrom,
        toCurrency: testCurrencyEntityTo,
      ),
      expect: () => [
        const CurrencyHistoryState(status: CubitStatus.loading),
        const CurrencyHistoryState(
          status: CubitStatus.failure,
          failureMessage: 'Error happened',
        ),
      ],
    );
  });
}
