import 'package:currency_exchange/core/infrastructure/network/index.dart';
import 'package:currency_exchange/data/base_data_source/index.dart';
import 'package:currency_exchange/data/data_source/index.dart';
import 'package:currency_exchange/data/model/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBaseNetworkClient extends Mock implements BaseNetworkClient {}

void main() {
  late BaseCurrencyConvertorDataSource sut;
  late MockBaseNetworkClient mockClient;

  setUpAll(() {
    registerFallbackValue(<String, dynamic>{});
    registerFallbackValue('dummyPath');
  });

  setUp(() {
    mockClient = MockBaseNetworkClient();
    sut = CurrencyConvertorRemoteDataSource(mockClient);
  });

  group('CurrencyConvertorRemoteDataSource Tests', () {
    const testRequestModel = ConvertCurrencyRequestModel(
      from: CurrencyModel(
        code: 'USD',
        name: 'US Dollar',
      ),
      to: CurrencyModel(
        code: 'EUR',
        name: 'Euro',
      ),
      amount: 10,
    );

    const testCurrencyConversionModel = CurrencyConversionModel(
      fromAmount: 10,
      conversionRate: 0.8321,
    );

    test('convertCurrency should return a CurrencyConversionModel', () async {
      /// Arrange
      const testResponse = "{\"data\": { \"EUR\": 0.8321}}";
      when(
        () => mockClient.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => testResponse);

      /// Act
      final result = await sut.convertCurrency(testRequestModel);

      /// Assert
      expect(result, equals(testCurrencyConversionModel));
      verify(
        () => mockClient.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockClient);
    });

    const testHistoryRequestModel = HistoryCurrencyRequestModel(
      to: CurrencyModel(
        code: 'EUR',
        name: 'Euro',
      ),
    );
    const json = '{\"data\": { \"2023-05-14\": \{\"EUR\": 0.921461\},\"2023-05-15\": \{\"EUR\": 0.919681\},\"2023-05-16\": \{\"EUR\": 0.920361\}\}\}';

    final testCurrencyHistoryListModel =
        CurrencyHistoryListModel.fromJson(const {
      "data": {
        "2023-05-14": {
          "EUR": 0.921461,
        },
        "2023-05-15": {
          "EUR": 0.919681,
        },
        "2023-05-16": {
          "EUR": 0.920361,
        },
      },
    });

    test('getHistoryForCurrency should return a CurrencyHistoryListModel',
        () async {
      /// Arrange
      when(
        () => mockClient.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => json);

      /// Act
      final result = await sut.getHistoryForCurrency(testHistoryRequestModel);

      /// Assert
      expect(result, equals(testCurrencyHistoryListModel));
      verify(
        () => mockClient.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockClient);
    });
  });
}
