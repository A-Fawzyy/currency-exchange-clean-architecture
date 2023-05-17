import 'package:currency_exchange/data/model/history/index.dart';
import 'package:currency_exchange/domain/entity/history/index.dart';

extension CurrencyHistoryDayModelMapper on CurrencyHistoryDayModel {
  CurrencyHistoryDayEntity toDomain() {
    return CurrencyHistoryDayEntity(
      date: date,
      value: value,
    );
  }
}

extension CurrencyHistoryDayEntityMapper on CurrencyHistoryDayEntity {
  CurrencyHistoryDayModel toData() {
    return CurrencyHistoryDayModel(
      date: date,
      value: value,
    );
  }
}
