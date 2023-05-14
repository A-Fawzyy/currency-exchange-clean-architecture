import 'package:currency_exchange/core/infrastructure/index.dart';
import 'package:currency_exchange/data/base_data_source/index.dart';
import 'package:currency_exchange/data/model/index.dart';
import 'package:currency_exchange/util/api_constants.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: BaseCurrencyConvertorDataSource)
class CurrencyConvertorRemoteDataSource implements BaseCurrencyConvertorDataSource {
  final BaseNetworkClient client;

  const CurrencyConvertorRemoteDataSource(this.client);

  @override
  Future<double> convertCurrency(
    ConvertCurrencyRequestModel request,
  ) async {
      final response = await client.get(
        ApiConstants.latestCurrencyPath,
        queryParameters: {
          ApiQueryParamsKeys.baseCurrency: request.from?.code,
          ApiQueryParamsKeys.currencies: request.to?.code,
        },
      );
      final conversionRate = response['data'][request.to?.code] as double;
      final convertedAmount = (request.amount ?? 0.0) * conversionRate;
      return convertedAmount;
  }

  @override
  Future<CurrencyHistoryListModel> getHistoryForCurrency(
    HistoryCurrencyRequestModel request,
  ) async {
    final dateTo = DateTime.now();
    final dateFrom = dateTo.subtract(const Duration(days: 7));

      final response = await client.get(
        ApiConstants.currencyHistoryPath,
        queryParameters: {
          ApiQueryParamsKeys.baseCurrency: request.from?.code,
          ApiQueryParamsKeys.currencies: request.to?.code,
          ApiQueryParamsKeys.dateFrom: dateFrom.toIso8601String(),
          ApiQueryParamsKeys.dateTo: dateTo.toIso8601String(),
        },
      );
      final historyList =
          CurrencyHistoryListModel.fromJson(response as Map<String, dynamic>);
      return historyList;
  }
}
