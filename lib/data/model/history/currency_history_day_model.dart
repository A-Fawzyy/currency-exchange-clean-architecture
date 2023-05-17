import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class CurrencyHistoryDayModel extends Equatable {
  const CurrencyHistoryDayModel({
    this.date,
    this.name,
    this.value,
  });

  final String? date;
  final String? name;
  final double? value;

  @override
  List<Object?> get props => [date, name, value];

  factory CurrencyHistoryDayModel.fromJson(Map<String, dynamic> map) {
    return CurrencyHistoryDayModel(
      date: map['date'] as String?,
      name: map['name'] as String?,
      value: map['value'] as double?,
    );
  }
}
