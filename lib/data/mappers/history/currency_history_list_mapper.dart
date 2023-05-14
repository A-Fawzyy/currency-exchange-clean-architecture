import 'package:currency_exchange/data/mappers/index.dart';
import 'package:currency_exchange/data/model/history/index.dart';
import 'package:currency_exchange/domain/entity/history/index.dart';

extension CurrencyHistoryListModelMapper on CurrencyHistoryListModel {
  CurrencyHistoryListEntity toDomain() {
    return CurrencyHistoryListEntity(
      currencyHistoryList: currencyHistoryList
          ?.map((model) => model.toDomain())
          .toList(),
    );
  }
}

extension CurreencyHistoryListEntityMapper on CurrencyHistoryListEntity {
  CurrencyHistoryListModel toModel() {
    return CurrencyHistoryListModel(
      currencyHistoryList: currencyHistoryList
          ?.map((entity) => entity.toModel())
          .toList(),
    );
  }
}
