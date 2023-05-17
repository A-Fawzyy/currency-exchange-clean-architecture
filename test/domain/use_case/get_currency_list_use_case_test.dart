import 'package:currency_exchange/core/error_handling/failure.dart';
import 'package:currency_exchange/domain/base_repo/index.dart';
import 'package:currency_exchange/domain/entity/currency_list/currency_entity.dart';
import 'package:currency_exchange/domain/entity/currency_list/currency_list_entity.dart';
import 'package:currency_exchange/domain/use_case/get_currency_list_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrencyConvertorRepo extends Mock implements BaseCurrencyConvertorRepo {}

void main() {
  late GetCurrencyListUseCase sut;
  late MockCurrencyConvertorRepo mockCurrencyRepository;

  setUp(() {
    mockCurrencyRepository = MockCurrencyConvertorRepo();
    sut = GetCurrencyListUseCase(mockCurrencyRepository);
  });

  test('call with valid request, in case of success; it should call the getCurrencyList method of the repository and returns a valid response', () async {
    /// Arrange
    final currencyList = [
      const CurrencyEntity(code: 'USD', name: 'US Dollar'),
      const CurrencyEntity(code: 'EUR', name: 'Euro'),
    ];
    final currencyListEntity = CurrencyListEntity(currencyList: currencyList);
    when(() => mockCurrencyRepository.getCurrencyList()).thenAnswer((_) async => Right(currencyListEntity));

    /// Act
    final result = await sut(null);

    /// Assert
    verify(() => mockCurrencyRepository.getCurrencyList()).called(1);
    expect(result, Right(currencyListEntity));
    verifyNoMoreInteractions(mockCurrencyRepository);
  });

  test('call with a valid request, in case of failure; it should return a Failure', () async {
    /// Arrange
    final failure = UnexpectedFailure('Error fetching currency list');
    when(() => mockCurrencyRepository.getCurrencyList()).thenAnswer((_) async => Left(failure));

    /// Act
    final result = await sut(null);

    /// Assert
    verify(() => mockCurrencyRepository.getCurrencyList()).called(1);
    expect(result, Left(failure));
    verifyNoMoreInteractions(mockCurrencyRepository);
  });
}
