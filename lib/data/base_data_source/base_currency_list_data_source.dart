import 'package:currency_exchange/data/model/index.dart';

abstract class BaseCurrencyListDataSource {
  /// Returns a list of all supported currencies
  ///
  /// This is to be cached in database and updated every 24 hours
  Future<CurrencyListModel> getAllSupportedCurrencies();
}
