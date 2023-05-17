import 'package:bloc_test/bloc_test.dart';
import 'package:currency_exchange/core/base/index.dart';
import 'package:currency_exchange/core/error_handling/failure.dart';
import 'package:currency_exchange/domain/entity/index.dart';
import 'package:currency_exchange/domain/use_case/get_currency_list_use_case.dart';
import 'package:currency_exchange/presentation/home/cubits/index.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCurrencyListUseCase extends Mock implements GetCurrencyListUseCase {}

void main() {
  late CurrencyListCubit currencyListCubit;
  late MockGetCurrencyListUseCase mockGetCurrencyListUseCase;

  setUpAll(() {
    registerFallbackValue(const CurrencyListEntity());
  });

  setUp(() {
    mockGetCurrencyListUseCase = MockGetCurrencyListUseCase();
    currencyListCubit = CurrencyListCubit(mockGetCurrencyListUseCase);
  });

  tearDown(() {
    currencyListCubit.close();
  });

  group('CurrencyListCubit', () {
    final testCurrencyList = [
      const CurrencyEntity(
        code: 'USD',
        name: 'US Dollar',
      ),
      const CurrencyEntity(
        code: 'EUR',
        name: 'Euro',
      ),
    ];

    blocTest<CurrencyListCubit, CurrencyListState>(
      'getCurrencyList - success scenario',
      build: () {
        when(() => mockGetCurrencyListUseCase(any()))
            .thenAnswer((_) async => Right(CurrencyListEntity(currencyList: testCurrencyList)));
        return currencyListCubit;
      },
      act: (cubit) => cubit.getCurrencyList(),
      expect: () => [
        const CurrencyListState(status: CubitStatus.loading),
        CurrencyListState(
          status: CubitStatus.success,
          currencies: testCurrencyList,
        ),
      ],
    );

    blocTest<CurrencyListCubit, CurrencyListState>(
      'getCurrencyList - failure scenario',
      build: () {
        when(() => mockGetCurrencyListUseCase(any()))
            .thenAnswer((_) async => Left(UnexpectedFailure('Error happened')));
        return currencyListCubit;
      },
      act: (cubit) => cubit.getCurrencyList(),
      expect: () => [
        const CurrencyListState(status: CubitStatus.loading),
        const CurrencyListState(
          status: CubitStatus.failure,
          failureMessage: 'Error happened',
        ),
      ],
    );
  });
}
