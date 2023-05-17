import 'package:currency_exchange/data/mappers/index.dart';
import 'package:currency_exchange/data/model/currency_request/index.dart';
import 'package:currency_exchange/domain/entity/currency_request/index.dart';

extension HistoryCurrencyRequestModelMapper on HistoryCurrencyRequestModel {
  HistoryCurrencyRequestEntity toDomain() {
    return HistoryCurrencyRequestEntity(
      from: from?.toDomain(),
      to: to?.toDomain(),
    );
  }
}

extension HistoryCurrencyRequestEntityMapper on HistoryCurrencyRequestEntity {
  HistoryCurrencyRequestModel toData() {
    return HistoryCurrencyRequestModel(
      from: from?.toData(),
      to: to?.toData(),
    );
  }
}
