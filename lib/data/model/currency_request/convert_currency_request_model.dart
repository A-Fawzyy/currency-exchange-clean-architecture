import 'package:currency_exchange/data/model/currency_list/currency_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class ConvertCurrencyRequestModel extends Equatable {
  final CurrencyModel? from;
  final CurrencyModel? to;
  final double? amount;

  const ConvertCurrencyRequestModel({
    this.from,
    this.to,
    this.amount,
  });

  @override
  List<Object?> get props => [
        from,
        to,
        amount,
      ];
}
