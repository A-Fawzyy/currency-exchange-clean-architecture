
import 'package:currency_exchange/core/infrastructure/index.dart';
import 'package:currency_exchange/data/base_data_source/index.dart';
import 'package:currency_exchange/data/model/index.dart';
import 'package:currency_exchange/util/api_constants.dart';

class CurrencyListRemoteDataSource implements BaseCurrencyListDataSource {
  final BaseNetworkClient client;

  const CurrencyListRemoteDataSource(this.client);

  /// Returns a list of all supported currencies
  ///
  /// This is to be cached in database and updated every 24 hours
  @override
  Future<CurrencyListModel> getAllSupportedCurrencies() async {
      final response = await client.get(
        ApiConstants.currencyListPath,
      );
      final currencyList =
      CurrencyListModel.fromJson(response as Map<String, dynamic>);
      return currencyList;

  }
}
