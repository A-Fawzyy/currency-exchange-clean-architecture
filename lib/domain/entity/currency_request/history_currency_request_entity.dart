import 'package:currency_exchange/domain/entity/currency_list/index.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class HistoryCurrencyRequestEntity extends Equatable {
  final CurrencyEntity? from;
  final CurrencyEntity? to;

  const HistoryCurrencyRequestEntity({
    this.from,
    this.to,
  });

  @override
  List<Object?> get props => [
        from,
        to,
      ];
}
