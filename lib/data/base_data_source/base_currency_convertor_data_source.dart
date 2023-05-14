import 'package:currency_exchange/data/model/index.dart';

abstract class BaseCurrencyConvertorDataSource {
  Future<double> convertCurrency(
      ConvertCurrencyRequestModel request,
  );

  Future<CurrencyHistoryListModel> getHistoryForCurrency(
      HistoryCurrencyRequestModel request,
  );
}
