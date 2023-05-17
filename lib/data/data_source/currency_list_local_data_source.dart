import 'package:currency_exchange/core/infrastructure/database/index.dart';
import 'package:currency_exchange/data/base_data_source/index.dart';
import 'package:currency_exchange/data/model/currency_list/currency_list_model.dart';
import 'package:currency_exchange/data/model/currency_list/currency_model.dart';
import 'package:currency_exchange/util/constants/index.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: BaseCurrencyListLocalDataSource)
class CurrencyListLocalDataSource
    implements BaseCurrencyListLocalDataSource {
  final BaseDatabase _dbClient;

  CurrencyListLocalDataSource(this._dbClient);

  @override
  Future<CurrencyListModel> getAllSupportedCurrencies() {
    final list = _dbClient.getAll<CurrencyModel>(
      tableName: DatabaseConstants.currenciesBoxKey,
    );
    if (list == null) {
      return Future.error(Exception('No data found'));
    } else {
      final result = CurrencyListModel(currencyList: list);
      return Future.value(result);
    }
  }

  @override
  Future<void> saveSupportedCurrencies(
    CurrencyListModel currencyListModel,
  ) async {
    final keys = currencyListModel.currencyList?.map((e) => e.code).toList();
    await _dbClient.saveAll<CurrencyModel>(
      tableName: DatabaseConstants.currenciesBoxKey,
      list: currencyListModel.currencyList,
      keys: keys,
    );
  }

  @override
  Future<bool> hasCurrencyList() async {
    final list = _dbClient.getAll<CurrencyModel>(
      tableName: DatabaseConstants.currenciesBoxKey,
    );

    return list != null && list.isNotEmpty;
  }
}
