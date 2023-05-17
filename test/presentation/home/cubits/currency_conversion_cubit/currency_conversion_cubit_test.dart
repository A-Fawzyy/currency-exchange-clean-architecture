import 'package:bloc_test/bloc_test.dart';
import 'package:currency_exchange/core/base/index.dart';
import 'package:currency_exchange/core/error_handling/failure.dart';
import 'package:currency_exchange/domain/entity/index.dart';
import 'package:currency_exchange/domain/use_case/convert_amount_use_case.dart';
import 'package:currency_exchange/presentation/home/cubits/index.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockConvertAmountUseCase extends Mock implements ConvertAmountUseCase {}

void main() {
  late CurrencyConversionCubit sut;
  late MockConvertAmountUseCase mockConvertAmountUseCase;

  setUp(() {
    mockConvertAmountUseCase = MockConvertAmountUseCase();
    sut = CurrencyConversionCubit(mockConvertAmountUseCase);
  });

  setUpAll(() {
    registerFallbackValue(
      const ConvertCurrencyRequestEntity(
        from: CurrencyEntity(code: 'USD', name: 'US Dollar'),
        to: CurrencyEntity(code: 'EUR', name: 'Euro'),
        amount: 10.0,
      ),
    );
  });

  tearDown(() {
    sut.close();
  });

  group('CurrencyConversionCubit', () {
    const testCurrencyEntityFrom = CurrencyEntity(
      code: 'USD',
      name: 'US Dollar',
    );

    const testCurrencyEntityTo = CurrencyEntity(
      code: 'EUR',
      name: 'Euro',
    );

    const testAmount = 10.0;
    final successCallback = () {};

    blocTest<CurrencyConversionCubit, CurrencyConversionState>(
      'convertCurrency - success scenario',
      build: () {
        when(() => mockConvertAmountUseCase(any())).thenAnswer(
          (_) async => const Right(
            CurrencyConversionEntity(
              convertedAmount: 8.321,
              conversionRate: 0.8321,
              fromAmount: 10.0,
            ),
          ),
        );
        return sut;
      },
      act: (cubit) => cubit
        ..convertCurrency(
          fromCurrency: testCurrencyEntityFrom,
          toCurrency: testCurrencyEntityTo,
          amount: testAmount,
          onSuccess: successCallback,
        ),
      expect: () => [
        const CurrencyConversionState(status: CubitStatus.loading),
        const CurrencyConversionState(
          fromAmount: 8.321,
          conversionRate: 0.8321,
          convertedAmount: 8.321,
          status: CubitStatus.success,
        ),
      ],
    );

    blocTest<CurrencyConversionCubit, CurrencyConversionState>(
      'convertCurrency - failure scenario',
      build: () {
        when(() => mockConvertAmountUseCase(any())).thenAnswer(
          (_) async => Left(
            UnexpectedFailure('Error happened'),
          ),
        );
        return sut;
      },
      act: (cubit) => cubit
        ..convertCurrency(
          fromCurrency: testCurrencyEntityFrom,
          toCurrency: testCurrencyEntityTo,
          amount: testAmount,
          onSuccess: successCallback,
        ),
      expect: () => [
        const CurrencyConversionState(status: CubitStatus.loading),
        const CurrencyConversionState(
          status: CubitStatus.failure,
          failureMessage: 'Error happened',
        ),
      ],
    );

    blocTest<CurrencyConversionCubit, CurrencyConversionState>(
      'resetState to initial state',
      build: () => sut,
      act: (cubit) => cubit.resetState(),
      expect: () => [const CurrencyConversionState()],
    );

    blocTest<CurrencyConversionCubit, CurrencyConversionState>(
      'updateAmount should update the proper amount value',
      build: () => sut,
      act: (cubit) => cubit.updateAmount('12.5'),
      expect: () => [
        const CurrencyConversionState(fromAmount: 12.5),
      ],
    );
  });
}
