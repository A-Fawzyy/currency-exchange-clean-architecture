import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'currency_model.g.dart';

@immutable
@HiveType(typeId: 0)
class CurrencyModel extends Equatable {
  const CurrencyModel({
    this.symbol,
    this.name,
    this.symbolNative,
    this.decimalDigits,
    this.rounding,
    this.code,
    this.namePlural,
  });

  final String? symbol;
  final String? name;
  final String? symbolNative;
  final int? decimalDigits;
  final int? rounding;
  @HiveField(0)
  final String? code;
  final String? namePlural;




  factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
    symbol: json['symbol'] as String?,
    name: json['name'] as String?,
    symbolNative: json['symbol_native'] as String?,
    decimalDigits: json['decimal_digits'] as int?,
    rounding: json['rounding'] as int?,
    code: json['code'] as String?,
    namePlural: json['name_plural'] as String?,
  );

  @override
  List<Object?> get props => [
        symbol,
        name,
        symbolNative,
        decimalDigits,
        rounding,
        code,
        namePlural,
      ];

  @override
  bool get stringify => true;
}
