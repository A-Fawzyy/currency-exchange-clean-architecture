import 'package:currency_exchange/data/mappers/index.dart';
import 'package:currency_exchange/data/model/index.dart';
import 'package:currency_exchange/domain/entity/index.dart';

extension CurrencyListModelMapper on CurrencyListModel {
  CurrencyListEntity toDomain() {
    return CurrencyListEntity(
      currencyList: currencyList?.map((model) => model.toDomain()).toList(),
    );
  }
}

extension CurrencyListEntityMapper on CurrencyListEntity {
  CurrencyListModel toData() {
    return CurrencyListModel(
      currencyList: currencyList?.map((entity) => entity.toData()).toList(),
    );
  }
}
