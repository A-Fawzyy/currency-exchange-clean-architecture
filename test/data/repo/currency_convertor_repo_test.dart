import 'package:currency_exchange/core/error_handling/failure.dart';
import 'package:currency_exchange/data/base_data_source/index.dart';
import 'package:currency_exchange/data/mappers/index.dart';
import 'package:currency_exchange/data/model/index.dart';
import 'package:currency_exchange/data/repo/index.dart';
import 'package:currency_exchange/domain/base_repo/index.dart';
import 'package:currency_exchange/domain/entity/index.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrencyConvertorDataSource extends Mock
    implements BaseCurrencyConvertorDataSource {}

class MockCurrencyListRepo extends Mock implements BaseCurrencyListRepo {}

void main() {
  late CurrencyConvertorRepo sut;
  late MockCurrencyConvertorDataSource mockDataSource;
  late MockCurrencyListRepo mockCurrencyListRepo;

  setUp(() {
    mockDataSource = MockCurrencyConvertorDataSource();
    mockCurrencyListRepo = MockCurrencyListRepo();
    sut = CurrencyConvertorRepo(mockDataSource, mockCurrencyListRepo);
  });

  setUpAll(() {
    registerFallbackValue(
      const ConvertCurrencyRequestEntity(),
    );
    registerFallbackValue(
      const ConvertCurrencyRequestModel(),
    );
    registerFallbackValue(
      const HistoryCurrencyRequestEntity(),
    );
    registerFallbackValue(
      const HistoryCurrencyRequestModel(),
    );
  });

  const conversionDummyRequest = ConvertCurrencyRequestEntity(
    from: CurrencyEntity(code: 'USD', name: 'US Dollar'),
    to: CurrencyEntity(code: 'EUR', name: 'Euro'),
    amount: 10,
  );

  const historyDummyRequest = HistoryCurrencyRequestEntity(
    from: CurrencyEntity(code: 'USD', name: 'US Dollar'),
    to: CurrencyEntity(code: 'EUR', name: 'Euro'),
  );

  test('getCurrencyList should call the currencyListRepository to get data',
      () async {
    /// Arrange
    when(() => mockCurrencyListRepo.getCurrencyList())
        .thenAnswer((_) async => const Right(CurrencyListEntity()));

    /// Act
    final result = await sut.getCurrencyList();

    /// Assert
    expect(
      result,
      equals(
        const Right(
          CurrencyListEntity(),
        ),
      ),
    );
    verify(() => mockCurrencyListRepo.getCurrencyList()).called(1);
    verifyZeroInteractions(mockDataSource);
    verifyNoMoreInteractions(mockCurrencyListRepo);
  });

  group('convertCurrency', () {
    const conversionDummyResponse = CurrencyConversionEntity(
      fromAmount: 10,
      conversionRate: 0.8465,
      convertedAmount: 8.465,
    );

    test(
        'convertCurrency should return conversion result when data source returns data',
        () async {
      /// Arrange
      when(() => mockDataSource.convertCurrency(any())).thenAnswer(
        (invocation) async => conversionDummyResponse.toData(),
      );

      /// Act
      final result =
          await sut.convertCurrency(conversionDummyRequest);

      /// Assert
      expect(result, equals(const Right(conversionDummyResponse)));
      verify(
        () => mockDataSource.convertCurrency(conversionDummyRequest.toData()),
      ).called(1);
      verifyNoMoreInteractions(mockDataSource);
      verifyZeroInteractions(mockCurrencyListRepo);
    });

    test(
        'convertCurrency should return UnexpectedFailure when an exception is thrown',
        () async {
      /// Arrange
      when(() => mockDataSource.convertCurrency(any())).thenThrow(Exception());

      /// Act
      final result =
          await sut.convertCurrency(conversionDummyRequest);

      /// Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<UnexpectedFailure>()),
        (value) => fail('Expecting a Failure, got a Right value'),
      );
      verify(
        () => mockDataSource.convertCurrency(conversionDummyRequest.toData()),
      ).called(1);
      verifyNoMoreInteractions(mockDataSource);
      verifyNever(() => mockCurrencyListRepo.getCurrencyList());
    });
  });

  group('getHistoryForCurrency', () {
    const historyListResponseDummy = CurrencyHistoryListEntity();

    test(
        'getHistoryForCurrency should return history result when data source returns data',
        () async {
      /// Arrange
      when(() => mockDataSource.getHistoryForCurrency(any())).thenAnswer(
        (invocation) async => historyListResponseDummy.toData(),
      );

      /// Act
      final result =
          await sut.getHistoryForCurrency(historyDummyRequest);

      /// Assert
      expect(result, equals(right(historyListResponseDummy)));
      verify(
        () => mockDataSource.getHistoryForCurrency(
          historyDummyRequest.toData(),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockDataSource);
      verifyNever(() => mockCurrencyListRepo.getCurrencyList());
    });

    test(
        'getHistoryForCurrency should return UnexpectedFailure when an exception is thrown',
        () async {
      /// Arrange
      when(() => mockDataSource.getHistoryForCurrency(any()))
          .thenThrow(Exception());

      /// Act
      final result =
          await sut.getHistoryForCurrency(historyDummyRequest);

      /// Assert
      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<UnexpectedFailure>()),
        (value) => fail('Expecting a Failure, got a Right value'),
      );
      verify(
        () => mockDataSource.getHistoryForCurrency(
          historyDummyRequest.toData(),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockDataSource);
      verifyNever(() => mockCurrencyListRepo.getCurrencyList());
    });
  });
}
