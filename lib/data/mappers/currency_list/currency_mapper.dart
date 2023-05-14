

import 'package:currency_exchange/data/model/currency_list/index.dart';
import 'package:currency_exchange/domain/entity/currency_list/index.dart';

extension CurrencyModelMapper on CurrencyModel {
  CurrencyEntity toDomain() {
    return CurrencyEntity(
      symbol: symbol,
      name: name,
      symbolNative: symbolNative,
      decimalDigits: decimalDigits,
      rounding: rounding,
      code: code,
      namePlural: namePlural,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['symbol'] = symbol;
    map['name'] = name;
    map['symbol_native'] = symbolNative;
    map['decimal_digits'] = decimalDigits;
    map['rounding'] = rounding;
    map['code'] = code;
    map['name_plural'] = namePlural;
    return map;
  }
}

extension CurrencyEntityMapper on CurrencyEntity {
  CurrencyModel toModel() {
    return CurrencyModel(
      symbol: symbol,
      name: name,
      symbolNative: symbolNative,
      decimalDigits: decimalDigits,
      rounding: rounding,
      code: code,
      namePlural: namePlural,
    );
  }
}
