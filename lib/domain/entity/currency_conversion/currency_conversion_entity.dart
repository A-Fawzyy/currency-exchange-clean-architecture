import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class CurrencyConversionEntity extends Equatable {
  final double fromAmount;
  final double conversionRate;
  final double convertedAmount;

  const CurrencyConversionEntity({
    required this.fromAmount,
    required this.conversionRate,
    required this.convertedAmount,
  });

  CurrencyConversionEntity copyWith({
    double? fromAmount,
    double? conversionRate,
    double? convertedAmount,
  }) {
    return CurrencyConversionEntity(
      fromAmount: fromAmount ?? this.fromAmount,
      conversionRate: conversionRate ?? this.conversionRate,
      convertedAmount: convertedAmount ?? this.convertedAmount,
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
