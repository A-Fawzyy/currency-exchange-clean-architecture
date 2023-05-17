import 'package:currency_exchange/core/error_handling/failure.dart';
import 'package:currency_exchange/domain/base_repo/index.dart';
import 'package:currency_exchange/domain/entity/currency_list/currency_entity.dart';
import 'package:currency_exchange/domain/entity/currency_request/history_currency_request_entity.dart';
import 'package:currency_exchange/domain/entity/history/currency_history_day_entity.dart';
import 'package:currency_exchange/domain/entity/history/currency_history_list_entity.dart';
import 'package:currency_exchange/domain/use_case/get_currency_history_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrencyConvertorRepo extends Mock
    implements BaseCurrencyConvertorRepo {}

void main() {
  late GetCurrencyHistoryUseCase sut;
  late MockCurrencyConvertorRepo mockCurrencyRepository;

  setUp(() {
    mockCurrencyRepository = MockCurrencyConvertorRepo();
    sut = GetCurrencyHistoryUseCase(mockCurrencyRepository);
  });

  test(
      'call with valid request, in case of success; it should call the getHistoryForCurrency method of the repository and returns a valid response',
      () async {
    /// Arrange
    const historyCurrencyRequestEntity = HistoryCurrencyRequestEntity(
      from: CurrencyEntity(code: 'USD', name: 'US Dollar'),
      to: CurrencyEntity(code: 'EUR', name: 'Euro'),
    );
    const currencyHistoryListEntity = CurrencyHistoryListEntity(
      currencyHistoryList: [
        CurrencyHistoryDayEntity(
          date: '2022-04-01',
          name: 'USD/GBP',
          value: 0.75,
        ),
        CurrencyHistoryDayEntity(
          date: '2022-04-02',
          name: 'USD/GBP',
          value: 0.76,
        ),
      ],
    );
    when(
      () => mockCurrencyRepository.getHistoryForCurrency(
        historyCurrencyRequestEntity,
      ),
    ).thenAnswer(
      (_) async => const Right(
        currencyHistoryListEntity,
      ),
    );

    /// Act
    final result = await sut(historyCurrencyRequestEntity);

    /// Assert
    verify(
      () => mockCurrencyRepository.getHistoryForCurrency(
        historyCurrencyRequestEntity,
      ),
    ).called(1);
    expect(result, const Right(currencyHistoryListEntity));
    verifyNoMoreInteractions(mockCurrencyRepository);
  });

  test(
      'call with a valid request, in case of failure; it should return a Failure',
      () async {
    /// Arrange
    const historyCurrencyRequestEntity = HistoryCurrencyRequestEntity(
      from: CurrencyEntity(code: 'USD', name: 'US Dollar'),
      to: CurrencyEntity(code: 'EUR', name: 'Euro'),
    );

    final failure = UnexpectedFailure('Error fetching currency history');
    when(
      () => mockCurrencyRepository.getHistoryForCurrency(
        historyCurrencyRequestEntity,
      ),
    ).thenAnswer((_) async => Left(failure));

    /// Act
    final result = await sut(historyCurrencyRequestEntity);

    /// Assert
    expect(result, Left(failure));
    verify(
      () => mockCurrencyRepository.getHistoryForCurrency(
        historyCurrencyRequestEntity,
      ),
    ).called(1);
    verifyNoMoreInteractions(mockCurrencyRepository);
  });
}
