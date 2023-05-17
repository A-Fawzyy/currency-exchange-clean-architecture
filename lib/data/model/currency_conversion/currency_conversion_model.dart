import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class CurrencyConversionModel extends Equatable {
  final double fromAmount;
  final double conversionRate;

  double get convertedAmount => fromAmount * conversionRate;

  const CurrencyConversionModel({
    required this.fromAmount,
    required this.conversionRate,
  });

  CurrencyConversionModel copyWith({
    double? fromAmount,
    double? conversionRate,
  }) {
    return CurrencyConversionModel(
      fromAmount: fromAmount ?? this.fromAmount,
      conversionRate: conversionRate ?? this.conversionRate,
    );
  }

  @override
  List<Object> get props => [
        fromAmount,
        conversionRate,
        convertedAmount,
      ];

  @override
  bool get stringify => true;
}
