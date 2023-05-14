import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class CurrencyHistoryDayEntity extends Equatable {
  const CurrencyHistoryDayEntity({
    this.date,
    this.name,
    this.value,
  });

  final String? date;
  final String? name;
  final double? value;

  @override
  List<Object?> get props => [date, name, value];
}
