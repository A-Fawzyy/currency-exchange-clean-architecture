import 'package:currency_exchange/data/model/index.dart';

abstract class BaseCurrencyConvertorDataSource {
  Future<CurrencyConversionModel> convertCurrency(
      ConvertCurrencyRequestModel request,
  );

  Future<CurrencyHistoryListModel> getHistoryForCurrency(
      HistoryCurrencyRequestModel request,
  );
}
