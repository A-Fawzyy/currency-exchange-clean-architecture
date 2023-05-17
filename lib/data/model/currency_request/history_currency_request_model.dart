import 'package:currency_exchange/data/model/currency_list/currency_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class HistoryCurrencyRequestModel extends Equatable {
  final CurrencyModel? from;
  final CurrencyModel? to;

  const HistoryCurrencyRequestModel({
    this.from,
    this.to,
  });

  @override
  List<Object?> get props => [
        from,
        to,
      ];
}
