import 'package:currency_exchange/data/model/currency_list/currency_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class CurrencyListModel extends Equatable {
  const CurrencyListModel({
    this.currencyList,
  });

  final List<CurrencyModel>? currencyList;

  factory CurrencyListModel.fromJson(Map<String, dynamic> map) {
    if (map['data'] == null) return const CurrencyListModel(currencyList: []);
    final data = map['data'] as Map<String, Map<String, dynamic>>;
    final list = data.values.map((e) => CurrencyModel.fromJson(e)).toList();
    return CurrencyListModel(currencyList: list);
  }

  @override
  List<Object?> get props => [currencyList];
}
