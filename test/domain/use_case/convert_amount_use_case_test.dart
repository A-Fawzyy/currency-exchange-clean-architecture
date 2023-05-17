import 'package:currency_exchange/core/error_handling/failure.dart';
import 'package:currency_exchange/domain/base_repo/index.dart';
import 'package:currency_exchange/domain/entity/index.dart';
import 'package:currency_exchange/domain/use_case/convert_amount_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrencyConvertorRepo extends Mock
    implements BaseCurrencyConvertorRepo {}

void main() {
  late ConvertAmountUseCase sut;
  late MockCurrencyConvertorRepo mockCurrencyRepository;

  setUp(() {
    mockCurrencyRepository = MockCurrencyConvertorRepo();
    sut = ConvertAmountUseCase(mockCurrencyRepository);
  });

  test(
      'call with valid request, in case of success; it should call the convertCurrency method of the repository and returns a valid response',
      () async {
    /// Arrange
    const request = ConvertCurrencyRequestEntity(
      from: CurrencyEntity(code: 'USD', name: 'US Dollar'),
      to: CurrencyEntity(code: 'EUR', name: 'Euro'),
      amount: 100,
    );

    const response = CurrencyConversionEntity(
      fromAmount: 100,
      conversionRate: 0.85,
      convertedAmount: 85,
    );

    when(() => mockCurrencyRepository.convertCurrency(request))
        .thenAnswer((_) async => const Right(response));

    /// Act
    final result = await sut(request);

    /// Assert
    verify(() => mockCurrencyRepository.convertCurrency(request)).called(1);
    expect(result, const Right(response));
    verifyNoMoreInteractions(mockCurrencyRepository);
  });

  test(
      'call with a valid request, in case of failure; it should return a Failure',
      () async {
    /// Arrange
    const request = ConvertCurrencyRequestEntity(
      from: CurrencyEntity(code: 'USD', name: 'US Dollar'),
      to: CurrencyEntity(code: 'EUR', name: 'Euro'),
      amount: 100,
    );
    final failure = UnexpectedFailure('Error converting currency');
    when(() => mockCurrencyRepository.convertCurrency(request))
        .thenAnswer((_) async => Left(failure));

    /// Act
    final result = await sut(request);

    /// Assert
    verify(() => mockCurrencyRepository.convertCurrency(request)).called(1);
    expect(result, Left(failure));
    verifyNoMoreInteractions(mockCurrencyRepository);
  });
}
