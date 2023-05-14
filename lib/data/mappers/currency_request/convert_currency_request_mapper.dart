import 'package:currency_exchange/data/mappers/index.dart';
import 'package:currency_exchange/data/model/currency_request/index.dart';
import 'package:currency_exchange/domain/entity/currency_request/index.dart';

extension ConvertCurrencyRequestModelMapper on ConvertCurrencyRequestModel {
  ConvertCurrencyRequestEntity toDomain() {
    return ConvertCurrencyRequestEntity(
      from: from?.toDomain(),
      to: to?.toDomain(),
      amount: amount,
    );
  }
}

extension ConvertCurrencyRequestEntityMapper on ConvertCurrencyRequestEntity {
  ConvertCurrencyRequestModel toModel() {
    return ConvertCurrencyRequestModel(
      from: from?.toModel(),
      to: to?.toModel(),
      amount: amount,
    );
  }
}
