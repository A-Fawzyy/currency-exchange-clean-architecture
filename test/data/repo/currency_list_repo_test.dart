import 'package:currency_exchange/core/error_handling/index.dart';
import 'package:currency_exchange/data/base_data_source/index.dart';
import 'package:currency_exchange/data/mappers/index.dart';
import 'package:currency_exchange/data/model/index.dart';
import 'package:currency_exchange/data/repo/index.dart';
import 'package:currency_exchange/domain/entity/index.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteCurrencyListDataSource extends Mock
    implements BaseCurrencyListDataSource {}

class MockLocalCurrencyListLocalDataSource extends Mock
    implements BaseCurrencyListLocalDataSource {}

void main() {
  late CurrencyListRepo currencyListRepo;
  late MockRemoteCurrencyListDataSource mockRemoteDataSource;
  late MockLocalCurrencyListLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteCurrencyListDataSource();
    mockLocalDataSource = MockLocalCurrencyListLocalDataSource();
    currencyListRepo = CurrencyListRepo(
      remoteCurrencyListDataSource: mockRemoteDataSource,
      localCurrencyListDataSource: mockLocalDataSource,
    );
    registerFallbackValue(const CurrencyListModel());
  });

  test('getCurrencyList should return local currency list when available',
      () async {
    /// Arrange
    const currencyListDummy = CurrencyListModel(
      currencyList: [CurrencyModel(code: 'IDR', name: 'Indonesian Rupiah')],
    );
    when(() => mockLocalDataSource.getAllSupportedCurrencies())
        .thenAnswer((_) async => currencyListDummy);

    /// Act
    final result = await currencyListRepo.getCurrencyList();

    final expectedList =
        currencyListDummy.currencyList?.map((e) => e.toDomain()).toList();

    /// Assert
    expect(
      result,
      equals(
        right(
          CurrencyListEntity(currencyList: expectedList),
        ),
      ),
    );
    verify(() => mockLocalDataSource.getAllSupportedCurrencies()).called(1);
    verifyNever(() => mockRemoteDataSource.getAllSupportedCurrencies());
    verifyNoMoreInteractions(mockLocalDataSource);
  });

  test(
      'getCurrencyList should return remote currency list when local data is unavailable',
      () async {
    /// Arrange
    when(() => mockLocalDataSource.getAllSupportedCurrencies())
        .thenThrow(Exception());

    const currencyListDummy = CurrencyListModel(
      currencyList: [CurrencyModel(code: 'IDR', name: 'Indonesian Rupiah')],
    );
    when(() => mockRemoteDataSource.getAllSupportedCurrencies())
        .thenAnswer((_) async => currencyListDummy);
    when(() => mockLocalDataSource.saveSupportedCurrencies(any()))
        .thenAnswer((_) async {});

    /// Act
    final result = await currencyListRepo.getCurrencyList();

    /// Assert
    final expectedList =
        currencyListDummy.currencyList?.map((e) => e.toDomain()).toList();
    expect(
      result,
      equals(
        right(
          CurrencyListEntity(currencyList: expectedList),
        ),
      ),
    );
    verify(() => mockLocalDataSource.getAllSupportedCurrencies()).called(1);
    verify(() => mockRemoteDataSource.getAllSupportedCurrencies()).called(1);
    verify(() => mockLocalDataSource.saveSupportedCurrencies(any())).called(1);
    verifyNoMoreInteractions(mockLocalDataSource);
    verifyNoMoreInteractions(mockRemoteDataSource);
  });

  test(
      'getCurrencyList should return UnexpectedFailure when both local and remote data fail',
      () async {
    /// Arrange
    when(() => mockLocalDataSource.getAllSupportedCurrencies())
        .thenThrow(Exception());
    when(() => mockRemoteDataSource.getAllSupportedCurrencies())
        .thenThrow(Exception());

    /// Act
    final result = await currencyListRepo.getCurrencyList();

    /// Assert
    expect(result.isLeft(), true);
    result.fold(
      (failure) => expect(failure, isA<UnexpectedFailure>()),
      (value) => fail('Expecting a Failure, got a Right value'),
    );
    verify(() => mockLocalDataSource.getAllSupportedCurrencies()).called(1);
    verify(() => mockRemoteDataSource.getAllSupportedCurrencies()).called(1);
    verifyNoMoreInteractions(mockLocalDataSource);
    verifyNoMoreInteractions(mockRemoteDataSource);
  });
}
