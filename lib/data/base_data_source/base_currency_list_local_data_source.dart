import 'package:currency_exchange/data/base_data_source/index.dart';
import 'package:currency_exchange/data/model/index.dart';

abstract class BaseCurrencyListLocalDataSource
    extends BaseCurrencyListDataSource {
  Future<void> saveSupportedCurrencies(CurrencyListModel currencyListModel);

  Future<bool> hasCurrencyList();
}
