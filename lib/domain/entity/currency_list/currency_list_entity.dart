import 'package:currency_exchange/domain/entity/currency_list/currency_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class CurrencyListEntity extends Equatable {
  const CurrencyListEntity({
    this.currencyList = const [],
  });

  final List<CurrencyEntity>? currencyList;

  @override
  List<Object?> get props => [currencyList];
}
