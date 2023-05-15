import 'package:currency_exchange/data/model/index.dart';
import 'package:currency_exchange/domain/entity/index.dart';

extension CurrencyConversionModelMapper on CurrencyConversionModel {
  CurrencyConversionEntity toDomain() {
    return CurrencyConversionEntity(
      fromAmount: fromAmount,
      conversionRate: conversionRate,
      convertedAmount: convertedAmount,
    );
  }
}

extension CurrencyConversionEntityMapper on CurrencyConversionEntity {
  CurrencyConversionModel toData() {
    return CurrencyConversionModel(
      fromAmount: fromAmount,
      conversionRate: conversionRate,
    );
  }
}
