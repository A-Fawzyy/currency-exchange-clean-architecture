import 'package:currency_exchange/domain/entity/history/currency_history_day_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class CurrencyHistoryListEntity extends Equatable {
  const CurrencyHistoryListEntity({
    this.currencyHistoryList,
  });

  final List<CurrencyHistoryDayEntity>? currencyHistoryList;

  @override
  List<Object?> get props => [currencyHistoryList];
}
